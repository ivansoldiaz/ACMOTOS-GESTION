# acmotos-gestion — Guía para Claude Code

Panel admin interno de ACMOTOS (Laravel 11 + Filament 3) que **reemplaza progresivamente** las ~60 tools PHP sueltas que viven en `C:\Users\ACMOTOS\PhpstormProjects\ACMOTOS-PROD\custom-scripts\`. Migración incremental: las tools viejas siguen operativas hasta que cada una se porte aquí.

## Stack

- Laravel 11 + Filament 3.3
- Spatie Permission + Bezhansalleh Filament Shield (RBAC con prefijo `gestion_`)
- Spatie ActivityLog + rmsramos/activitylog (auditoría UI)
- PHP 8.3 (local: `C:\php83\php.exe`; prod: `/opt/plesk/php/8.3/bin/php`)

## Paths

- **Local**: `C:\Users\ACMOTOS\PhpstormProjects\acmotos-gestion` (Windows + PhpStorm)
- **Prod**: `/var/www/vhosts/gestion.acmotos.com/httpdocs/` (VPS Vultr + Plesk Obsidian)
- **URL**: https://gestion.acmotos.com/admin
- **Repo**: https://github.com/ivansoldiaz/ACMOTOS-GESTION, rama única `main`
- **PS source de referencia**: `C:\Users\ACMOTOS\PhpstormProjects\ACMOTOS-PROD\` (`classes/`, `controllers/`, `modules/`, `override/`) — para consultar al replicar comportamiento nativo en Services.

## Dos conexiones DB

- `mysql` (default) → `gestion_acm` en MariaDB local del VPS Plesk. Todo lo propio de Laravel vive aquí (users, sesiones, cache, jobs, `gestion_roles`, `gestion_permissions`, `gestion_activity_log`).
- `prestashop` → DB remota del servidor PrestaShop (`104.238.189.114`), vía **túnel SSH** a `127.0.0.1:3307` en el VPS Gestion (autossh + systemd, `Restart=always`). Usuario `gestion_app` con `SELECT, INSERT, UPDATE, DELETE, SHOW VIEW` sobre `prestashop.*`.

**Gotchas del túnel / DB prestashop:**
- El MariaDB del servidor PS corre en Docker (`prod-mysql`, mariadb:10.4). El docker-proxy oculta la IP real — conexiones llegan como `172.18.0.1` (bridge). Por eso la GRANT es `'gestion_app'@'%'`.
- Password `gestion_app` guardada en `/root/gestion_app_mysql.pass` del servidor PS.
- Password root MariaDB: `docker exec prod-mysql printenv MYSQL_ROOT_PASSWORD` (NO es ningún placeholder).
- Warning `Found option without preceding group in config file: /etc/mysql/conf.d/old-conf.cnf` → inocuo, el SQL se ejecuta igual.
- MariaDB no soporta `utf8mb4_0900_ai_ci`. En `.env` de `acmotos-gestion`: `DB_CHARSET=utf8mb4`, `DB_COLLATION=utf8mb4_unicode_ci`.

## Regla de escritura sobre tablas PrestaShop

**Split estricto según tipo de tabla:**

- **Custom ACMOTOS** (`ps_ac_*`, `py_*`): CRUD completo con Filament Resource. Son tablas propias, reglas propias. Ejemplo: `CategoryBannerConfigResource` sobre `ps_ac_category_banners_config`.
- **Nativas PrestaShop** (`ps_product`, `ps_order`, `ps_stock_available`, `ps_category`, …): **NUNCA** un Resource abierto. Rompería hooks de módulos, stock moves, caché e índice de búsqueda.
  - Lecturas: Eloquent directo sobre modelos readonly en `App\Models\Prestashop\*`.
  - Escrituras: **solo** vía `App\Services\Prestashop\*` invocados desde Filament Pages de proceso, con activity log del input y filas afectadas.
  - `acmotos-gestion` NO puede invocar clases PHP de PrestaShop (viven en otro VPS). Los Services **replican** lo que hace la clase nativa leyendo su código de referencia en `ACMOTOS-PROD/classes/`.

**Antes de escribir un Service de escritura sobre tabla nativa**, leer el método original en:
- `ACMOTOS-PROD/classes/ObjectModel.php` (base `add`/`update`/`delete`, multishop `_shop`, `date_upd`)
- `ACMOTOS-PROD/classes/Product.php`, `Category.php`, `Manufacturer.php`, `Feature.php`, `Combination.php`
- `ACMOTOS-PROD/classes/stock/StockAvailable.php` + `stock/StockMvt.php`
- `ACMOTOS-PROD/classes/Search.php` (reindexado `ps_search_index` / `ps_search_word`)
- `ACMOTOS-PROD/override/classes/` (overrides custom — pueden cambiar el comportamiento nativo)
- `ACMOTOS-PROD/modules/` (módulos custom: Puig, banners, …)

## Estructura código del proyecto

```
app/
  Filament/
    Resources/          # CRUDs (1 Resource = 1 tool CRUD). Ej: CategoryBannerConfigResource/
      {Resource}/
        RelationManagers/  # sub-tablas relacionadas
        Pages/             # List/Create/Edit
    Pages/              # Tools de proceso (ej: CompatUppercasePage) — no CRUD puro
    Widgets/            # Métricas dashboard
  Models/
    Prestashop/         # Modelos sobre DB prestashop (extienden PrestashopModel)
    User.php            # DB mysql default
  Policies/
    Prestashop/         # Policies generadas por shield:generate
  Services/
    Prestashop/         # Servicios para escrituras sobre tablas nativas PS
    OpenAI/             # Cliente OpenAI (crear al migrar primera tool que lo use)
config/
  banners.php           # config custom
  filament-shield.php   # navigation_group etc.
  database.php          # dos conexiones: mysql + prestashop
```

**Modelo base PrestaShop:**
```php
abstract class PrestashopModel extends Model
{
    protected $connection = 'prestashop';
    public $timestamps = false;
}
```
(Sin guard readonly — necesitamos escribir en tablas custom ACMOTOS.)

**LanguageService:** constantes `LANG_ES=1`, `LANG_EN=3`, `ID_SHOP=1`.

## Deploy

Flujo:
1. Local: `git add`, `git commit`, **no push** (el usuario lo hace manual).
2. Usuario pushea a `main`.
3. Plesk Git integration auto-pull a `/httpdocs`.
4. Usuario (o admin) ejecuta por SSH: `/root/deploy-gestion.sh`.

Contenido de `/root/deploy-gestion.sh`:
```bash
#!/bin/bash
set -e
cd /var/www/vhosts/gestion.acmotos.com/httpdocs
/opt/plesk/php/8.3/bin/php /opt/psa/var/modules/composer/composer.phar install --no-dev --optimize-autoloader --no-interaction
/opt/plesk/php/8.3/bin/php artisan migrate --force
/opt/plesk/php/8.3/bin/php artisan config:clear
/opt/plesk/php/8.3/bin/php artisan config:cache
/opt/plesk/php/8.3/bin/php artisan route:cache
/opt/plesk/php/8.3/bin/php artisan view:cache
chown -R gestion.acmotos.com_yd93u2eknz9:psacln /var/www/vhosts/gestion.acmotos.com/httpdocs
```

Tras el primer deploy de un Resource nuevo, además: `shield:generate --option=policies_and_permissions` (en prod — necesita DB) y `shield:super-admin --user=1` para reasignar permisos al super_admin.

**Gotcha Shield local:** `shield:generate` por defecto toca DB. En local usar `--option=policies` solo (crea el fichero). El `--option=policies_and_permissions` corre solo en prod.

**Gotcha Filament assets:** `public/css/{filament,rmsramos}` y `public/js/filament` están en `.gitignore` — se regeneran en cada deploy.

## Workflow Git (reglas del usuario)

- Trabajar directo sobre `main`. **No** crear worktrees ni ramas.
- **Nunca** hacer `git push`. El usuario lo hace manualmente.
- Crear commits cuando se pida (o al terminar un bloque coherente), siempre con HEREDOC y Co-Authored-By.

## Panel Filament

- Navigation groups declarados en `AdminPanelProvider`: `['Contenidos web', 'Tablas de compatibilidad', 'SEO / Redirecciones', 'Administración']`.
- Shield: el `navigation_group` del `config/filament-shield.php` es un **booleano** ("¿usar grupo?"), no el nombre. El nombre del grupo de Roles viene de la traducción `filament-shield::filament-shield.nav.group`, sobrescrita en `lang/vendor/filament-shield/{en,es}/filament-shield.php` a `Administración`.
- ActivityLog: `->navigationGroup('Administración')` sí funciona en el plugin.
- Usuario admin prod: `i.sol@acmotos.com` con rol `super_admin`.

## Estado actual (2026-04-23)

**Completado:**
- Fase 0: infra prod, login, RBAC, activity log.
- Fase 1-A: conexión `prestashop` + túnel SSH + modelos base + LanguageService.
- Fase 1-B: UserResource + navigation groups.

**En curso:**
- Fase 2 piloto CRUD: `CategoryBannerConfigResource` (banners de categorías → tabla `ps_ac_category_banners_config` + `_links` + `_links_lang`). CRUD operativo en lista; debugging de error al abrir Edit (RelationManager `links`).

**Siguiente:**
- Validar CRUD completo en prod.
- Fase 2 piloto proceso: `CompatUppercasePage` (port de `custom-scripts/tablas-compatibilidad-modelos-mayusculas.php`).
- Crear `App\Services\OpenAI\Client` al migrar la primera tool que lo necesite.

## Backlog seguridad

- API key OpenAI y credenciales DB remota de migración PS1.6→PS8.2 están hardcodeadas en `custom-scripts/templates-manage-ajax.php` y `migration-web-ajax.php`. **Rotar** antes de portar la primera tool que use OpenAI — deben considerarse comprometidas (están en git history del repo PS).
- MariaDB del servidor PrestaShop publica `0.0.0.0:3306` a internet. Rebinding a `127.0.0.1:3306` en docker-compose pendiente (el túnel SSH seguirá funcionando porque va al `127.0.0.1` del propio container host).

## Plan completo

Vive en `C:\Users\ACMOTOS\.claude\plans\ahora-mismo-tengo-una-robust-mochi.md`.

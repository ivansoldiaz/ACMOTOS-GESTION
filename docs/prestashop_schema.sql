SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `contenidos_tablas_modelos` AS SELECT
 1 AS `id_fsch_block`,
  1 AS `name`,
  1 AS `content_es`,
  1 AS `content_en` */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `datastudio_ventas` AS SELECT
 1 AS `id_pedido`,
  1 AS `ref_pedido`,
  1 AS `transportista`,
  1 AS `idioma`,
  1 AS `estado`,
  1 AS `forma_pago`,
  1 AS `total_descuento_con_iva`,
  1 AS `total_descuento_sin_iva`,
  1 AS `total_pagado_con_iva`,
  1 AS `total_pagado_sin_iva`,
  1 AS `total_pagado_productos_con_iva`,
  1 AS `total_pagado_productos_sin_iva`,
  1 AS `total_pagado_envio_con_iva`,
  1 AS `total_pagado_envio_sin_iva`,
  1 AS `numero_factura`,
  1 AS `numero_albaran`,
  1 AS `fecha_factura`,
  1 AS `fecha_pedido` */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `export_tabla_filtros` AS SELECT
 1 AS `id_fsch_block`,
  1 AS `name` */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucas_domain` (
  `domain_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(128) NOT NULL,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `lucas_domain_domain_uindex` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucas_domain_selector` (
  `selector_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `selector_order` int(11) NOT NULL,
  `selector` varchar(128) NOT NULL,
  `attr` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`selector_id`),
  KEY `lucas_domain_selector_lucas_domain_domain_id_fk` (`domain_id`),
  CONSTRAINT `lucas_domain_selector_lucas_domain_domain_id_fk` FOREIGN KEY (`domain_id`) REFERENCES `lucas_domain` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `lucas_domain_selectors` AS SELECT
 1 AS `domain_id`,
  1 AS `domain`,
  1 AS `selector_id`,
  1 AS `selector_order`,
  1 AS `attr` */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `lucas_prices_report` AS SELECT
 1 AS `id_product`,
  1 AS `name`,
  1 AS `domain`,
  1 AS `price` */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucas_product_date` (
  `id_product` int(10) unsigned NOT NULL,
  `routes_search_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  CONSTRAINT `lucas_product_date_ps_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucas_route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `domain_id` int(11) NOT NULL,
  `path` text NOT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT 1,
  `last_scan_on` datetime DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`route_id`),
  KEY `lucas_route_lucas_domain_domain_id_fk` (`domain_id`),
  KEY `lucas_route_ps_product_id_product_fk` (`id_product`),
  KEY `lucas_route_is_current_last_scan_on_index` (`is_current`,`last_scan_on`),
  CONSTRAINT `lucas_route_lucas_domain_domain_id_fk` FOREIGN KEY (`domain_id`) REFERENCES `lucas_domain` (`domain_id`),
  CONSTRAINT `lucas_route_ps_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9314 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lucas_route_price` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `route_id` int(11) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `price` decimal(13,2) DEFAULT NULL,
  PRIMARY KEY (`price_id`),
  UNIQUE KEY `lucas_route_price_route_id_price_created_on_uindex` (`created_on`,`route_id`,`price`),
  KEY `lucas_route_price_created_on_index` (`created_on`),
  KEY `lucas_route_price_lucas_route_route_id_fk` (`route_id`),
  KEY `lucas_route_price_created_on_index_2` (`created_on`),
  CONSTRAINT `lucas_route_price_lucas_route_route_id_fk` FOREIGN KEY (`route_id`) REFERENCES `lucas_route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3021 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `pending_billing` AS SELECT
 1 AS `id_order`,
  1 AS `current_state`,
  1 AS `created_at`,
  1 AS `billed`,
  1 AS `billed_at`,
  1 AS `reimbursed`,
  1 AS `reimbursed_at` */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `physical_stock` AS SELECT
 1 AS `id_stock`,
  1 AS `id_product`,
  1 AS `id_product_attribute`,
  1 AS `reference`,
  1 AS `sum_usable_quantity` */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `pr_cat_tags` AS SELECT
 1 AS `id_fsch_block`,
  1 AS `name`,
  1 AS `active` */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_category_banners_config` (
  `id_config` int(11) NOT NULL AUTO_INCREMENT,
  `id_category` int(11) NOT NULL,
  `template` varchar(50) NOT NULL DEFAULT 'Banner fijo',
  `date_add` datetime NOT NULL DEFAULT current_timestamp(),
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_config`),
  UNIQUE KEY `id_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_category_banners_links` (
  `id_link` int(11) NOT NULL AUTO_INCREMENT,
  `id_config` int(11) NOT NULL,
  `id_target_category` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL DEFAULT current_timestamp(),
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_link`),
  KEY `id_config` (`id_config`),
  CONSTRAINT `ps_ac_category_banners_links_ibfk_1` FOREIGN KEY (`id_config`) REFERENCES `ps_ac_category_banners_config` (`id_config`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3554 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_category_banners_links_lang` (
  `id_link` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `anchor_text` varchar(255) NOT NULL,
  PRIMARY KEY (`id_link`,`id_lang`),
  CONSTRAINT `ps_ac_category_banners_links_lang_ibfk_1` FOREIGN KEY (`id_link`) REFERENCES `ps_ac_category_banners_links` (`id_link`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_compat_tables_category` (
  `id_compat_cat` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_compat_cat`),
  KEY `fk_ac_compat_tables_category_category` (`id_category`),
  CONSTRAINT `fk_ac_compat_tables_category_category` FOREIGN KEY (`id_category`) REFERENCES `ps_category` (`id_category`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_compat_tables_product` (
  `id_compat` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `brand` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `years` varchar(255) NOT NULL,
  `searchable` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_compat`),
  KEY `fk_ac_compat_tables_product_product` (`id_product`),
  FULLTEXT KEY `idx_ac_compat` (`brand`,`model`,`years`),
  CONSTRAINT `fk_ac_compat_tables_product_product` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5236803 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_compat_tables_product_info` (
  `id_info` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `additional_info` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_info`),
  UNIQUE KEY `uniq_product_lang` (`id_product`,`id_lang`),
  KEY `fk_product_info_lang` (`id_lang`),
  CONSTRAINT `fk_product_info_lang` FOREIGN KEY (`id_lang`) REFERENCES `ps_lang` (`id_lang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_info_product` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=329 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_product_discounts` (
  `id_specific_price` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_product_attribute` int(11) NOT NULL DEFAULT 0,
  `quantity_left` int(11) NOT NULL,
  `redeem` tinyint(1) NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `date_redeemed` datetime DEFAULT NULL,
  PRIMARY KEY (`id_specific_price`),
  KEY `idx_id_product` (`id_product`),
  KEY `idx_product_attr` (`id_product`,`id_product_attribute`),
  KEY `idx_active_by_prod` (`id_product`,`id_product_attribute`,`redeem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_puig_cat_sync` (
  `id_sync` int(11) NOT NULL AUTO_INCREMENT,
  `id_category` int(11) NOT NULL,
  `last_update` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_sync`),
  UNIQUE KEY `id_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_puig_outlet` (
  `id_ac_puig_outlet` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_ac_puig_outlet`),
  UNIQUE KEY `uk_reference` (`reference`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ac_webhooks` (
  `id_ac_webhooks` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_ac_webhooks`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_access` (
  `id_profile` int(10) unsigned NOT NULL,
  `id_tab` int(10) unsigned NOT NULL,
  `view` int(11) NOT NULL,
  `add` int(11) NOT NULL,
  `edit` int(11) NOT NULL,
  `delete` int(11) NOT NULL,
  PRIMARY KEY (`id_profile`,`id_tab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_accessory` (
  `id_product_1` int(10) unsigned NOT NULL,
  `id_product_2` int(10) unsigned NOT NULL,
  KEY `accessory_product` (`id_product_1`,`id_product_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_address` (
  `id_address` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned NOT NULL,
  `id_state` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned NOT NULL DEFAULT 0,
  `id_manufacturer` int(10) unsigned NOT NULL DEFAULT 0,
  `id_supplier` int(10) unsigned NOT NULL DEFAULT 0,
  `id_warehouse` int(10) unsigned NOT NULL DEFAULT 0,
  `alias` varchar(32) NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `lastname` varchar(32) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `address1` varchar(128) NOT NULL,
  `address2` varchar(128) DEFAULT NULL,
  `postcode` varchar(12) DEFAULT NULL,
  `city` varchar(64) NOT NULL,
  `other` text DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `phone_mobile` varchar(32) DEFAULT NULL,
  `vat_number` varchar(32) DEFAULT NULL,
  `dni` varchar(16) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_address`),
  KEY `address_customer` (`id_customer`),
  KEY `id_country` (`id_country`),
  KEY `id_state` (`id_state`),
  KEY `id_manufacturer` (`id_manufacturer`),
  KEY `id_supplier` (`id_supplier`),
  KEY `id_warehouse` (`id_warehouse`)
) ENGINE=InnoDB AUTO_INCREMENT=21419 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_address_format` (
  `id_country` int(10) unsigned NOT NULL,
  `format` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_alias` (
  `id_alias` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  `search` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_alias`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attachment` (
  `id_attachment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file` varchar(40) NOT NULL,
  `file_name` varchar(128) NOT NULL,
  `file_size` bigint(10) unsigned NOT NULL DEFAULT 0,
  `mime` varchar(128) NOT NULL,
  PRIMARY KEY (`id_attachment`)
) ENGINE=InnoDB AUTO_INCREMENT=2213 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attachment_lang` (
  `id_attachment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id_attachment`,`id_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=2213 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute` (
  `id_attribute` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_attribute_group` int(10) unsigned NOT NULL,
  `color` varchar(32) DEFAULT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_attribute`),
  KEY `attribute_group` (`id_attribute_group`)
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_group` (
  `id_attribute_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_color_group` tinyint(1) NOT NULL DEFAULT 0,
  `group_type` enum('select','radio','color') NOT NULL DEFAULT 'select',
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_attribute_group`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_group_lang` (
  `id_attribute_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `public_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_attribute_group`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_group_shop` (
  `id_attribute_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_attribute_group`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_impact` (
  `id_attribute_impact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_attribute` int(11) unsigned NOT NULL,
  `weight` decimal(20,6) NOT NULL,
  `price` decimal(17,2) NOT NULL,
  PRIMARY KEY (`id_attribute_impact`),
  UNIQUE KEY `id_product` (`id_product`,`id_attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=33364 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_lang` (
  `id_attribute` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id_attribute`,`id_lang`),
  KEY `id_lang` (`id_lang`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_shop` (
  `id_attribute` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_attribute`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_bestkit_pfeatures` (
  `id_feature` int(10) unsigned NOT NULL,
  `is_color` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `label` text DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_feature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_bestkit_pfeatures_color` (
  `id_feature_value` int(10) unsigned NOT NULL,
  `hex_value` varchar(15) NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_feature_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_bridgeconnector_failed_login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142687 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_bridgeconnector_session_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_key` varchar(100) NOT NULL,
  `date_added` datetime NOT NULL,
  `last_activity` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=615 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier` (
  `id_carrier` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_reference` int(10) unsigned NOT NULL,
  `id_tax_rules_group` int(10) unsigned DEFAULT 0,
  `name` varchar(64) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `shipping_handling` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `range_behavior` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `is_module` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `is_free` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `shipping_external` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `need_range` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `external_module_name` varchar(64) DEFAULT NULL,
  `shipping_method` int(2) NOT NULL DEFAULT 0,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  `max_width` int(10) DEFAULT 0,
  `max_height` int(10) DEFAULT 0,
  `max_depth` int(10) DEFAULT 0,
  `max_weight` decimal(20,6) DEFAULT 0.000000,
  `grade` int(10) DEFAULT 0,
  PRIMARY KEY (`id_carrier`),
  KEY `deleted` (`deleted`,`active`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `reference` (`id_reference`,`deleted`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_group` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_lang` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned NOT NULL,
  `delay` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id_lang`,`id_shop`,`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_shop` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_tax_rules_group_shop` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_tax_rules_group`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_zone` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_zone` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart` (
  `id_cart` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT 1,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_carrier` int(10) unsigned NOT NULL,
  `delivery_option` text NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_address_delivery` int(10) unsigned NOT NULL,
  `id_address_invoice` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_guest` int(10) unsigned NOT NULL,
  `secure_key` varchar(32) NOT NULL DEFAULT '-1',
  `recyclable` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `gift` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `gift_message` text DEFAULT NULL,
  `mobile_theme` tinyint(1) NOT NULL DEFAULT 0,
  `allow_seperated_package` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_cart`),
  KEY `cart_customer` (`id_customer`),
  KEY `id_address_delivery` (`id_address_delivery`),
  KEY `id_address_invoice` (`id_address_invoice`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_lang` (`id_lang`),
  KEY `id_currency` (`id_currency`),
  KEY `id_guest` (`id_guest`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `id_shop_2` (`id_shop`,`date_upd`),
  KEY `id_shop` (`id_shop`,`date_add`)
) ENGINE=InnoDB AUTO_INCREMENT=74306 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_cart_rule` (
  `id_cart` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart`,`id_cart_rule`),
  KEY `id_cart_rule` (`id_cart_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_product` (
  `id_cart` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_address_delivery` int(10) unsigned NOT NULL DEFAULT 0,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `id_product_attribute` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_cart`,`id_product`,`id_product_attribute`,`id_address_delivery`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_cart_order` (`id_cart`,`date_add`,`id_product`,`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule` (
  `id_cart_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL DEFAULT 0,
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity_per_user` int(10) unsigned NOT NULL DEFAULT 0,
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `partial_use` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `code` varchar(254) NOT NULL,
  `minimum_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `minimum_amount_tax` tinyint(1) NOT NULL DEFAULT 0,
  `minimum_amount_currency` int(10) unsigned NOT NULL DEFAULT 0,
  `minimum_amount_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `country_restriction` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `carrier_restriction` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `group_restriction` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `cart_rule_restriction` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `product_restriction` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `shop_restriction` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `reduction_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `reduction_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `reduction_currency` int(10) unsigned NOT NULL DEFAULT 0,
  `reduction_product` int(10) NOT NULL DEFAULT 0,
  `gift_product` int(10) unsigned NOT NULL DEFAULT 0,
  `gift_product_attribute` int(10) unsigned NOT NULL DEFAULT 0,
  `highlight` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_cart_rule`),
  KEY `id_customer` (`id_customer`,`active`,`date_to`),
  KEY `group_restriction` (`group_restriction`,`active`,`date_to`),
  KEY `id_customer_2` (`id_customer`,`active`,`highlight`,`date_to`),
  KEY `group_restriction_2` (`group_restriction`,`active`,`highlight`,`date_to`)
) ENGINE=InnoDB AUTO_INCREMENT=3519 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_carrier` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_carrier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_combination` (
  `id_cart_rule_1` int(10) unsigned NOT NULL,
  `id_cart_rule_2` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule_1`,`id_cart_rule_2`),
  KEY `id_cart_rule_1` (`id_cart_rule_1`),
  KEY `id_cart_rule_2` (`id_cart_rule_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_country` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_group` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_lang` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(254) NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_product_rule` (
  `id_product_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product_rule_group` int(10) unsigned NOT NULL,
  `type` enum('products','categories','attributes','manufacturers','suppliers') NOT NULL,
  PRIMARY KEY (`id_product_rule`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_product_rule_group` (
  `id_product_rule_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_product_rule_group`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_product_rule_value` (
  `id_product_rule` int(10) unsigned NOT NULL,
  `id_item` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product_rule`,`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_shop` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category` (
  `id_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(10) unsigned NOT NULL,
  `id_shop_default` int(10) unsigned NOT NULL DEFAULT 1,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `nleft` int(10) unsigned NOT NULL DEFAULT 0,
  `nright` int(10) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  `is_root_category` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_category`),
  KEY `category_parent` (`id_parent`),
  KEY `nleftrightactive` (`nleft`,`nright`,`active`),
  KEY `level_depth` (`level_depth`),
  KEY `nright` (`nright`),
  KEY `activenleft` (`active`,`nleft`),
  KEY `activenright` (`active`,`nright`)
) ENGINE=InnoDB AUTO_INCREMENT=706 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_anchor_lang` (
  `id_category` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `anchor_text` varchar(128) NOT NULL,
  UNIQUE KEY `ps_category_anchor_lang_pk` (`id_category`,`id_lang`),
  KEY `ps_category_anchor_lang_ps_lang_id_lang_fk` (`id_lang`),
  CONSTRAINT `ps_category_anchor_lang_ps_category_id_category_fk` FOREIGN KEY (`id_category`) REFERENCES `ps_category` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ps_category_anchor_lang_ps_lang_id_lang_fk` FOREIGN KEY (`id_lang`) REFERENCES `ps_lang` (`id_lang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_group` (
  `id_category` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_category`,`id_group`),
  KEY `id_category` (`id_category`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_lang` (
  `id_category` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text DEFAULT NULL,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_category`,`id_shop`,`id_lang`),
  KEY `category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_product` (
  `id_category` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_category`,`id_product`),
  KEY `id_product` (`id_product`),
  KEY `id_category` (`id_category`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_relationship` (
  `id_category` int(10) unsigned NOT NULL,
  `id_child_category` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  UNIQUE KEY `ps_category_relationship_pk` (`id_category`,`id_child_category`),
  KEY `ps_category_relationship_ps_category_id_category_fk_2` (`id_child_category`),
  CONSTRAINT `ps_category_relationship_ps_category_id_category_fk` FOREIGN KEY (`id_category`) REFERENCES `ps_category` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ps_category_relationship_ps_category_id_category_fk_2` FOREIGN KEY (`id_child_category`) REFERENCES `ps_category` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_shop` (
  `id_category` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_category`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms` (
  `id_cms` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cms_category` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `indexation` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_cms`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category` (
  `id_cms_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(10) unsigned NOT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_cms_category`),
  KEY `category_parent` (`id_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category_lang` (
  `id_cms_category` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(128) NOT NULL,
  `description` text DEFAULT NULL,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_cms_category`,`id_shop`,`id_lang`),
  KEY `category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category_shop` (
  `id_cms_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_category`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_lang` (
  `id_cms` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `meta_title` varchar(128) NOT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `link_rewrite` varchar(128) NOT NULL,
  PRIMARY KEY (`id_cms`,`id_shop`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_role` (
  `id_cms_role` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `id_cms` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_role`,`id_cms`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_role_lang` (
  `id_cms_role` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_cms_role`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_shop` (
  `id_cms` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_codfee_configuration` (
  `id_codfee_configuration` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` int(1) unsigned NOT NULL DEFAULT 1,
  `amount_calc` tinyint(1) unsigned NOT NULL DEFAULT 9,
  `fix` decimal(10,3) DEFAULT 0.000,
  `percentage` decimal(10,3) DEFAULT 0.000,
  `min` decimal(10,3) DEFAULT 0.000,
  `max` decimal(10,3) DEFAULT 0.000,
  `order_min` decimal(10,3) DEFAULT 0.000,
  `order_max` decimal(10,3) DEFAULT 0.000,
  `amount_free` decimal(10,3) DEFAULT 0.000,
  `groups` varchar(250) DEFAULT NULL,
  `carriers` varchar(250) DEFAULT NULL,
  `countries` varchar(1000) DEFAULT NULL,
  `zones` varchar(250) DEFAULT NULL,
  `categories` varchar(2000) DEFAULT NULL,
  `manufacturers` varchar(250) DEFAULT NULL,
  `suppliers` varchar(250) DEFAULT NULL,
  `initial_status` int(1) unsigned NOT NULL DEFAULT 3,
  `show_conf_page` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `free_on_freeshipping` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `hide_first_order` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `only_stock` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `round` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `show_productpage` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `priority` int(1) unsigned DEFAULT 0,
  `position` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `payment_size` varchar(10) NOT NULL DEFAULT 'col-md-12',
  `id_shop` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_codfee_configuration`),
  KEY `id_codfee_configuration` (`id_codfee_configuration`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_codfee_configuration_lang` (
  `id_codfee_configuration` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL DEFAULT 0,
  `payment_text` text DEFAULT NULL,
  PRIMARY KEY (`id_codfee_configuration`,`id_lang`),
  KEY `id_codfee_configuration` (`id_codfee_configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_codfee_configuration_shop` (
  `id_codfee_configuration` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_codfee_configuration`,`id_shop`),
  KEY `id_codfee_configuration` (`id_codfee_configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_compare` (
  `id_compare` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_compare`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_compare_product` (
  `id_compare` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_compare`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration` (
  `id_configuration` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned DEFAULT NULL,
  `id_shop` int(11) unsigned DEFAULT NULL,
  `name` varchar(254) NOT NULL,
  `value` text DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_configuration`),
  KEY `name` (`name`),
  KEY `id_shop` (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`)
) ENGINE=InnoDB AUTO_INCREMENT=1815 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration_kpi` (
  `id_configuration_kpi` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned DEFAULT NULL,
  `id_shop` int(11) unsigned DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `value` text DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_configuration_kpi`),
  KEY `name` (`name`),
  KEY `id_shop` (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration_kpi_lang` (
  `id_configuration_kpi` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` text DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_configuration_kpi`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration_lang` (
  `id_configuration` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` text DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_configuration`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_connections` (
  `id_connections` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT 1,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_guest` int(10) unsigned NOT NULL,
  `id_page` int(10) unsigned NOT NULL,
  `ip_address` bigint(20) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_connections`),
  KEY `id_guest` (`id_guest`),
  KEY `date_add` (`date_add`),
  KEY `id_page` (`id_page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_connections_page` (
  `id_connections` int(10) unsigned NOT NULL,
  `id_page` int(10) unsigned NOT NULL,
  `time_start` datetime NOT NULL,
  `time_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id_connections`,`id_page`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_connections_source` (
  `id_connections_source` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_connections` int(10) unsigned NOT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  `request_uri` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_connections_source`),
  KEY `connections` (`id_connections`),
  KEY `orderby` (`date_add`),
  KEY `http_referer` (`http_referer`),
  KEY `request_uri` (`request_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_contact` (
  `id_contact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `customer_service` tinyint(1) NOT NULL DEFAULT 0,
  `position` tinyint(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_contact_lang` (
  `id_contact` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id_contact`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_contact_shop` (
  `id_contact` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_contact`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_country` (
  `id_country` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_zone` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL DEFAULT 0,
  `iso_code` varchar(3) NOT NULL,
  `call_prefix` int(10) NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `contains_states` tinyint(1) NOT NULL DEFAULT 0,
  `need_identification_number` tinyint(1) NOT NULL DEFAULT 0,
  `need_zip_code` tinyint(1) NOT NULL DEFAULT 1,
  `zip_code_format` varchar(12) NOT NULL DEFAULT '',
  `display_tax_label` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_country`),
  KEY `country_iso_code` (`iso_code`),
  KEY `country_` (`id_zone`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_country_lang` (
  `id_country` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_country`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_country_shop` (
  `id_country` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_country`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cronjobs` (
  `id_cronjob` int(10) NOT NULL AUTO_INCREMENT,
  `id_module` int(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `task` text DEFAULT NULL,
  `hour` int(11) DEFAULT -1,
  `day` int(11) DEFAULT -1,
  `month` int(11) DEFAULT -1,
  `day_of_week` int(11) DEFAULT -1,
  `updated_at` datetime DEFAULT NULL,
  `one_shot` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) DEFAULT 0,
  `id_shop` int(11) DEFAULT 0,
  `id_shop_group` int(11) DEFAULT 0,
  PRIMARY KEY (`id_cronjob`),
  KEY `id_module` (`id_module`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_currency` (
  `id_currency` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `iso_code` varchar(3) NOT NULL DEFAULT '0',
  `iso_code_num` varchar(3) NOT NULL DEFAULT '0',
  `sign` varchar(8) NOT NULL,
  `blank` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `format` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `decimals` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `conversion_rate` decimal(13,6) NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_currency`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_currency_shop` (
  `id_currency` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `conversion_rate` decimal(13,6) NOT NULL,
  PRIMARY KEY (`id_currency`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer` (
  `id_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT 1,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_gender` int(10) unsigned NOT NULL,
  `id_default_group` int(10) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned DEFAULT NULL,
  `id_risk` int(10) unsigned NOT NULL DEFAULT 1,
  `company` varchar(64) DEFAULT NULL,
  `siret` varchar(14) DEFAULT NULL,
  `ape` varchar(5) DEFAULT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `last_passwd_gen` timestamp NOT NULL DEFAULT current_timestamp(),
  `birthday` date DEFAULT NULL,
  `newsletter` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ip_registration_newsletter` varchar(15) DEFAULT NULL,
  `newsletter_date_add` datetime DEFAULT NULL,
  `optin` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `website` varchar(128) DEFAULT NULL,
  `outstanding_allow_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `show_public_prices` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `max_payment_days` int(10) unsigned NOT NULL DEFAULT 60,
  `secure_key` varchar(32) NOT NULL DEFAULT '-1',
  `note` text DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `is_guest` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_customer`),
  KEY `customer_email` (`email`),
  KEY `customer_login` (`email`,`passwd`),
  KEY `id_customer_passwd` (`id_customer`,`passwd`),
  KEY `id_gender` (`id_gender`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `id_shop` (`id_shop`,`date_add`)
) ENGINE=InnoDB AUTO_INCREMENT=26641 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_group` (
  `id_customer` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_customer`,`id_group`),
  KEY `customer_login` (`id_group`),
  KEY `id_customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_message` (
  `id_customer_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer_thread` int(11) DEFAULT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `message` mediumtext NOT NULL,
  `file_name` varchar(18) DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `user_agent` varchar(128) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `private` tinyint(4) NOT NULL DEFAULT 0,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_customer_message`),
  KEY `id_customer_thread` (`id_customer_thread`),
  KEY `id_employee` (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=6756 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_message_sync_imap` (
  `md5_header` varbinary(32) NOT NULL,
  KEY `md5_header_index` (`md5_header`(4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_thread` (
  `id_customer_thread` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned NOT NULL,
  `id_contact` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned DEFAULT NULL,
  `id_order` int(10) unsigned DEFAULT NULL,
  `id_product` int(10) unsigned DEFAULT NULL,
  `status` enum('open','closed','pending1','pending2') NOT NULL DEFAULT 'open',
  `email` varchar(128) NOT NULL,
  `token` varchar(12) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_customer_thread`),
  KEY `id_shop` (`id_shop`),
  KEY `id_lang` (`id_lang`),
  KEY `id_contact` (`id_contact`),
  KEY `id_customer` (`id_customer`),
  KEY `id_order` (`id_order`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=4547 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customization` (
  `id_customization` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product_attribute` int(10) unsigned NOT NULL DEFAULT 0,
  `id_address_delivery` int(10) unsigned NOT NULL DEFAULT 0,
  `id_cart` int(10) unsigned NOT NULL,
  `id_product` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `quantity_refunded` int(11) NOT NULL DEFAULT 0,
  `quantity_returned` int(11) NOT NULL DEFAULT 0,
  `in_cart` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_customization`,`id_cart`,`id_product`,`id_address_delivery`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_cart_product` (`id_cart`,`id_product`,`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customization_field` (
  `id_customization_field` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_customization_field`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customization_field_lang` (
  `id_customization_field` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_customization_field`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customized_data` (
  `id_customization` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL,
  `index` int(3) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id_customization`,`type`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_date_range` (
  `id_date_range` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `time_start` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  PRIMARY KEY (`id_date_range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_delivery` (
  `id_delivery` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned DEFAULT NULL,
  `id_shop_group` int(10) unsigned DEFAULT NULL,
  `id_carrier` int(10) unsigned NOT NULL,
  `id_range_price` int(10) unsigned DEFAULT NULL,
  `id_range_weight` int(10) unsigned DEFAULT NULL,
  `id_zone` int(10) unsigned NOT NULL,
  `price` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_delivery`),
  KEY `id_zone` (`id_zone`),
  KEY `id_carrier` (`id_carrier`,`id_zone`),
  KEY `id_range_price` (`id_range_price`),
  KEY `id_range_weight` (`id_range_weight`)
) ENGINE=InnoDB AUTO_INCREMENT=64258 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_doofinder_product` (
  `id_doofinder_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `action` varchar(45) NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_doofinder_product`),
  UNIQUE KEY `uc_shop_product` (`id_shop`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ed_delivery_zones` (
  `id_reference` int(11) NOT NULL,
  `id_zone` int(11) NOT NULL,
  `delivery_min` text NOT NULL,
  `delivery_max` text NOT NULL,
  UNIQUE KEY `ed_delivery_zone` (`id_reference`,`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ed_order_individual` (
  `id_order` int(11) NOT NULL,
  `id_order_detail` int(11) NOT NULL,
  `delivery_min` text NOT NULL,
  `delivery_max` text NOT NULL,
  `picking_day` text NOT NULL,
  `is_virtual` tinyint(1) NOT NULL DEFAULT 0,
  `is_release` tinyint(1) NOT NULL DEFAULT 0,
  `is_available` tinyint(1) NOT NULL DEFAULT 0,
  `undefined_delivery` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE KEY `ed_individual` (`id_order`,`id_order_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_elegantaltinypngimagecompress` (
  `id_elegantaltinypngimagecompress` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `image_group` varchar(255) NOT NULL,
  `custom_dir` varchar(255) DEFAULT NULL,
  `images_count` int(11) unsigned NOT NULL,
  `images_size_before` bigint(20) unsigned NOT NULL,
  `images_size_after` bigint(20) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_elegantaltinypngimagecompress`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_elegantaltinypngimagecompress_images` (
  `id_elegantaltinypngimagecompress_images` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_elegantaltinypngimagecompress` int(11) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `image_path` varchar(255) NOT NULL,
  `image_size_before` int(11) unsigned NOT NULL,
  `image_size_after` int(11) unsigned NOT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_elegantaltinypngimagecompress_images`)
) ENGINE=InnoDB AUTO_INCREMENT=450442 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_employee` (
  `id_employee` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_profile` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL DEFAULT 0,
  `lastname` varchar(32) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `last_passwd_gen` timestamp NOT NULL DEFAULT current_timestamp(),
  `stats_date_from` date DEFAULT NULL,
  `stats_date_to` date DEFAULT NULL,
  `stats_compare_from` date DEFAULT NULL,
  `stats_compare_to` date DEFAULT NULL,
  `stats_compare_option` int(1) unsigned NOT NULL DEFAULT 1,
  `preselect_date_range` varchar(32) DEFAULT NULL,
  `bo_color` varchar(32) DEFAULT NULL,
  `bo_theme` varchar(32) DEFAULT NULL,
  `bo_css` varchar(64) DEFAULT NULL,
  `default_tab` int(10) unsigned NOT NULL DEFAULT 0,
  `bo_width` int(10) unsigned NOT NULL DEFAULT 0,
  `bo_menu` tinyint(1) NOT NULL DEFAULT 1,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `optin` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `id_last_order` int(10) unsigned NOT NULL DEFAULT 0,
  `id_last_customer_message` int(10) unsigned NOT NULL DEFAULT 0,
  `id_last_customer` int(10) unsigned NOT NULL DEFAULT 0,
  `last_connection_date` date DEFAULT '0000-00-00',
  PRIMARY KEY (`id_employee`),
  KEY `employee_login` (`email`,`passwd`),
  KEY `id_employee_passwd` (`id_employee`,`passwd`),
  KEY `id_profile` (`id_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_employee_shop` (
  `id_employee` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_employee`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature` (
  `id_feature` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_feature`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_lang` (
  `id_feature` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_feature`,`id_lang`),
  KEY `id_lang` (`id_lang`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_product` (
  `id_feature` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_feature_value` int(10) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  UNIQUE KEY `mf_unique` (`id_feature`,`id_product`,`id_feature_value`),
  KEY `id_feature_value` (`id_feature_value`),
  KEY `id_product` (`id_product`),
  KEY `mf_feature_product` (`id_feature`,`id_product`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_shop` (
  `id_feature` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_feature`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_value` (
  `id_feature_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_feature` int(10) unsigned NOT NULL,
  `custom` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_feature_value`),
  KEY `feature` (`id_feature`)
) ENGINE=InnoDB AUTO_INCREMENT=27229 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_value_lang` (
  `id_feature_value` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_feature_value`,`id_lang`),
  KEY `id_feature_value` (`id_feature_value`),
  KEY `id_lang` (`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fpf_cat` (
  `id_category` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `google_taxonomy_id` int(4) DEFAULT NULL,
  `excluded` tinyint(1) DEFAULT 0,
  UNIQUE KEY `id_category` (`id_category`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fsch_block` (
  `id_fsch_block` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `hook` varchar(100) NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `content_editor` varchar(100) NOT NULL,
  `id_fsch_template` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_fsch_block`),
  KEY `hook` (`hook`),
  KEY `position` (`position`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=9055 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fsch_block_lang` (
  `id_fsch_block` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  PRIMARY KEY (`id_fsch_block`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fsch_block_shop` (
  `id_fsch_block` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_fsch_block`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fsch_filter` (
  `id_filter` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_type` varchar(100) NOT NULL,
  `id_content` int(10) unsigned NOT NULL DEFAULT 0,
  `id_filter_group` int(10) unsigned NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL,
  `parameter` varchar(255) NOT NULL,
  `condition` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_filter`),
  KEY `content_type` (`content_type`),
  KEY `id_content` (`id_content`),
  KEY `id_filter_group` (`id_filter_group`)
) ENGINE=InnoDB AUTO_INCREMENT=38916 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fsch_hook` (
  `id_fsch_hook` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_fsch_hook`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fsch_template` (
  `id_fsch_template` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `template` text NOT NULL,
  `template_editor` varchar(100) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_fsch_template`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gender` (
  `id_gender` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_gender`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gender_lang` (
  `id_gender` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_gender`,`id_lang`),
  KEY `id_gender` (`id_gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gls_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(128) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gls_envios` (
  `id_envio` int(11) NOT NULL AUTO_INCREMENT,
  `id_envio_order` int(11) NOT NULL,
  `current_state` int(11) DEFAULT NULL,
  `state_history` text DEFAULT NULL,
  `codigo_envio` varchar(50) NOT NULL,
  `url_track` varchar(255) NOT NULL,
  `num_albaran` varchar(100) NOT NULL,
  `codigo_barras` text DEFAULT NULL,
  `bultos` int(11) DEFAULT NULL,
  `retorno` int(3) DEFAULT NULL,
  `rcs` int(3) DEFAULT NULL,
  `peso` decimal(11,2) DEFAULT NULL,
  `vsec` decimal(11,2) DEFAULT NULL,
  `dorig` varchar(50) DEFAULT NULL,
  `observaciones` varchar(254) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id_envio`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gls_parcels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cart` int(11) NOT NULL,
  `codigo` text DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `cp` text DEFAULT NULL,
  `localidad` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_cart` (`id_cart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_grecaptcha_domains` (
  `id_grecaptcha_domain` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(256) NOT NULL,
  PRIMARY KEY (`id_grecaptcha_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group` (
  `id_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reduction` decimal(17,2) NOT NULL DEFAULT 0.00,
  `price_display_method` tinyint(4) NOT NULL DEFAULT 0,
  `show_prices` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group_lang` (
  `id_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_group`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group_reduction` (
  `id_group_reduction` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `id_group` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  `reduction` decimal(4,3) NOT NULL,
  PRIMARY KEY (`id_group_reduction`),
  UNIQUE KEY `id_group` (`id_group`,`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group_shop` (
  `id_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_group`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_aftersales` (
  `AFS_ID` int(10) unsigned NOT NULL,
  `AFS_TYPE` enum('rating','review') NOT NULL DEFAULT 'rating',
  `AFS_DATE_ADD` timestamp NULL DEFAULT NULL,
  `AFS_DATE_UPD` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `AFS_DISPLAY` enum('0','1') DEFAULT '0',
  `AFS_DATA` text DEFAULT NULL,
  PRIMARY KEY (`AFS_ID`,`AFS_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_callback` (
  `CBK_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CBK_SHOP_ID` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `ORDER_ID` int(10) unsigned NOT NULL,
  `CBK_DATE_ADD` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CBK_STATUS` enum('0','1') DEFAULT NULL,
  `CBK_CUST_ID` int(10) unsigned NOT NULL,
  `CBK_DATA` text DEFAULT NULL,
  PRIMARY KEY (`CBK_ID`),
  KEY `X_BTR_ORDER_ID` (`CBK_SHOP_ID`,`ORDER_ID`),
  KEY `X_BTR_CBK_STATUS` (`CBK_SHOP_ID`,`CBK_STATUS`),
  KEY `X_BTR_CBK_CUST_ID` (`CBK_SHOP_ID`,`CBK_CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_customer` (
  `CUST_SHOP_ID` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `CUST_ID` int(10) unsigned NOT NULL,
  `CUST_CBK_STATUS` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`CUST_SHOP_ID`,`CUST_ID`),
  KEY `X_BTR_CUST_STATUS` (`CUST_SHOP_ID`,`CUST_CBK_STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_orders_history` (
  `oh_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oh_shop_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `oh_order_id` int(10) unsigned NOT NULL,
  `oh_date_sent` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `oh_sent_count` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`oh_id`),
  UNIQUE KEY `oh_shop_id` (`oh_shop_id`,`oh_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_rating` (
  `RTG_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RTG_SHOP_ID` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `RTG_PROD_ID` int(10) unsigned NOT NULL,
  `RTG_LANG_ID` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `RTG_NOTE` enum('1','2','3','4','5') DEFAULT NULL,
  `RTG_STATUS` enum('0','1') DEFAULT NULL,
  `RTG_CUST_ID` int(10) unsigned NOT NULL,
  `RTG_DATE_ADD` timestamp NOT NULL DEFAULT current_timestamp(),
  `RTG_DATA` text DEFAULT NULL,
  PRIMARY KEY (`RTG_ID`),
  KEY `X_BTR_RTG_CHECK` (`RTG_SHOP_ID`,`RTG_PROD_ID`,`RTG_CUST_ID`),
  KEY `X_BTR_SHOP` (`RTG_SHOP_ID`),
  KEY `X_BTR_STATUS` (`RTG_SHOP_ID`,`RTG_STATUS`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_review` (
  `RVW_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RVW_SHOP_ID` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `RTG_ID` int(10) unsigned NOT NULL,
  `RVW_PROD_ID` int(10) unsigned NOT NULL,
  `RVW_LANG_ID` int(10) unsigned NOT NULL,
  `RVW_DATE_ADD` timestamp NULL DEFAULT NULL,
  `RVW_DATE_UPD` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `RVW_STATUS` enum('0','1') DEFAULT NULL,
  `RVW_CUST_ID` int(10) unsigned NOT NULL,
  `RVW_FB_POST_ID` bigint(20) unsigned NOT NULL,
  `RVW_FB_PAGE_ID` bigint(20) unsigned NOT NULL,
  `RVW_DATA` text DEFAULT NULL,
  PRIMARY KEY (`RVW_ID`),
  KEY `X_BTR_RTG_ID` (`RTG_ID`),
  KEY `X_BTR_STATUS` (`RVW_SHOP_ID`,`RVW_STATUS`),
  KEY `X_BTR_CUST` (`RVW_SHOP_ID`,`RVW_CUST_ID`),
  KEY `X_BTR_FB_POST` (`RVW_FB_POST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_review_report` (
  `RPT_RVW_ID` int(10) unsigned NOT NULL DEFAULT 0,
  `RPT_CUST_ID` int(10) unsigned NOT NULL,
  `RPT_REPORT_CUST_DATA` text DEFAULT NULL,
  PRIMARY KEY (`RPT_RVW_ID`,`RPT_CUST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsr_voucher` (
  `VCHR_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `VCHR_SHOP_ID` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `VCHR_TYPE` varchar(32) DEFAULT '',
  `VCHR_CUST_ID` int(10) unsigned NOT NULL,
  `VCHR_COUNT` int(10) unsigned NOT NULL,
  PRIMARY KEY (`VCHR_ID`),
  UNIQUE KEY `C_UNI_CUST_TYPE` (`VCHR_SHOP_ID`,`VCHR_TYPE`,`VCHR_CUST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_guest` (
  `id_guest` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_operating_system` int(10) unsigned DEFAULT NULL,
  `id_web_browser` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned DEFAULT NULL,
  `javascript` tinyint(1) DEFAULT 0,
  `screen_resolution_x` smallint(5) unsigned DEFAULT NULL,
  `screen_resolution_y` smallint(5) unsigned DEFAULT NULL,
  `screen_color` tinyint(3) unsigned DEFAULT NULL,
  `sun_java` tinyint(1) DEFAULT NULL,
  `adobe_flash` tinyint(1) DEFAULT NULL,
  `adobe_director` tinyint(1) DEFAULT NULL,
  `apple_quicktime` tinyint(1) DEFAULT NULL,
  `real_player` tinyint(1) DEFAULT NULL,
  `windows_media` tinyint(1) DEFAULT NULL,
  `accept_language` varchar(8) DEFAULT NULL,
  `mobile_theme` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_guest`),
  KEY `id_customer` (`id_customer`),
  KEY `id_operating_system` (`id_operating_system`),
  KEY `id_web_browser` (`id_web_browser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook` (
  `id_hook` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` text DEFAULT NULL,
  `position` tinyint(1) NOT NULL DEFAULT 1,
  `live_edit` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_hook`),
  UNIQUE KEY `hook_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook_alias` (
  `id_hook_alias` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alias` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_hook_alias`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook_module` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_hook` int(10) unsigned NOT NULL,
  `position` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id_module`,`id_hook`,`id_shop`),
  KEY `id_hook` (`id_hook`),
  KEY `id_module` (`id_module`),
  KEY `position` (`id_shop`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook_module_exceptions` (
  `id_hook_module_exceptions` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_module` int(10) unsigned NOT NULL,
  `id_hook` int(10) unsigned NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_hook_module_exceptions`),
  KEY `id_module` (`id_module`),
  KEY `id_hook` (`id_hook`)
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image` (
  `id_image` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `position` smallint(2) unsigned NOT NULL DEFAULT 0,
  `cover` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_image`),
  UNIQUE KEY `id_product_cover` (`id_product`,`cover`),
  UNIQUE KEY `idx_product_image` (`id_image`,`id_product`,`cover`),
  KEY `image_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=92464 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image_lang` (
  `id_image` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `legend` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_image`,`id_lang`),
  KEY `id_image` (`id_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image_shop` (
  `id_product` int(10) unsigned NOT NULL,
  `id_image` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `cover` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_image`,`id_shop`),
  UNIQUE KEY `id_product` (`id_product`,`id_shop`,`cover`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image_type` (
  `id_image_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `products` tinyint(1) NOT NULL DEFAULT 1,
  `categories` tinyint(1) NOT NULL DEFAULT 1,
  `manufacturers` tinyint(1) NOT NULL DEFAULT 1,
  `suppliers` tinyint(1) NOT NULL DEFAULT 1,
  `scenes` tinyint(1) NOT NULL DEFAULT 1,
  `stores` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_image_type`),
  KEY `image_type_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_import_match` (
  `id_import_match` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `match` text NOT NULL,
  `skip` int(2) NOT NULL,
  PRIMARY KEY (`id_import_match`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_info` (
  `id_info` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_info`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_info_lang` (
  `id_info` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id_info`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lang` (
  `id_lang` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `iso_code` char(2) NOT NULL,
  `language_code` char(5) NOT NULL,
  `date_format_lite` char(32) NOT NULL DEFAULT 'Y-m-d',
  `date_format_full` char(32) NOT NULL DEFAULT 'Y-m-d H:i:s',
  `is_rtl` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_lang`),
  KEY `lang_iso_code` (`iso_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lang_shop` (
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_lang`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lg_sitemaps_cron` (
  `id_sitemaps_cron` int(11) NOT NULL AUTO_INCREMENT,
  `priority` varchar(5) DEFAULT NULL,
  `frecuency` varchar(25) DEFAULT NULL,
  `activate_images` int(11) DEFAULT NULL,
  `use_cdn` tinyint(1) DEFAULT 0,
  `https_cdn1` tinyint(1) DEFAULT 0,
  `https_cdn2` tinyint(1) DEFAULT 0,
  `https_cdn3` tinyint(1) DEFAULT 0,
  `entity` varchar(100) DEFAULT NULL,
  `ping` int(11) DEFAULT NULL,
  `id_shop` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sitemaps_cron`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgbannerhostcountry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bancountry` text NOT NULL,
  `update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgbannerhostip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banip` text NOT NULL,
  `update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgbannerhostuseragent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banuseragent` text NOT NULL,
  `update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgcanonicalurls` (
  `id_object` int(10) unsigned NOT NULL,
  `type_object` enum('LGOT_PRODUCT','LGOT_CATEGORY','LGOT_CMS','LGOT_SUPPLIER','LGOT_MANUFACTURER') NOT NULL,
  `type` enum('LGCU_AUTO','LGCU_CUSTOM') NOT NULL DEFAULT 'LGCU_AUTO',
  `parameters` text DEFAULT NULL,
  PRIMARY KEY (`id_object`,`type_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgcanonicalurls_lang` (
  `id_object` int(10) unsigned NOT NULL,
  `type_object` enum('LGOT_PRODUCT','LGOT_CATEGORY','LGOT_CMS','LGOT_SUPPLIER','LGOT_MANUFACTURER') NOT NULL,
  `canonical_url` text DEFAULT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_object`,`type_object`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgfreeshippingzones` (
  `id_zone` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `id_shop_group` int(11) NOT NULL,
  `id_carrier` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `weight` decimal(10,3) NOT NULL,
  `price2` decimal(10,2) NOT NULL,
  `weight2` decimal(10,3) NOT NULL,
  KEY `id_zone` (`id_zone`),
  KEY `id_carrier` (`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lgseoredirect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url_old` text NOT NULL,
  `url_new` text NOT NULL,
  `redirect_type` varchar(10) NOT NULL,
  `update` datetime NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `redirect_type` (`redirect_type`)
) ENGINE=InnoDB AUTO_INCREMENT=12820 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lineven_rlp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned DEFAULT NULL,
  `id_shop` int(11) unsigned DEFAULT NULL,
  `name` text DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `related_product_id` int(10) DEFAULT NULL,
  `related_products_keywords` text DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `category_products_id` int(10) DEFAULT NULL,
  `products_keywords` text DEFAULT NULL,
  `is_reciprocity` int(1) NOT NULL DEFAULT 0,
  `is_keywords_rules_active` int(1) NOT NULL DEFAULT 0,
  `is_keywords_rules_reference` int(1) NOT NULL DEFAULT 0,
  `is_keywords_rules_name` int(1) NOT NULL DEFAULT 0,
  `is_keywords_rules_description` int(1) NOT NULL DEFAULT 0,
  `hooks` varchar(255) DEFAULT NULL,
  `order_display` int(10) DEFAULT NULL,
  `options` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lineven_rlp_plugins` (
  `id_plugin` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `type` char(3) NOT NULL DEFAULT 'USR',
  `name` text DEFAULT NULL,
  `classname` text DEFAULT NULL,
  `is_active` int(1) NOT NULL DEFAULT 0,
  `options` text DEFAULT NULL,
  `order_display` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lineven_rlp_plugins_lang` (
  `id_plugin` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 0,
  `id_lang` int(11) unsigned NOT NULL DEFAULT 0,
  `title` text DEFAULT NULL,
  PRIMARY KEY (`id_plugin`,`id_shop`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_log` (
  `id_log` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `severity` tinyint(1) NOT NULL,
  `error_code` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `object_type` varchar(32) DEFAULT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=35834 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_magictoolbox_video` (
  `id_product` int(10) unsigned NOT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id_product`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_magiczoomplus_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `block` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `value` text DEFAULT NULL,
  `default_value` text DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL,
  `default_enabled` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=596 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_mail` (
  `id_mail` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `recipient` varchar(126) NOT NULL,
  `template` varchar(62) NOT NULL,
  `subject` varchar(254) NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_mail`),
  KEY `recipient` (`recipient`(10))
) ENGINE=InnoDB AUTO_INCREMENT=55716 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer` (
  `id_manufacturer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer_lang` (
  `id_manufacturer` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_manufacturer`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer_shop` (
  `id_manufacturer` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_manufacturer`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_memcached_servers` (
  `id_memcached_server` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(254) NOT NULL,
  `port` int(11) unsigned NOT NULL,
  `weight` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_memcached_server`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_message` (
  `id_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `message` text NOT NULL,
  `private` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_message`),
  KEY `message_order` (`id_order`),
  KEY `id_cart` (`id_cart`),
  KEY `id_customer` (`id_customer`),
  KEY `id_employee` (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=10297 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_message_readed` (
  `id_message` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_message`,`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_meta` (
  `id_meta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page` varchar(64) NOT NULL,
  `configurable` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_meta`),
  UNIQUE KEY `page` (`page`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_meta_lang` (
  `id_meta` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `url_rewrite` varchar(254) NOT NULL,
  PRIMARY KEY (`id_meta`,`id_shop`,`id_lang`),
  KEY `id_shop` (`id_shop`),
  KEY `id_lang` (`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module` (
  `id_module` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `version` varchar(8) NOT NULL,
  PRIMARY KEY (`id_module`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_access` (
  `id_profile` int(10) unsigned NOT NULL,
  `id_module` int(10) unsigned NOT NULL,
  `view` tinyint(1) NOT NULL DEFAULT 0,
  `configure` tinyint(1) NOT NULL DEFAULT 0,
  `uninstall` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_profile`,`id_module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_country` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_country` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_currency` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_currency` int(11) NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_currency`),
  KEY `id_module` (`id_module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_group` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_group` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_preference` (
  `id_module_preference` int(11) NOT NULL AUTO_INCREMENT,
  `id_employee` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  `interest` tinyint(1) DEFAULT NULL,
  `favorite` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_module_preference`),
  UNIQUE KEY `employee_module` (`id_employee`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_seoimg_objects` (
  `id_rule` int(11) unsigned NOT NULL,
  `id_obj` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_rule`,`id_obj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_seoimg_patterns` (
  `id_rule` int(11) unsigned NOT NULL,
  `field` varchar(100) NOT NULL DEFAULT '',
  `pattern` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_rule`,`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_seoimg_rules` (
  `id_rule` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `role` varchar(4) NOT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_rule`),
  KEY `id_lang` (`id_lang`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_shop` (
  `id_module` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `enable_device` tinyint(1) NOT NULL DEFAULT 7,
  PRIMARY KEY (`id_module`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_modules_perfs` (
  `id_modules_perfs` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `session` int(11) unsigned NOT NULL,
  `module` varchar(62) NOT NULL,
  `method` varchar(126) NOT NULL,
  `time_start` double unsigned NOT NULL,
  `time_end` double unsigned NOT NULL,
  `memory_start` int(10) unsigned NOT NULL,
  `memory_end` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_modules_perfs`),
  KEY `session` (`session`)
) ENGINE=InnoDB AUTO_INCREMENT=855 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_newsletter` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `id_shop_group` int(10) unsigned NOT NULL DEFAULT 1,
  `email` varchar(255) NOT NULL,
  `newsletter_date_add` datetime DEFAULT NULL,
  `ip_registration_newsletter` varchar(15) NOT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_operating_system` (
  `id_operating_system` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_operating_system`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_carrier` (
  `id_order_carrier` int(11) NOT NULL AUTO_INCREMENT,
  `id_order` int(11) unsigned NOT NULL,
  `id_carrier` int(11) unsigned NOT NULL,
  `id_order_invoice` int(11) unsigned DEFAULT NULL,
  `weight` decimal(20,6) DEFAULT NULL,
  `shipping_cost_tax_excl` decimal(20,6) DEFAULT NULL,
  `shipping_cost_tax_incl` decimal(20,6) DEFAULT NULL,
  `tracking_number` varchar(64) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_carrier`),
  KEY `id_order` (`id_order`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_order_invoice` (`id_order_invoice`)
) ENGINE=InnoDB AUTO_INCREMENT=13951 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_cart_rule` (
  `id_order_cart_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_order_invoice` int(10) unsigned DEFAULT 0,
  `name` varchar(254) NOT NULL,
  `value` decimal(17,2) NOT NULL DEFAULT 0.00,
  `value_tax_excl` decimal(17,2) NOT NULL DEFAULT 0.00,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_order_cart_rule`),
  KEY `id_order` (`id_order`),
  KEY `id_cart_rule` (`id_cart_rule`)
) ENGINE=InnoDB AUTO_INCREMENT=851 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_detail` (
  `id_order_detail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `id_order_invoice` int(11) DEFAULT NULL,
  `id_warehouse` int(10) unsigned DEFAULT 0,
  `id_shop` int(11) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_attribute_id` int(10) unsigned DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `product_quantity_in_stock` int(10) NOT NULL DEFAULT 0,
  `product_quantity_refunded` int(10) unsigned NOT NULL DEFAULT 0,
  `product_quantity_return` int(10) unsigned NOT NULL DEFAULT 0,
  `product_quantity_reinjected` int(10) unsigned NOT NULL DEFAULT 0,
  `product_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_percent` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_amount_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_amount_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `group_reduction` decimal(10,2) NOT NULL DEFAULT 0.00,
  `product_quantity_discount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `product_ean13` varchar(13) DEFAULT NULL,
  `product_upc` varchar(12) DEFAULT NULL,
  `product_reference` varchar(32) DEFAULT NULL,
  `product_supplier_reference` varchar(32) DEFAULT NULL,
  `product_weight` decimal(20,6) NOT NULL,
  `id_tax_rules_group` int(11) unsigned DEFAULT 0,
  `tax_computation_method` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `tax_name` varchar(16) NOT NULL,
  `tax_rate` decimal(10,3) NOT NULL DEFAULT 0.000,
  `ecotax` decimal(21,6) NOT NULL DEFAULT 0.000000,
  `ecotax_tax_rate` decimal(5,3) NOT NULL DEFAULT 0.000,
  `discount_quantity_applied` tinyint(1) NOT NULL DEFAULT 0,
  `download_hash` varchar(255) DEFAULT NULL,
  `download_nb` int(10) unsigned DEFAULT 0,
  `download_deadline` datetime DEFAULT NULL,
  `total_price_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_price_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `unit_price_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `unit_price_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping_price_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping_price_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `purchase_supplier_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `original_product_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `original_wholesale_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  PRIMARY KEY (`id_order_detail`),
  KEY `order_detail_order` (`id_order`),
  KEY `product_id` (`product_id`),
  KEY `product_attribute_id` (`product_attribute_id`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `id_order_id_order_detail` (`id_order`,`id_order_detail`)
) ENGINE=InnoDB AUTO_INCREMENT=18009 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_detail_tax` (
  `id_order_detail` int(11) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `unit_amount` decimal(16,6) NOT NULL DEFAULT 0.000000,
  `total_amount` decimal(16,6) NOT NULL DEFAULT 0.000000,
  KEY `id_order_detail` (`id_order_detail`),
  KEY `id_tax` (`id_tax`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_history` (
  `id_order_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `id_order_state` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_history`),
  KEY `order_history_order` (`id_order`),
  KEY `id_employee` (`id_employee`),
  KEY `id_order_state` (`id_order_state`)
) ENGINE=InnoDB AUTO_INCREMENT=53197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_invoice` (
  `id_order_invoice` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `delivery_number` int(11) NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `total_discount_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_discount_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_paid_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_paid_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_products` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_products_wt` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `shipping_tax_computation_method` int(10) unsigned NOT NULL,
  `total_wrapping_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_wrapping_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `shop_address` text DEFAULT NULL,
  `invoice_address` text DEFAULT NULL,
  `delivery_address` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_invoice`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB AUTO_INCREMENT=13221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_invoice_payment` (
  `id_order_invoice` int(11) unsigned NOT NULL,
  `id_order_payment` int(11) unsigned NOT NULL,
  `id_order` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_order_invoice`,`id_order_payment`),
  KEY `order_payment` (`id_order_payment`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_invoice_tax` (
  `id_order_invoice` int(11) NOT NULL,
  `type` varchar(15) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `amount` decimal(10,6) NOT NULL DEFAULT 0.000000,
  KEY `id_tax` (`id_tax`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_message` (
  `id_order_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_message`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_message_lang` (
  `id_order_message` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id_order_message`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_payment` (
  `id_order_payment` int(11) NOT NULL AUTO_INCREMENT,
  `order_reference` varchar(100) DEFAULT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `conversion_rate` decimal(13,6) NOT NULL DEFAULT 1.000000,
  `transaction_id` varchar(254) DEFAULT NULL,
  `card_number` varchar(254) DEFAULT NULL,
  `card_brand` varchar(254) DEFAULT NULL,
  `card_expiration` char(7) DEFAULT NULL,
  `card_holder` varchar(254) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_payment`),
  KEY `order_reference` (`order_reference`)
) ENGINE=InnoDB AUTO_INCREMENT=26605 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return` (
  `id_order_return` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `question` text NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order_return`),
  KEY `order_return_customer` (`id_customer`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return_detail` (
  `id_order_return` int(10) unsigned NOT NULL,
  `id_order_detail` int(10) unsigned NOT NULL,
  `id_customization` int(10) unsigned NOT NULL DEFAULT 0,
  `product_quantity` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_order_return`,`id_order_detail`,`id_customization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return_state` (
  `id_order_return_state` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `color` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_order_return_state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return_state_lang` (
  `id_order_return_state` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_order_return_state`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_slip` (
  `id_order_slip` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conversion_rate` decimal(13,6) NOT NULL DEFAULT 1.000000,
  `id_customer` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `total_products_tax_excl` decimal(20,6) DEFAULT NULL,
  `total_products_tax_incl` decimal(20,6) DEFAULT NULL,
  `total_shipping_tax_excl` decimal(20,6) DEFAULT NULL,
  `total_shipping_tax_incl` decimal(20,6) DEFAULT NULL,
  `shipping_cost` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `amount` decimal(10,2) NOT NULL,
  `shipping_cost_amount` decimal(10,2) NOT NULL,
  `partial` tinyint(1) NOT NULL,
  `order_slip_type` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order_slip`),
  KEY `order_slip_customer` (`id_customer`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_slip_detail` (
  `id_order_slip` int(10) unsigned NOT NULL,
  `id_order_detail` int(10) unsigned NOT NULL,
  `product_quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `unit_price_tax_excl` decimal(20,6) DEFAULT NULL,
  `unit_price_tax_incl` decimal(20,6) DEFAULT NULL,
  `total_price_tax_excl` decimal(20,6) DEFAULT NULL,
  `total_price_tax_incl` decimal(20,6) DEFAULT NULL,
  `amount_tax_excl` decimal(20,6) DEFAULT NULL,
  `amount_tax_incl` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`id_order_slip`,`id_order_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_slip_detail_tax` (
  `id_order_slip_detail` int(11) unsigned NOT NULL,
  `id_tax` int(11) unsigned NOT NULL,
  `unit_amount` decimal(16,6) NOT NULL DEFAULT 0.000000,
  `total_amount` decimal(16,6) NOT NULL DEFAULT 0.000000,
  KEY `id_order_slip_detail` (`id_order_slip_detail`),
  KEY `id_tax` (`id_tax`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_state` (
  `id_order_state` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice` tinyint(1) unsigned DEFAULT 0,
  `send_email` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `module_name` varchar(255) DEFAULT NULL,
  `color` varchar(32) DEFAULT NULL,
  `unremovable` tinyint(1) unsigned NOT NULL,
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `logable` tinyint(1) NOT NULL DEFAULT 0,
  `delivery` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `shipped` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `paid` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `pdf_invoice` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `pdf_delivery` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_order_state`),
  KEY `module_name` (`module_name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_state_lang` (
  `id_order_state` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `template` varchar(64) NOT NULL,
  PRIMARY KEY (`id_order_state`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_orders` (
  `id_order` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(100) DEFAULT NULL,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT 1,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_carrier` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_cart` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `id_address_delivery` int(10) unsigned NOT NULL,
  `id_address_invoice` int(10) unsigned NOT NULL,
  `current_state` int(10) unsigned NOT NULL,
  `secure_key` varchar(32) NOT NULL DEFAULT '-1',
  `payment` varchar(255) NOT NULL,
  `conversion_rate` decimal(13,6) NOT NULL DEFAULT 1.000000,
  `module` varchar(255) DEFAULT NULL,
  `recyclable` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `gift` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `gift_message` text DEFAULT NULL,
  `mobile_theme` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_number` varchar(64) DEFAULT NULL,
  `total_discounts` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_discounts_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_discounts_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_paid` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_paid_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_paid_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_paid_real` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_products` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_products_wt` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_shipping_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `carrier_tax_rate` decimal(10,3) NOT NULL DEFAULT 0.000,
  `total_wrapping` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_wrapping_tax_incl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total_wrapping_tax_excl` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `round_mode` tinyint(1) NOT NULL DEFAULT 2,
  `round_type` tinyint(1) NOT NULL DEFAULT 1,
  `invoice_number` int(10) unsigned NOT NULL DEFAULT 0,
  `delivery_number` int(10) unsigned NOT NULL DEFAULT 0,
  `invoice_date` datetime NOT NULL,
  `delivery_date` datetime NOT NULL,
  `valid` int(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `codfee` decimal(10,3) NOT NULL DEFAULT 0.000,
  PRIMARY KEY (`id_order`),
  KEY `reference` (`reference`),
  KEY `id_customer` (`id_customer`),
  KEY `id_cart` (`id_cart`),
  KEY `invoice_number` (`invoice_number`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_lang` (`id_lang`),
  KEY `id_currency` (`id_currency`),
  KEY `id_address_delivery` (`id_address_delivery`),
  KEY `id_address_invoice` (`id_address_invoice`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `current_state` (`current_state`),
  KEY `id_shop` (`id_shop`),
  KEY `date_add` (`date_add`)
) ENGINE=InnoDB AUTO_INCREMENT=13955 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_outvio_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text NOT NULL,
  `id_customer` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pack` (
  `id_product_pack` int(10) unsigned NOT NULL,
  `id_product_item` int(10) unsigned NOT NULL,
  `id_product_attribute_item` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_product_pack`,`id_product_item`,`id_product_attribute_item`),
  KEY `product_item` (`id_product_item`,`id_product_attribute_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_page` (
  `id_page` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_page_type` int(10) unsigned NOT NULL,
  `id_object` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_page`),
  KEY `id_page_type` (`id_page_type`),
  KEY `id_object` (`id_object`)
) ENGINE=InnoDB AUTO_INCREMENT=6643 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_page_type` (
  `id_page_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_page_type`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_page_viewed` (
  `id_page` int(10) unsigned NOT NULL,
  `id_shop_group` int(10) unsigned NOT NULL DEFAULT 1,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `id_date_range` int(10) unsigned NOT NULL,
  `counter` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_page`,`id_date_range`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_braintree` (
  `id_paypal_braintree` int(11) NOT NULL AUTO_INCREMENT,
  `id_cart` int(11) NOT NULL,
  `nonce_payment_token` varchar(255) NOT NULL,
  `client_token` text NOT NULL,
  `transaction` varchar(255) DEFAULT NULL,
  `datas` varchar(255) DEFAULT NULL,
  `id_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_paypal_braintree`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_capture` (
  `id_paypal_capture` int(11) NOT NULL AUTO_INCREMENT,
  `id_order` int(11) NOT NULL,
  `capture_amount` float NOT NULL,
  `result` text NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_paypal_capture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_customer` (
  `id_paypal_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL,
  `paypal_email` varchar(255) NOT NULL,
  PRIMARY KEY (`id_paypal_customer`)
) ENGINE=InnoDB AUTO_INCREMENT=4738 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_hss_email_error` (
  `id_paypal_hss_email_error` int(11) NOT NULL AUTO_INCREMENT,
  `id_cart` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id_paypal_hss_email_error`)
) ENGINE=InnoDB AUTO_INCREMENT=5102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_login_user` (
  `id_paypal_login_user` int(11) NOT NULL AUTO_INCREMENT,
  `id_customer` int(11) NOT NULL,
  `token_type` varchar(255) NOT NULL,
  `expires_in` varchar(255) NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `id_token` varchar(255) NOT NULL,
  `access_token` varchar(255) NOT NULL,
  `account_type` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `verified_account` varchar(255) NOT NULL,
  `zoneinfo` varchar(255) NOT NULL,
  `age_range` varchar(255) NOT NULL,
  PRIMARY KEY (`id_paypal_login_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_order` (
  `id_order` int(10) unsigned NOT NULL,
  `id_transaction` varchar(255) NOT NULL,
  `id_invoice` varchar(255) DEFAULT NULL,
  `currency` varchar(10) NOT NULL,
  `total_paid` varchar(50) NOT NULL,
  `shipping` varchar(50) NOT NULL,
  `capture` int(2) NOT NULL,
  `payment_date` varchar(50) NOT NULL,
  `payment_method` int(2) unsigned NOT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_plus_pui` (
  `id_paypal_plus_pui` int(11) NOT NULL AUTO_INCREMENT,
  `id_order` int(11) NOT NULL,
  `pui_informations` text NOT NULL,
  PRIMARY KEY (`id_paypal_plus_pui`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_plpganalytics_orders_sent` (
  `id_order` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_order`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch` (
  `id_search` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_hook` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `internal_name` varchar(255) NOT NULL,
  `css_classes` varchar(255) DEFAULT 'col-xs-12',
  `display_nb_result_on_blc` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `display_nb_result_criterion` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `remind_selection` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `show_hide_crit_method` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_by_emplacement` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `search_on_stock` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hide_empty_crit_group` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `search_method` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `step_search` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `step_search_next_in_disabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `position` smallint(4) unsigned DEFAULT 0,
  `unique_search` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `scrolltop_active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `id_category_root` int(10) unsigned NOT NULL DEFAULT 0,
  `redirect_one_product` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `add_anchor_to_url` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `reset_group` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `insert_in_center_column` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `smarty_var_name` varchar(64) NOT NULL,
  `search_results_selector` varchar(64) NOT NULL DEFAULT '#center_column',
  `recursing_indexing` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `display_empty_criteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `keep_category_information` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `priority_on_combination_image` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `products_per_page` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `products_order_by` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `products_order_way` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hide_criterions_group_with_no_effect` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_search`),
  KEY `id_hook` (`id_hook`),
  KEY `active` (`active`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_1` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_10` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_11` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_12` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_13` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_15` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_16` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_17` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_18` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_19` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_2` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_20` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_3` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_4` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_5` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_6` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_8` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=8870 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_9` (
  `id_cache_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cache_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=10459 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_1` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_10` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_11` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_12` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_13` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_15` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_16` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_17` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_18` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_19` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_2` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_20` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_3` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_4` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_5` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_6` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_8` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cache_product_criterion_9` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_cache_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_cache_product`),
  KEY `id_criterion2` (`id_criterion`),
  KEY `id_cache_product` (`id_cache_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_category` (
  `id_search` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_search`,`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_cms` (
  `id_search` int(10) unsigned NOT NULL,
  `id_cms` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_search`,`id_cms`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_1` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_10` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=552 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_10_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_10_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_10_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_11` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=594 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_11_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_11_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_11_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_12` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=934 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_12_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_12_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_12_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_13` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=599 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_13_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_13_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_13_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_15` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_15_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_15_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_15_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_16` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=599 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_16_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_16_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_16_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_17` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=616 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_17_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_17_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_17_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_18` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=651 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_18_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_18_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_18_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_19` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=623 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_19_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_19_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_19_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_1_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_1_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_1_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_2` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=608 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_20` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=644 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_20_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_20_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_20_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_2_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_2_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_2_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_3` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=1025 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_3_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_3_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_3_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_4` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=999 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_4_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_4_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_4_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_5` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_5_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_5_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_5_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_6` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=580 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_6_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_6_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_6_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_8` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=578 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_8_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_8_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_8_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_9` (
  `id_criterion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `position` int(10) unsigned DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_parent` int(10) unsigned DEFAULT NULL,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `is_custom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_criterion`),
  KEY `id_criterion_group` (`id_criterion_group`),
  KEY `level_depth` (`level_depth`),
  KEY `position` (`position`),
  KEY `id_parent` (`id_parent`),
  KEY `visible` (`visible`),
  KEY `is_custom` (`is_custom`),
  KEY `gcfsb_1` (`id_criterion`,`id_criterion_group`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=589 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_9_lang` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `decimal_value` decimal(20,6) DEFAULT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_lang`),
  KEY `value` (`value`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`),
  KEY `decimal_value` (`decimal_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_9_link` (
  `id_criterion` int(10) unsigned NOT NULL,
  `id_criterion_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion`,`id_criterion_linked`),
  KEY `id_criterion` (`id_criterion`),
  KEY `id_criterion_linked` (`id_criterion_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_9_list` (
  `id_criterion_parent` int(10) unsigned NOT NULL,
  `id_criterion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_criterion_parent`,`id_criterion`),
  KEY `id_criterion_parent` (`id_criterion_parent`),
  KEY `id_criterion` (`id_criterion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_1` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_10` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_10_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_11` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_11_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_12` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_12_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_13` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_13_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_15` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_15_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_16` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_16_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_17` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_17_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_18` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_18_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_19` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_19_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_1_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_2` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_20` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_20_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_2_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_3` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_3_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_4` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_4_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_5` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_5_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_6` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_6_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_8` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_8_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_9` (
  `id_criterion_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `criterion_group_type` varchar(24) NOT NULL,
  `sort_by` varchar(10) DEFAULT 'position',
  `sort_way` varchar(4) DEFAULT 'ASC',
  `id_criterion_group_linked` int(10) unsigned NOT NULL,
  `display_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `context_type` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `is_multicriteria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `filter_option` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_combined` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `range_nb` decimal(10,2) unsigned NOT NULL DEFAULT 15.00,
  `show_all_depth` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `only_children` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hidden` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `max_display` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `css_classes` varchar(255) DEFAULT 'col-xs-12 col-sm-3',
  `overflow_height` smallint(4) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `visible` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_criterion_group`),
  KEY `id_search` (`id_search`,`visible`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_criterion_group_9_lang` (
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url_identifier` varchar(255) NOT NULL,
  `url_identifier_original` varchar(255) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `range_sign` varchar(32) DEFAULT NULL,
  `range_interval` varchar(255) DEFAULT NULL,
  `all_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_criterion_group`,`id_lang`),
  KEY `url_identifier` (`url_identifier`),
  KEY `url_identifier_original` (`url_identifier_original`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_lang` (
  `id_search` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id_search`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_manufacturers` (
  `id_search` int(10) unsigned NOT NULL,
  `id_manufacturer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_search`,`id_manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_1` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_10` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_11` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_12` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_13` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_15` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_16` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_17` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_18` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_19` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_2` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_20` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_3` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_4` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_5` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_6` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_8` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_product_price_9` (
  `id_cache_product` int(10) unsigned NOT NULL,
  `id_criterion_group` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `price_wt` decimal(20,6) NOT NULL,
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reduction_type` enum('amount','percentage') DEFAULT NULL,
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  `is_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `has_no_specific` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `id_specific_price` int(10) unsigned DEFAULT NULL,
  `valid_id_specific_price` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id_cache_product`,`id_currency`,`id_country`,`id_group`,`price_wt`,`from`,`to`,`reduction_amount`),
  KEY `id_cache_product` (`id_cache_product`),
  KEY `is_specific` (`is_specific`),
  KEY `has_no_specific` (`has_no_specific`),
  KEY `valid_id_specific_price` (`valid_id_specific_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_products` (
  `id_search` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_search`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_products_cat` (
  `id_search` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_search`,`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_seo` (
  `id_seo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_search` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `criteria` text NOT NULL,
  `seo_key` varchar(32) NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_seo`),
  UNIQUE KEY `seo_key` (`seo_key`),
  KEY `id_search` (`id_search`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_seo_crosslinks` (
  `id_seo` int(10) unsigned NOT NULL,
  `id_seo_linked` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_seo`,`id_seo_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_seo_lang` (
  `id_seo` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `meta_title` varchar(128) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keywords` varchar(255) NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `seo_url` varchar(128) NOT NULL,
  PRIMARY KEY (`id_seo`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_shop` (
  `id_search` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_search`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_special_pages` (
  `id_search` int(10) unsigned NOT NULL,
  `page` varchar(255) NOT NULL,
  PRIMARY KEY (`id_search`,`page`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedsearch_suppliers` (
  `id_search` int(10) unsigned NOT NULL,
  `id_supplier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_search`,`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu` (
  `id_menu` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cms` int(10) unsigned NOT NULL DEFAULT 0,
  `id_category` int(10) unsigned NOT NULL DEFAULT 0,
  `id_supplier` int(10) unsigned NOT NULL DEFAULT 0,
  `id_manufacturer` int(10) unsigned NOT NULL DEFAULT 0,
  `id_specific_page` varchar(64) NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 0,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `txt_color_menu_tab` varchar(7) NOT NULL,
  `txt_color_menu_tab_hover` varchar(7) NOT NULL,
  `fnd_color_menu_tab` varchar(15) NOT NULL,
  `fnd_color_menu_tab_over` varchar(15) NOT NULL,
  `border_size_tab` varchar(24) NOT NULL,
  `border_color_tab` varchar(7) NOT NULL,
  `width_submenu` varchar(5) NOT NULL,
  `minheight_submenu` varchar(5) NOT NULL,
  `position_submenu` tinyint(3) unsigned NOT NULL,
  `fnd_color_submenu` varchar(15) NOT NULL,
  `border_color_submenu` varchar(7) NOT NULL,
  `border_size_submenu` varchar(24) NOT NULL,
  `privacy` tinyint(4) NOT NULL DEFAULT 0,
  `chosen_groups` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `active_desktop` tinyint(4) NOT NULL DEFAULT 1,
  `active_mobile` tinyint(4) NOT NULL DEFAULT 1,
  `target` varchar(10) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_menu`),
  KEY `active` (`active`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_columns` (
  `id_column` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` int(10) unsigned NOT NULL,
  `id_wrap` int(10) unsigned NOT NULL,
  `id_cms` int(10) unsigned NOT NULL DEFAULT 0,
  `id_category` int(10) unsigned NOT NULL DEFAULT 0,
  `id_supplier` int(10) unsigned NOT NULL DEFAULT 0,
  `id_manufacturer` int(10) unsigned NOT NULL DEFAULT 0,
  `id_specific_page` varchar(64) NOT NULL,
  `id_menu_depend` int(10) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `privacy` tinyint(4) NOT NULL DEFAULT 0,
  `chosen_groups` text NOT NULL,
  `target` varchar(10) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `active_desktop` tinyint(4) NOT NULL DEFAULT 1,
  `active_mobile` tinyint(4) NOT NULL DEFAULT 1,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_column`),
  KEY `active` (`active`),
  KEY `id_wrap` (`id_wrap`),
  KEY `id_menu_depend` (`id_menu_depend`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_columns_lang` (
  `id_column` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(256) NOT NULL,
  `value_over` text DEFAULT NULL,
  `value_under` text DEFAULT NULL,
  `link` varchar(256) NOT NULL,
  `have_icon` varchar(1) NOT NULL DEFAULT '',
  `image_type` varchar(4) NOT NULL,
  `image_legend` varchar(256) NOT NULL DEFAULT '',
  UNIQUE KEY `id_column` (`id_column`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_columns_wrap` (
  `id_wrap` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` int(10) unsigned NOT NULL,
  `id_menu_depend` int(10) unsigned NOT NULL,
  `internal_name` varchar(256) NOT NULL,
  `bg_color` varchar(15) NOT NULL,
  `txt_color_column` varchar(7) NOT NULL,
  `txt_color_column_over` varchar(7) NOT NULL,
  `txt_color_element` varchar(7) NOT NULL,
  `txt_color_element_over` varchar(7) NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `width` smallint(4) unsigned NOT NULL DEFAULT 0,
  `privacy` tinyint(4) NOT NULL DEFAULT 0,
  `chosen_groups` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `active_desktop` tinyint(4) NOT NULL DEFAULT 1,
  `active_mobile` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_wrap`),
  KEY `active` (`active`),
  KEY `id_menu` (`id_menu`),
  KEY `id_menu_depend` (`id_menu_depend`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_columns_wrap_lang` (
  `id_wrap` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value_over` text DEFAULT NULL,
  `value_under` text DEFAULT NULL,
  UNIQUE KEY `id_wrap` (`id_wrap`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_elements` (
  `id_element` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_column` int(10) unsigned NOT NULL,
  `id_cms` int(10) unsigned NOT NULL DEFAULT 0,
  `id_category` int(10) unsigned NOT NULL DEFAULT 0,
  `id_supplier` int(10) unsigned NOT NULL DEFAULT 0,
  `id_manufacturer` int(10) unsigned NOT NULL DEFAULT 0,
  `id_specific_page` varchar(64) NOT NULL,
  `id_column_depend` int(10) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `privacy` tinyint(4) NOT NULL DEFAULT 0,
  `chosen_groups` text NOT NULL,
  `target` varchar(10) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `active_desktop` tinyint(4) NOT NULL DEFAULT 1,
  `active_mobile` tinyint(4) NOT NULL DEFAULT 1,
  `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_element`),
  KEY `id_column` (`id_column`),
  KEY `id_column_depend` (`id_column_depend`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_elements_lang` (
  `id_element` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `link` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `have_icon` varchar(1) NOT NULL DEFAULT '',
  `image_type` varchar(4) NOT NULL,
  `image_legend` varchar(256) NOT NULL DEFAULT '',
  UNIQUE KEY `id_element` (`id_element`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_lang` (
  `id_menu` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(256) NOT NULL,
  `value_over` text DEFAULT NULL,
  `value_under` text DEFAULT NULL,
  `link` varchar(256) NOT NULL,
  `have_icon` varchar(1) NOT NULL DEFAULT '',
  `image_type` varchar(4) NOT NULL,
  `image_legend` varchar(256) NOT NULL DEFAULT '',
  UNIQUE KEY `id_column` (`id_menu`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_prod_column` (
  `id_product_column` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_column` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL DEFAULT 0,
  `p_image_type` varchar(32) NOT NULL,
  `show_title` tinyint(4) NOT NULL DEFAULT 1,
  `show_price` tinyint(4) NOT NULL DEFAULT 1,
  `show_add_to_cart` tinyint(4) NOT NULL DEFAULT 1,
  `show_more_info` tinyint(4) NOT NULL DEFAULT 1,
  `show_quick_view` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_product_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtopmenu_shop` (
  `id_menu` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_menu`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard` (
  `id_tracking` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tracking_code` text NOT NULL,
  `internal_name` varchar(256) NOT NULL,
  `page` varchar(256) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `insert_into` tinyint(4) NOT NULL DEFAULT 0,
  `is_extension` tinyint(4) NOT NULL DEFAULT 0,
  `position` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_tracking`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard_category` (
  `id_tracking` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  KEY `id_tracking` (`id_tracking`,`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard_extensions` (
  `id_extension` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension_name` varchar(256) NOT NULL,
  PRIMARY KEY (`id_extension`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard_extensions_id` (
  `id_extension` int(10) unsigned NOT NULL,
  `id_tracking` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_tracking`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard_extensions_var` (
  `id_tracking` int(10) unsigned NOT NULL,
  `var_name` varchar(255) NOT NULL,
  `value` varchar(256) NOT NULL,
  KEY `id_tracking` (`id_tracking`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard_product` (
  `id_tracking` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  KEY `id_tracking` (`id_tracking`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pm_advancedtrackingwizard_shop` (
  `id_tracking` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_tracking`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_antispam` (
  `id_prestablog_antispam` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_prestablog_antispam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_antispam_lang` (
  `id_prestablog_antispam` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `question` varchar(255) NOT NULL,
  `reply` varchar(255) NOT NULL,
  `checksum` varchar(32) NOT NULL,
  PRIMARY KEY (`id_prestablog_antispam`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_categorie` (
  `id_prestablog_categorie` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `parent` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_prestablog_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_categorie_group` (
  `id_prestablog_categorie` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_categorie_lang` (
  `id_prestablog_categorie` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `meta_description` text NOT NULL,
  `meta_keywords` text NOT NULL,
  `meta_title` text NOT NULL,
  `link_rewrite` text NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id_prestablog_categorie`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_commentnews` (
  `id_prestablog_commentnews` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `news` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `comment` text NOT NULL,
  `actif` int(1) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id_prestablog_commentnews`)
) ENGINE=InnoDB AUTO_INCREMENT=1363 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_commentnews_abo` (
  `id_prestablog_commentnews_abo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `news` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_prestablog_commentnews_abo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_correspondancecategorie` (
  `id_prestablog_correspondancecategorie` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `categorie` int(10) unsigned NOT NULL,
  `news` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_prestablog_correspondancecategorie`)
) ENGINE=InnoDB AUTO_INCREMENT=884 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_news` (
  `id_prestablog_news` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `date_modification` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `langues` text NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `slide` tinyint(1) NOT NULL DEFAULT 0,
  `url_redirect` text NOT NULL,
  PRIMARY KEY (`id_prestablog_news`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_news_lang` (
  `id_prestablog_news` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `paragraph` text NOT NULL,
  `content` text NOT NULL,
  `meta_description` text NOT NULL,
  `meta_keywords` text NOT NULL,
  `meta_title` text NOT NULL,
  `link_rewrite` text NOT NULL,
  `actif_langue` tinyint(1) NOT NULL DEFAULT 1,
  `read` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_prestablog_news`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_news_newslink` (
  `id_prestablog_news_newslink` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_prestablog_news` int(10) unsigned NOT NULL,
  `id_prestablog_newslink` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_prestablog_news_newslink`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_news_product` (
  `id_prestablog_news_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_prestablog_news` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_prestablog_news_product`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_subblock` (
  `id_prestablog_subblock` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hook_name` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `langues` text NOT NULL,
  `select_type` int(10) unsigned NOT NULL,
  `nb_list` int(10) unsigned NOT NULL,
  `random` tinyint(1) NOT NULL DEFAULT 0,
  `position` int(10) unsigned NOT NULL,
  `title_length` int(10) unsigned NOT NULL,
  `intro_length` int(10) unsigned NOT NULL,
  `use_date_start` tinyint(1) NOT NULL DEFAULT 0,
  `date_start` datetime NOT NULL,
  `use_date_stop` tinyint(1) NOT NULL DEFAULT 0,
  `date_stop` datetime NOT NULL,
  `blog_link` tinyint(1) NOT NULL DEFAULT 0,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_prestablog_subblock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_subblock_categories` (
  `id_prestablog_subblock` int(10) unsigned NOT NULL,
  `categorie` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_prestablog_subblock`,`categorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_prestablog_subblock_lang` (
  `id_prestablog_subblock` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id_prestablog_subblock`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product` (
  `id_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_supplier` int(10) unsigned DEFAULT NULL,
  `id_manufacturer` int(10) unsigned DEFAULT NULL,
  `id_category_default` int(10) unsigned DEFAULT NULL,
  `id_shop_default` int(10) unsigned NOT NULL DEFAULT 1,
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `on_sale` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `online_only` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ean13` varchar(13) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `ecotax` decimal(17,6) NOT NULL DEFAULT 0.000000,
  `quantity` int(10) NOT NULL DEFAULT 0,
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT 1,
  `price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `unity` varchar(255) DEFAULT NULL,
  `unit_price_ratio` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `additional_shipping_cost` decimal(20,2) NOT NULL DEFAULT 0.00,
  `reference` varchar(32) DEFAULT NULL,
  `supplier_reference` varchar(32) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `width` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `height` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `depth` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `weight` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `out_of_stock` int(10) unsigned NOT NULL DEFAULT 2,
  `quantity_discount` tinyint(1) DEFAULT 0,
  `customizable` tinyint(2) NOT NULL DEFAULT 0,
  `uploadable_files` tinyint(4) NOT NULL DEFAULT 0,
  `text_fields` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `redirect_type` enum('','404','301','302') NOT NULL DEFAULT '',
  `id_product_redirected` int(10) unsigned NOT NULL DEFAULT 0,
  `available_for_order` tinyint(1) NOT NULL DEFAULT 1,
  `available_date` date DEFAULT '0000-00-00',
  `condition` enum('new','used','refurbished') NOT NULL DEFAULT 'new',
  `show_price` tinyint(1) NOT NULL DEFAULT 1,
  `indexed` tinyint(1) NOT NULL DEFAULT 0,
  `visibility` enum('both','catalog','search','none') NOT NULL DEFAULT 'both',
  `cache_is_pack` tinyint(1) NOT NULL DEFAULT 0,
  `cache_has_attachments` tinyint(1) NOT NULL DEFAULT 0,
  `is_virtual` tinyint(1) NOT NULL DEFAULT 0,
  `cache_default_attribute` int(10) unsigned DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `advanced_stock_management` tinyint(1) NOT NULL DEFAULT 0,
  `pack_stock_type` int(11) unsigned NOT NULL DEFAULT 3,
  PRIMARY KEY (`id_product`),
  KEY `product_supplier` (`id_supplier`),
  KEY `product_manufacturer` (`id_manufacturer`,`id_product`),
  KEY `id_category_default` (`id_category_default`),
  KEY `indexed` (`indexed`),
  KEY `date_add` (`date_add`),
  KEY `idx_id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=23154 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attachment` (
  `id_product` int(10) unsigned NOT NULL,
  `id_attachment` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_attachment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute` (
  `id_product_attribute` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `reference` varchar(32) DEFAULT NULL,
  `supplier_reference` varchar(32) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `ecotax` decimal(17,6) NOT NULL DEFAULT 0.000000,
  `quantity` int(10) NOT NULL DEFAULT 0,
  `weight` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `unit_price_impact` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `default_on` tinyint(1) unsigned DEFAULT NULL,
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT 1,
  `available_date` date DEFAULT '0000-00-00',
  PRIMARY KEY (`id_product_attribute`),
  UNIQUE KEY `product_default` (`id_product`,`default_on`),
  KEY `product_attribute_product` (`id_product`),
  KEY `reference` (`reference`),
  KEY `supplier_reference` (`supplier_reference`),
  KEY `id_product_id_product_attribute` (`id_product_attribute`,`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=54277 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute_combination` (
  `id_attribute` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_attribute`,`id_product_attribute`),
  KEY `id_product_attribute` (`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute_image` (
  `id_product_attribute` int(10) unsigned NOT NULL,
  `id_image` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product_attribute`,`id_image`),
  KEY `id_image` (`id_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute_shop` (
  `id_product` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `ecotax` decimal(17,6) NOT NULL DEFAULT 0.000000,
  `weight` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `unit_price_impact` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `default_on` tinyint(1) unsigned DEFAULT NULL,
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT 1,
  `available_date` date DEFAULT '0000-00-00',
  PRIMARY KEY (`id_product_attribute`,`id_shop`),
  UNIQUE KEY `id_product` (`id_product`,`id_shop`,`default_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_carrier` (
  `id_product` int(10) unsigned NOT NULL,
  `id_carrier_reference` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_carrier_reference`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_country_tax` (
  `id_product` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_tax` int(11) NOT NULL,
  PRIMARY KEY (`id_product`,`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_download` (
  `id_product_download` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `display_filename` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_expiration` datetime DEFAULT NULL,
  `nb_days_accessible` int(10) unsigned DEFAULT NULL,
  `nb_downloadable` int(10) unsigned DEFAULT 1,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `is_shareable` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_product_download`),
  UNIQUE KEY `id_product` (`id_product`),
  KEY `product_active` (`id_product`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_group_reduction_cache` (
  `id_product` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `reduction` decimal(4,3) NOT NULL,
  PRIMARY KEY (`id_product`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_lang` (
  `id_product` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `description_short` text DEFAULT NULL,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `available_now` varchar(255) DEFAULT NULL,
  `available_later` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_product`,`id_shop`,`id_lang`),
  KEY `id_lang` (`id_lang`),
  KEY `name` (`name`),
  KEY `idx_id_lang` (`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_sale` (
  `id_product` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `sale_nbr` int(10) unsigned NOT NULL DEFAULT 0,
  `date_upd` date NOT NULL,
  PRIMARY KEY (`id_product`),
  KEY `quantity` (`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_shop` (
  `id_product` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `id_category_default` int(10) unsigned DEFAULT NULL,
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `on_sale` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `online_only` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ecotax` decimal(17,6) NOT NULL DEFAULT 0.000000,
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT 1,
  `price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `unity` varchar(255) DEFAULT NULL,
  `unit_price_ratio` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `additional_shipping_cost` decimal(20,2) NOT NULL DEFAULT 0.00,
  `customizable` tinyint(2) NOT NULL DEFAULT 0,
  `uploadable_files` tinyint(4) NOT NULL DEFAULT 0,
  `text_fields` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `redirect_type` enum('','404','301','302') NOT NULL DEFAULT '',
  `id_product_redirected` int(10) unsigned NOT NULL DEFAULT 0,
  `available_for_order` tinyint(1) NOT NULL DEFAULT 1,
  `available_date` date DEFAULT '0000-00-00',
  `condition` enum('new','used','refurbished') NOT NULL DEFAULT 'new',
  `show_price` tinyint(1) NOT NULL DEFAULT 1,
  `indexed` tinyint(1) NOT NULL DEFAULT 0,
  `visibility` enum('both','catalog','search','none') NOT NULL DEFAULT 'both',
  `cache_default_attribute` int(10) unsigned DEFAULT NULL,
  `advanced_stock_management` tinyint(1) NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `pack_stock_type` int(11) unsigned NOT NULL DEFAULT 3,
  PRIMARY KEY (`id_product`,`id_shop`),
  KEY `id_category_default` (`id_category_default`),
  KEY `date_add` (`date_add`,`active`,`visibility`),
  KEY `indexed` (`indexed`,`active`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_supplier` (
  `id_product_supplier` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL DEFAULT 0,
  `id_supplier` int(11) unsigned NOT NULL,
  `product_supplier_reference` varchar(32) DEFAULT NULL,
  `product_supplier_price_te` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `id_currency` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_product_supplier`),
  UNIQUE KEY `id_product` (`id_product`,`id_product_attribute`,`id_supplier`),
  KEY `id_supplier` (`id_supplier`,`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=13801 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_tag` (
  `id_product` int(10) unsigned NOT NULL,
  `id_tag` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_tag`),
  KEY `id_tag` (`id_tag`),
  KEY `id_lang` (`id_lang`,`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_texture` (
  `id_product` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE KEY `ps_product_texture_id_product_uindex` (`id_product`),
  CONSTRAINT `ps_product_texture_ps_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_productredirects` (
  `id_product` int(10) unsigned NOT NULL DEFAULT 0,
  `id_category` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_product`,`id_category`),
  KEY `ps_productredirects_ps_category_id_category_fk` (`id_category`),
  KEY `ps_productredirects_id_product_index` (`id_product`),
  CONSTRAINT `ps_productredirects_ps_category_id_category_fk` FOREIGN KEY (`id_category`) REFERENCES `ps_category` (`id_category`) ON UPDATE CASCADE,
  CONSTRAINT `ps_productredirects_ps_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_profile` (
  `id_profile` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_profile_lang` (
  `id_lang` int(10) unsigned NOT NULL,
  `id_profile` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id_profile`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule` (
  `id_quantity_discount_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `description` text DEFAULT NULL,
  `id_family` int(10) DEFAULT NULL,
  `code` varchar(254) DEFAULT NULL,
  `code_prefix` varchar(254) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `priority` int(10) DEFAULT NULL,
  `execute_other_rules` tinyint(1) NOT NULL,
  `compatible_cart_rules` tinyint(1) NOT NULL,
  `compatible_qdp_rules` tinyint(1) NOT NULL,
  `apply_products_already_discounted` tinyint(1) NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity_per_user` int(10) unsigned NOT NULL DEFAULT 0,
  `modules_exceptions` text DEFAULT NULL,
  `highlight` tinyint(1) NOT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_quantity_discount_rule`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_type` int(10) unsigned NOT NULL,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `reduction_amount` decimal(17,2) NOT NULL,
  `reduction_buy_amount` decimal(17,2) NOT NULL,
  `reduction_buy_amount_tax` tinyint(1) NOT NULL,
  `reduction_buy_over` decimal(17,2) NOT NULL,
  `reduction_currency` int(10) unsigned NOT NULL,
  `reduction_tax` tinyint(1) NOT NULL,
  `reduction_percent` decimal(5,2) NOT NULL,
  `reduction_percent_tax` tinyint(1) NOT NULL,
  `reduction_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `reduction_percent_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `reduction_percent_discount` tinyint(1) NOT NULL DEFAULT 0,
  `reduction_max_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `reduction_product_max_amount` decimal(17,2) NOT NULL DEFAULT 0.00,
  `reduction_max_currency` int(10) unsigned NOT NULL,
  `spent_amount_from` decimal(17,2) NOT NULL DEFAULT 0.00,
  `spent_amount_to` decimal(17,2) NOT NULL DEFAULT 0.00,
  `spent_currency` int(10) unsigned NOT NULL,
  `spent_tax` tinyint(1) NOT NULL,
  `product_price_from` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_price_from_currency` int(10) unsigned NOT NULL,
  `product_price_from_tax` tinyint(1) NOT NULL,
  `product_price_to` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_price_to_currency` int(10) unsigned NOT NULL,
  `product_price_to_tax` tinyint(1) NOT NULL,
  `apply_discount_sort` enum('cheapest','expensive') NOT NULL,
  `apply_discount_to_nb` int(10) unsigned NOT NULL,
  `apply_discount_to_all` tinyint(1) unsigned NOT NULL,
  `apply_discount_to_special` tinyint(1) unsigned NOT NULL,
  `apply_discount_to_regular_price` tinyint(1) unsigned NOT NULL,
  `apply_discount_to_stock` tinyint(1) unsigned NOT NULL,
  `nb_repetitions` varchar(255) NOT NULL,
  `products_nb_same_attributes` tinyint(1) unsigned NOT NULL,
  `nb_repetitions_custom` int(10) unsigned NOT NULL,
  `products_nb_each` int(10) unsigned NOT NULL,
  `products_default_category` tinyint(1) unsigned NOT NULL,
  `group_products_by` varchar(255) DEFAULT NULL,
  `stock_operator` tinyint(1) unsigned DEFAULT NULL,
  `stock` int(10) DEFAULT NULL,
  `gift_product` int(10) unsigned DEFAULT NULL,
  `gift_product_attribute` int(10) unsigned DEFAULT NULL,
  `filter_by_product` tinyint(1) unsigned NOT NULL,
  `filter_by_attribute` tinyint(1) unsigned NOT NULL,
  `filter_by_feature` tinyint(1) unsigned NOT NULL,
  `filter_by_category` tinyint(1) unsigned NOT NULL,
  `filter_by_supplier` tinyint(1) unsigned NOT NULL,
  `filter_by_manufacturer` tinyint(1) unsigned NOT NULL,
  `filter_by_price` tinyint(1) unsigned NOT NULL,
  `filter_by_stock` tinyint(1) unsigned NOT NULL,
  `filter_by_carrier` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_attribute` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_attribute` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_attribute`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_carrier` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_carrier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_carrier`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_category` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_category`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_feature` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_feature` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_feature`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_manufacturer` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_manufacturer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_manufacturer`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_product` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_product`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_action_supplier` (
  `id_quantity_discount_rule_action` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_supplier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_action`,`id_quantity_discount_rule`,`id_supplier`),
  KEY `id_quantity_discount_rule_action` (`id_quantity_discount_rule_action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_cart` (
  `id_cart` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_action_type` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_cart`,`id_quantity_discount_rule`,`id_cart_rule`),
  KEY `id_cart` (`id_cart`),
  KEY `id_cart_id_cart_rule` (`id_cart`,`id_cart_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_cart_product` (
  `id_cart` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  KEY `id_cart_id_quantity_discount_rule` (`id_cart`,`id_quantity_discount_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule_group` int(10) unsigned NOT NULL,
  `id_type` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned DEFAULT NULL,
  `customer_default_group` tinyint(1) unsigned DEFAULT NULL,
  `customer_newsletter` tinyint(1) unsigned DEFAULT NULL,
  `customer_vat` tinyint(1) unsigned DEFAULT NULL,
  `customer_signedup_date_from` datetime DEFAULT NULL,
  `customer_signedup_date_to` datetime DEFAULT NULL,
  `customer_signedup_days` int(10) unsigned DEFAULT NULL,
  `customer_orders_nb_operator` tinyint(1) unsigned DEFAULT NULL,
  `customer_orders_nb` int(10) unsigned DEFAULT NULL,
  `customer_orders_nb_date_from` datetime DEFAULT NULL,
  `customer_orders_nb_date_to` datetime DEFAULT NULL,
  `customer_orders_nb_days` int(10) unsigned DEFAULT NULL,
  `customer_orders_nb_prod_operator` tinyint(1) unsigned DEFAULT NULL,
  `customer_orders_nb_prod` int(10) unsigned DEFAULT NULL,
  `customer_orders_amount_operator` tinyint(1) unsigned DEFAULT NULL,
  `customer_orders_amount` decimal(17,2) DEFAULT NULL,
  `customer_orders_amount_currency` int(10) unsigned DEFAULT NULL,
  `customer_orders_amount_tax` tinyint(1) unsigned DEFAULT NULL,
  `customer_orders_amount_shipping` tinyint(1) unsigned DEFAULT NULL,
  `customer_orders_amount_discount` tinyint(1) unsigned DEFAULT NULL,
  `customer_orders_amount_date_from` datetime DEFAULT NULL,
  `customer_orders_amount_date_to` datetime DEFAULT NULL,
  `customer_orders_amount_days` int(10) unsigned DEFAULT NULL,
  `customer_orders_amount_orders` int(10) unsigned DEFAULT NULL,
  `customer_orders_amount_interval` tinyint(1) unsigned DEFAULT NULL,
  `customer_first_order` tinyint(1) unsigned DEFAULT NULL,
  `customer_membership_operator` tinyint(1) unsigned DEFAULT NULL,
  `customer_membership` int(10) unsigned DEFAULT NULL,
  `customer_birthday` tinyint(1) unsigned DEFAULT NULL,
  `customer_years_from` int(10) unsigned DEFAULT NULL,
  `customer_years_to` int(10) unsigned DEFAULT NULL,
  `cart_amount_operator` tinyint(1) unsigned DEFAULT NULL,
  `cart_amount` decimal(17,2) DEFAULT NULL,
  `cart_amount_currency` int(10) unsigned DEFAULT NULL,
  `cart_amount_tax` tinyint(1) unsigned DEFAULT NULL,
  `cart_amount_shipping` tinyint(1) unsigned DEFAULT NULL,
  `cart_amount_discount` tinyint(1) unsigned DEFAULT NULL,
  `cart_weight_operator` tinyint(1) unsigned DEFAULT NULL,
  `cart_weight` decimal(17,2) DEFAULT NULL,
  `products_all_met` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_all_met` tinyint(1) unsigned DEFAULT NULL,
  `products_operator` tinyint(1) unsigned DEFAULT NULL,
  `products_amount` decimal(17,2) DEFAULT NULL,
  `products_amount_currency` int(10) unsigned DEFAULT NULL,
  `products_amount_tax` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_operator` tinyint(1) unsigned DEFAULT NULL,
  `products_nb` int(10) unsigned DEFAULT NULL,
  `products_nb_same` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_same_attributes` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_same_category` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_dif_operator` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_dif` int(10) unsigned DEFAULT NULL,
  `products_nb_dif_cat_operator` tinyint(1) unsigned DEFAULT NULL,
  `products_nb_dif_cat` int(10) unsigned DEFAULT NULL,
  `product_price_from` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_price_from_currency` int(10) unsigned NOT NULL,
  `product_price_from_tax` tinyint(1) NOT NULL,
  `product_price_to` decimal(17,2) NOT NULL DEFAULT 0.00,
  `product_price_to_currency` int(10) unsigned NOT NULL,
  `product_price_to_tax` tinyint(1) NOT NULL,
  `product_stock_operator` tinyint(1) unsigned DEFAULT NULL,
  `product_stock_amount` int(10) DEFAULT NULL,
  `products_default_category` tinyint(1) unsigned NOT NULL,
  `apply_discount_to_special` tinyint(1) NOT NULL,
  `group_products_by` varchar(255) DEFAULT NULL,
  `filter_by_product` tinyint(1) unsigned DEFAULT NULL,
  `filter_by_attribute` tinyint(1) unsigned DEFAULT NULL,
  `filter_by_feature` tinyint(1) unsigned NOT NULL,
  `filter_by_category` tinyint(1) unsigned DEFAULT NULL,
  `filter_by_supplier` tinyint(1) unsigned DEFAULT NULL,
  `filter_by_manufacturer` tinyint(1) unsigned DEFAULT NULL,
  `filter_by_price` tinyint(1) unsigned DEFAULT NULL,
  `filter_by_stock` tinyint(1) unsigned DEFAULT NULL,
  `schedule` text DEFAULT NULL,
  `url_string` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`),
  KEY `id_quantity_discount_rule` (`id_quantity_discount_rule`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_attribute` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_attribute` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_attribute`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_carrier` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_carrier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_carrier`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_category` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_category`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_country` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_country`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_currency` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_currency`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_feature` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_feature` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_feature`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_gender` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_gender` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_gender`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_group` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_group`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_manufacturer` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_manufacturer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_manufacturer`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_order_state` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_order_state` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_product` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_product`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_shop` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_shop`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_state` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_state` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_state`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_supplier` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_supplier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_supplier`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_condition_zone` (
  `id_quantity_discount_rule_condition` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_zone` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_condition`,`id_quantity_discount_rule`,`id_zone`),
  KEY `id_quantity_discount_rule_condition` (`id_quantity_discount_rule_condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_family` (
  `id_quantity_discount_rule_family` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `priority` int(10) DEFAULT NULL,
  `execute_other_families` tinyint(1) NOT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_family`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_group` (
  `id_quantity_discount_rule_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_group`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_lang` (
  `id_lang` int(10) NOT NULL,
  `id_quantity_discount_rule` int(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lang`,`id_quantity_discount_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_message` (
  `id_quantity_discount_rule_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `hook_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_message`),
  KEY `id_quantity_discount_rule` (`id_quantity_discount_rule`),
  KEY `id_quantity_discount_rule_hook_name` (`id_quantity_discount_rule`,`hook_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_message_lang` (
  `id_quantity_discount_rule_message` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule_message`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quantity_discount_rule_order` (
  `id_order` int(10) unsigned NOT NULL,
  `id_quantity_discount_rule` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_quantity_discount_rule`,`id_cart_rule`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quick_access` (
  `id_quick_access` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `new_window` tinyint(1) NOT NULL DEFAULT 0,
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`id_quick_access`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quick_access_lang` (
  `id_quick_access` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_quick_access`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_range_price` (
  `id_range_price` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carrier` int(10) unsigned NOT NULL,
  `delimiter1` decimal(20,6) NOT NULL,
  `delimiter2` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_range_price`),
  UNIQUE KEY `id_carrier` (`id_carrier`,`delimiter1`,`delimiter2`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_range_weight` (
  `id_range_weight` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carrier` int(10) unsigned NOT NULL,
  `delimiter1` decimal(20,6) NOT NULL,
  `delimiter2` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_range_weight`),
  UNIQUE KEY `id_carrier` (`id_carrier`,`delimiter1`,`delimiter2`)
) ENGINE=InnoDB AUTO_INCREMENT=2636 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_referrer` (
  `id_referrer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `passwd` varchar(32) DEFAULT NULL,
  `http_referer_regexp` varchar(64) DEFAULT NULL,
  `http_referer_like` varchar(64) DEFAULT NULL,
  `request_uri_regexp` varchar(64) DEFAULT NULL,
  `request_uri_like` varchar(64) DEFAULT NULL,
  `http_referer_regexp_not` varchar(64) DEFAULT NULL,
  `http_referer_like_not` varchar(64) DEFAULT NULL,
  `request_uri_regexp_not` varchar(64) DEFAULT NULL,
  `request_uri_like_not` varchar(64) DEFAULT NULL,
  `base_fee` decimal(5,2) NOT NULL DEFAULT 0.00,
  `percent_fee` decimal(5,2) NOT NULL DEFAULT 0.00,
  `click_fee` decimal(5,2) NOT NULL DEFAULT 0.00,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_referrer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_referrer_cache` (
  `id_connections_source` int(11) unsigned NOT NULL,
  `id_referrer` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_connections_source`,`id_referrer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_referrer_shop` (
  `id_referrer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL DEFAULT 1,
  `cache_visitors` int(11) DEFAULT NULL,
  `cache_visits` int(11) DEFAULT NULL,
  `cache_pages` int(11) DEFAULT NULL,
  `cache_registrations` int(11) DEFAULT NULL,
  `cache_orders` int(11) DEFAULT NULL,
  `cache_sales` decimal(17,2) DEFAULT NULL,
  `cache_reg_rate` decimal(5,4) DEFAULT NULL,
  `cache_order_rate` decimal(5,4) DEFAULT NULL,
  PRIMARY KEY (`id_referrer`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_request_sql` (
  `id_request_sql` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `sql` text NOT NULL,
  PRIMARY KEY (`id_request_sql`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_required_field` (
  `id_required_field` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(32) NOT NULL,
  `field_name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_required_field`),
  KEY `object_name` (`object_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_responsivemenu_category` (
  `id_category` int(10) unsigned NOT NULL,
  `active_mobile` int(1) unsigned NOT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_risk` (
  `id_risk` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `percent` tinyint(3) NOT NULL,
  `color` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_risk`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_risk_lang` (
  `id_risk` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_risk`,`id_lang`),
  KEY `id_risk` (`id_risk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_scene` (
  `id_scene` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_scene`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_scene_category` (
  `id_scene` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_scene`,`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_scene_lang` (
  `id_scene` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id_scene`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_scene_products` (
  `id_scene` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `x_axis` int(4) NOT NULL,
  `y_axis` int(4) NOT NULL,
  `zone_width` int(3) NOT NULL,
  `zone_height` int(3) NOT NULL,
  PRIMARY KEY (`id_scene`,`id_product`,`x_axis`,`y_axis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_scene_shop` (
  `id_scene` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_scene`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_search_engine` (
  `id_search_engine` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server` varchar(64) NOT NULL,
  `getvar` varchar(16) NOT NULL,
  PRIMARY KEY (`id_search_engine`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_search_index` (
  `id_product` int(11) unsigned NOT NULL,
  `id_word` int(11) unsigned NOT NULL,
  `weight` smallint(4) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_word`,`id_product`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_search_word` (
  `id_word` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_lang` int(10) unsigned NOT NULL,
  `word` varchar(15) NOT NULL,
  PRIMARY KEY (`id_word`),
  UNIQUE KEY `id_lang` (`id_lang`,`id_shop`,`word`)
) ENGINE=InnoDB AUTO_INCREMENT=999045317 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_seoperformance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `mode` varchar(30) NOT NULL,
  `date_upd` datetime NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_seoperformance_matching_copyprod` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `urlrewrite` varchar(255) NOT NULL,
  `object` enum('product','category','cms') NOT NULL,
  `id_object` int(200) unsigned NOT NULL,
  `id_lang` smallint(10) unsigned NOT NULL,
  `id_shop` smallint(10) unsigned NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_seoperformance_matching_preprod` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `urlrewrite` varchar(255) NOT NULL,
  `object` enum('product','category','cms') NOT NULL,
  `id_object` int(200) unsigned NOT NULL,
  `id_lang` smallint(10) unsigned NOT NULL,
  `id_shop` smallint(10) unsigned NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_seoperformance_matching_prod` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `urlrewrite` varchar(255) NOT NULL,
  `object` enum('product','category','cms') NOT NULL,
  `id_object` int(200) unsigned NOT NULL,
  `id_lang` smallint(10) unsigned NOT NULL,
  `id_shop` smallint(10) unsigned NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_shop` (
  `id_shop` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `id_category` int(11) unsigned NOT NULL DEFAULT 1,
  `id_theme` int(1) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`,`deleted`),
  KEY `id_category` (`id_category`),
  KEY `id_theme` (`id_theme`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_shop_group` (
  `id_shop_group` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `share_customer` tinyint(1) NOT NULL,
  `share_order` tinyint(1) NOT NULL,
  `share_stock` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_shop_group`),
  KEY `deleted` (`deleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_shop_url` (
  `id_shop_url` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  `domain` varchar(150) NOT NULL,
  `domain_ssl` varchar(150) NOT NULL,
  `physical_uri` varchar(64) NOT NULL,
  `virtual_uri` varchar(64) NOT NULL,
  `main` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_shop_url`),
  UNIQUE KEY `full_shop_url` (`domain`,`physical_uri`,`virtual_uri`),
  UNIQUE KEY `full_shop_url_ssl` (`domain_ssl`,`physical_uri`,`virtual_uri`),
  KEY `id_shop` (`id_shop`,`main`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_sm_custom_payment` (
  `module` varchar(128) NOT NULL,
  `payment` varchar(255) NOT NULL,
  PRIMARY KEY (`module`),
  KEY `idx1_name` (`payment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_sm_picker` (
  `id_list` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_list`),
  KEY `idx1_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_sm_picker_items` (
  `id_list` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) NOT NULL,
  `id_product_attribute` int(11) NOT NULL DEFAULT 0,
  `quantity` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_list`,`id_product`,`id_product_attribute`),
  KEY `idx1_list` (`id_list`),
  KEY `idx1_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smarty_cache` (
  `id_smarty_cache` char(40) NOT NULL,
  `name` char(40) NOT NULL,
  `cache_id` varchar(254) DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT current_timestamp(),
  `content` longtext NOT NULL,
  PRIMARY KEY (`id_smarty_cache`),
  KEY `name` (`name`),
  KEY `cache_id` (`cache_id`),
  KEY `modified` (`modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smarty_last_flush` (
  `type` enum('compile','template') NOT NULL DEFAULT 'compile',
  `last_flush` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smarty_lazy_cache` (
  `template_hash` varchar(32) NOT NULL DEFAULT '',
  `cache_id` varchar(255) NOT NULL DEFAULT '',
  `compile_id` varchar(32) NOT NULL DEFAULT '',
  `filepath` varchar(255) NOT NULL DEFAULT '',
  `last_update` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`template_hash`,`cache_id`,`compile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price` (
  `id_specific_price` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_specific_price_rule` int(11) unsigned NOT NULL,
  `id_cart` int(11) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_shop_group` int(11) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `price` decimal(20,6) NOT NULL,
  `from_quantity` mediumint(8) unsigned NOT NULL,
  `reduction` decimal(20,6) NOT NULL,
  `reduction_tax` tinyint(1) NOT NULL DEFAULT 1,
  `reduction_type` enum('amount','percentage') NOT NULL,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  PRIMARY KEY (`id_specific_price`),
  UNIQUE KEY `id_product_2` (`id_product`,`id_product_attribute`,`id_customer`,`id_cart`,`from`,`to`,`id_shop`,`id_shop_group`,`id_currency`,`id_country`,`id_group`,`from_quantity`,`id_specific_price_rule`),
  KEY `id_product` (`id_product`,`id_shop`,`id_currency`,`id_country`,`id_group`,`id_customer`,`from_quantity`,`from`,`to`),
  KEY `from_quantity` (`from_quantity`),
  KEY `id_specific_price_rule` (`id_specific_price_rule`),
  KEY `id_cart` (`id_cart`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_shop` (`id_shop`),
  KEY `id_customer` (`id_customer`),
  KEY `from` (`from`),
  KEY `to` (`to`),
  KEY `ps_specific_price_idx_id_cust_id_attr_id_cart_id_shop` (`id_customer`,`id_product_attribute`,`id_cart`,`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=231153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_priority` (
  `id_specific_price_priority` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) NOT NULL,
  `priority` varchar(80) NOT NULL,
  PRIMARY KEY (`id_specific_price_priority`,`id_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=2235 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_rule` (
  `id_specific_price_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `from_quantity` mediumint(8) unsigned NOT NULL,
  `price` decimal(20,6) DEFAULT NULL,
  `reduction` decimal(20,6) NOT NULL,
  `reduction_tax` tinyint(1) NOT NULL DEFAULT 1,
  `reduction_type` enum('amount','percentage') NOT NULL,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  PRIMARY KEY (`id_specific_price_rule`),
  KEY `id_product` (`id_shop`,`id_currency`,`id_country`,`id_group`,`from_quantity`,`from`,`to`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_rule_condition` (
  `id_specific_price_rule_condition` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_specific_price_rule_condition_group` int(11) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id_specific_price_rule_condition`),
  KEY `id_specific_price_rule_condition_group` (`id_specific_price_rule_condition_group`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_rule_condition_group` (
  `id_specific_price_rule_condition_group` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_specific_price_rule` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_specific_price_rule_condition_group`,`id_specific_price_rule`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_state` (
  `id_state` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(11) unsigned NOT NULL,
  `id_zone` int(11) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `iso_code` varchar(7) NOT NULL,
  `tax_behavior` smallint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_state`),
  KEY `id_country` (`id_country`),
  KEY `name` (`name`),
  KEY `id_zone` (`id_zone`)
) ENGINE=InnoDB AUTO_INCREMENT=385 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock` (
  `id_stock` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_warehouse` int(11) unsigned NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `reference` varchar(32) NOT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `physical_quantity` int(11) unsigned NOT NULL,
  `usable_quantity` int(11) unsigned NOT NULL,
  `price_te` decimal(20,6) DEFAULT 0.000000,
  PRIMARY KEY (`id_stock`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `id_product` (`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=23354 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_available` (
  `id_stock_available` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `id_shop_group` int(11) unsigned NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT 0,
  `depends_on_stock` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `out_of_stock` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_stock_available`),
  UNIQUE KEY `product_sqlstock` (`id_product`,`id_product_attribute`,`id_shop`,`id_shop_group`),
  KEY `id_shop` (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `id_product` (`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`),
  CONSTRAINT `ps_stock_available_ps_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=162373 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_mvt` (
  `id_stock_mvt` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_stock` int(11) unsigned NOT NULL,
  `id_order` int(11) unsigned DEFAULT NULL,
  `id_supply_order` int(11) unsigned DEFAULT NULL,
  `id_stock_mvt_reason` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `employee_lastname` varchar(32) DEFAULT '',
  `employee_firstname` varchar(32) DEFAULT '',
  `physical_quantity` int(11) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `sign` tinyint(1) NOT NULL DEFAULT 1,
  `price_te` decimal(20,6) DEFAULT 0.000000,
  `last_wa` decimal(20,6) DEFAULT 0.000000,
  `current_wa` decimal(20,6) DEFAULT 0.000000,
  `referer` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_stock_mvt`),
  KEY `id_stock` (`id_stock`),
  KEY `id_stock_mvt_reason` (`id_stock_mvt_reason`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_mvt_reason` (
  `id_stock_mvt_reason` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sign` tinyint(1) NOT NULL DEFAULT 1,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_stock_mvt_reason`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_mvt_reason_lang` (
  `id_stock_mvt_reason` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_stock_mvt_reason`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_store` (
  `id_store` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned NOT NULL,
  `id_state` int(10) unsigned DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `address1` varchar(128) NOT NULL,
  `address2` varchar(128) DEFAULT NULL,
  `city` varchar(64) NOT NULL,
  `postcode` varchar(12) NOT NULL,
  `latitude` decimal(13,8) DEFAULT NULL,
  `longitude` decimal(13,8) DEFAULT NULL,
  `hours` varchar(254) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `fax` varchar(16) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_store`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_store_shop` (
  `id_store` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_store`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_capture` (
  `id_stripe_capture` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_payment_intent` varchar(40) NOT NULL,
  `id_order` int(10) NOT NULL,
  `expired` tinyint(1) unsigned NOT NULL,
  `date_catch` datetime NOT NULL,
  `date_authorize` datetime NOT NULL,
  PRIMARY KEY (`id_stripe_capture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_customer` (
  `id_stripe_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) NOT NULL,
  `stripe_customer_key` varchar(50) NOT NULL,
  `id_account` varchar(50) NOT NULL,
  PRIMARY KEY (`id_stripe_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_event` (
  `id_stripe_event` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_payment_intent` varchar(40) NOT NULL,
  `status` varchar(30) NOT NULL,
  `date_add` datetime NOT NULL,
  `is_processed` tinyint(1) unsigned NOT NULL,
  `flow_type` varchar(30) NOT NULL,
  PRIMARY KEY (`id_stripe_event`),
  UNIQUE KEY `ix_id_payment_intentstatus` (`id_payment_intent`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_idempotency_key` (
  `id_idempotency_key` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) NOT NULL,
  `idempotency_key` varchar(255) NOT NULL,
  `id_payment_intent` varchar(255) NOT NULL,
  PRIMARY KEY (`id_idempotency_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_official_processlogger` (
  `id_stripe_official_processlogger` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `msg` mediumtext NOT NULL,
  `level` varchar(10) NOT NULL,
  `object_name` varchar(100) NOT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `id_session` varchar(255) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_stripe_official_processlogger`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_payment` (
  `id_payment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_stripe` varchar(255) NOT NULL,
  `id_payment_intent` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `id_cart` int(10) NOT NULL,
  `last4` int(10) NOT NULL,
  `type` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `refund` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `result` int(10) NOT NULL,
  `state` int(10) NOT NULL,
  `voucher_url` varchar(255) NOT NULL,
  `voucher_expire` datetime NOT NULL,
  `voucher_validate` datetime NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stripe_payment_intent` (
  `id_stripe_payment_intent` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_payment_intent` varchar(40) NOT NULL,
  `status` varchar(30) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_stripe_payment_intent`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supplier` (
  `id_supplier` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supplier_lang` (
  `id_supplier` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_supplier`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supplier_shop` (
  `id_supplier` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_supplier`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order` (
  `id_supply_order` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supplier` int(11) unsigned NOT NULL,
  `supplier_name` varchar(64) NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  `id_supply_order_state` int(11) unsigned NOT NULL,
  `id_currency` int(11) unsigned NOT NULL,
  `id_ref_currency` int(11) unsigned NOT NULL,
  `reference` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `date_delivery_expected` datetime DEFAULT NULL,
  `total_te` decimal(20,6) DEFAULT 0.000000,
  `total_with_discount_te` decimal(20,6) DEFAULT 0.000000,
  `total_tax` decimal(20,6) DEFAULT 0.000000,
  `total_ti` decimal(20,6) DEFAULT 0.000000,
  `discount_rate` decimal(20,6) DEFAULT 0.000000,
  `discount_value_te` decimal(20,6) DEFAULT 0.000000,
  `is_template` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_supply_order`),
  KEY `id_supplier` (`id_supplier`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `reference` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_detail` (
  `id_supply_order_detail` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supply_order` int(11) unsigned NOT NULL,
  `id_currency` int(11) unsigned NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `reference` varchar(32) NOT NULL,
  `supplier_reference` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `exchange_rate` decimal(20,6) DEFAULT 0.000000,
  `unit_price_te` decimal(20,6) DEFAULT 0.000000,
  `quantity_expected` int(11) unsigned NOT NULL,
  `quantity_received` int(11) unsigned NOT NULL,
  `price_te` decimal(20,6) DEFAULT 0.000000,
  `discount_rate` decimal(20,6) DEFAULT 0.000000,
  `discount_value_te` decimal(20,6) DEFAULT 0.000000,
  `price_with_discount_te` decimal(20,6) DEFAULT 0.000000,
  `tax_rate` decimal(20,6) DEFAULT 0.000000,
  `tax_value` decimal(20,6) DEFAULT 0.000000,
  `price_ti` decimal(20,6) DEFAULT 0.000000,
  `tax_value_with_order_discount` decimal(20,6) DEFAULT 0.000000,
  `price_with_order_discount_te` decimal(20,6) DEFAULT 0.000000,
  PRIMARY KEY (`id_supply_order_detail`),
  KEY `id_supply_order` (`id_supply_order`,`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_product_product_attribute` (`id_product`,`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_history` (
  `id_supply_order_history` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supply_order` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `employee_lastname` varchar(32) DEFAULT '',
  `employee_firstname` varchar(32) DEFAULT '',
  `id_state` int(11) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_supply_order_history`),
  KEY `id_supply_order` (`id_supply_order`),
  KEY `id_employee` (`id_employee`),
  KEY `id_state` (`id_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_receipt_history` (
  `id_supply_order_receipt_history` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supply_order_detail` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `employee_lastname` varchar(32) DEFAULT '',
  `employee_firstname` varchar(32) DEFAULT '',
  `id_supply_order_state` int(11) unsigned NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_supply_order_receipt_history`),
  KEY `id_supply_order_detail` (`id_supply_order_detail`),
  KEY `id_supply_order_state` (`id_supply_order_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_state` (
  `id_supply_order_state` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_note` tinyint(1) NOT NULL DEFAULT 0,
  `editable` tinyint(1) NOT NULL DEFAULT 0,
  `receipt_state` tinyint(1) NOT NULL DEFAULT 0,
  `pending_receipt` tinyint(1) NOT NULL DEFAULT 0,
  `enclosed` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_supply_order_state`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_state_lang` (
  `id_supply_order_state` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_supply_order_state`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab` (
  `id_tab` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) NOT NULL,
  `class_name` varchar(64) NOT NULL,
  `module` varchar(64) DEFAULT NULL,
  `position` int(10) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `hide_host_mode` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_tab`),
  KEY `class_name` (`class_name`),
  KEY `id_parent` (`id_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab_lang` (
  `id_tab` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_tab`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab_module_preference` (
  `id_tab_module_preference` int(11) NOT NULL AUTO_INCREMENT,
  `id_employee` int(11) NOT NULL,
  `id_tab` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  PRIMARY KEY (`id_tab_module_preference`),
  UNIQUE KEY `employee_module` (`id_employee`,`id_tab`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tag` (
  `id_tag` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id_tag`),
  KEY `tag_name` (`name`),
  KEY `id_lang` (`id_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=35018 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tag_count` (
  `id_group` int(10) unsigned NOT NULL DEFAULT 0,
  `id_tag` int(10) unsigned NOT NULL DEFAULT 0,
  `id_lang` int(10) unsigned NOT NULL DEFAULT 0,
  `id_shop` int(11) unsigned NOT NULL DEFAULT 0,
  `counter` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_group`,`id_tag`),
  KEY `id_group` (`id_group`,`id_lang`,`id_shop`,`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax` (
  `id_tax` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rate` decimal(10,3) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_tax`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_lang` (
  `id_tax` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_tax`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rule` (
  `id_tax_rule` int(11) NOT NULL AUTO_INCREMENT,
  `id_tax_rules_group` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_state` int(11) NOT NULL,
  `zipcode_from` varchar(12) NOT NULL,
  `zipcode_to` varchar(12) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `behavior` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `plici_id_group` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_tax_rule`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `id_tax` (`id_tax`),
  KEY `category_getproducts` (`id_tax_rules_group`,`id_country`,`id_state`,`zipcode_from`,`plici_id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=2516 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rules_group` (
  `id_tax_rules_group` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `active` int(11) NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_tax_rules_group`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rules_group_shop` (
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_tax_rules_group`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_theme` (
  `id_theme` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `directory` varchar(64) NOT NULL,
  `responsive` tinyint(1) NOT NULL DEFAULT 0,
  `default_left_column` tinyint(1) NOT NULL DEFAULT 0,
  `default_right_column` tinyint(1) NOT NULL DEFAULT 0,
  `product_per_page` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_theme`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_theme_meta` (
  `id_theme_meta` int(11) NOT NULL AUTO_INCREMENT,
  `id_theme` int(11) NOT NULL,
  `id_meta` int(10) unsigned NOT NULL,
  `left_column` tinyint(1) NOT NULL DEFAULT 1,
  `right_column` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_theme_meta`),
  UNIQUE KEY `id_theme_2` (`id_theme`,`id_meta`),
  KEY `id_theme` (`id_theme`),
  KEY `id_meta` (`id_meta`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_theme_specific` (
  `id_theme` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `entity` int(11) unsigned NOT NULL,
  `id_object` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_theme`,`id_shop`,`entity`,`id_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_themeconfigurator` (
  `id_item` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `item_order` int(10) unsigned NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `title_use` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `hook` varchar(100) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `target` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `image` varchar(100) DEFAULT NULL,
  `image_w` varchar(10) DEFAULT NULL,
  `image_h` varchar(10) DEFAULT NULL,
  `html` text DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_item`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_timezone` (
  `id_timezone` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_timezone`)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_vc_media_lang` (
  `id_vc_media` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `legend` varchar(255) NOT NULL,
  PRIMARY KEY (`id_vc_media`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_vccontentanywhere_filter` (
  `id_vccontentanywhere` int(10) unsigned NOT NULL,
  `id_specify_page` int(10) unsigned NOT NULL,
  `page` int(2) unsigned NOT NULL,
  PRIMARY KEY (`id_vccontentanywhere`,`id_specify_page`,`page`),
  KEY `id_specify_page` (`id_specify_page`),
  KEY `page` (`page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse` (
  `id_warehouse` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_currency` int(11) unsigned NOT NULL,
  `id_address` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `reference` varchar(32) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `management_type` enum('WA','FIFO','LIFO') NOT NULL DEFAULT 'WA',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_warehouse`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse_carrier` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_warehouse`,`id_carrier`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `id_carrier` (`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse_product_location` (
  `id_warehouse_product_location` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  `location` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_warehouse_product_location`),
  UNIQUE KEY `id_product` (`id_product`,`id_product_attribute`,`id_warehouse`)
) ENGINE=InnoDB AUTO_INCREMENT=23438 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse_shop` (
  `id_shop` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_warehouse`,`id_shop`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_web_browser` (
  `id_web_browser` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_web_browser`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_webservice_account` (
  `id_webservice_account` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(32) NOT NULL,
  `description` text DEFAULT NULL,
  `class_name` varchar(50) NOT NULL DEFAULT 'WebserviceRequest',
  `is_module` tinyint(2) NOT NULL DEFAULT 0,
  `module_name` varchar(50) DEFAULT NULL,
  `active` tinyint(2) NOT NULL,
  PRIMARY KEY (`id_webservice_account`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_webservice_account_shop` (
  `id_webservice_account` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_webservice_account`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_webservice_permission` (
  `id_webservice_permission` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(50) NOT NULL,
  `method` enum('GET','POST','PUT','DELETE','HEAD') NOT NULL,
  `id_webservice_account` int(11) NOT NULL,
  PRIMARY KEY (`id_webservice_permission`),
  UNIQUE KEY `resource_2` (`resource`,`method`,`id_webservice_account`),
  KEY `resource` (`resource`),
  KEY `method` (`method`),
  KEY `id_webservice_account` (`id_webservice_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_whatsappchatblock_agent` (
  `id_whatsappchatblock_agent` int(11) NOT NULL AUTO_INCREMENT,
  `id_whatsappchatblock` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `mobile_phone` varchar(32) DEFAULT '',
  `image` varchar(150) DEFAULT NULL,
  `position` int(5) DEFAULT 0,
  `active` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_whatsappchatblock_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_whatsappchatblock_agent_lang` (
  `id_whatsappchatblock_agent` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `department` text DEFAULT NULL,
  KEY `id_whatsappchatblock_id_lang` (`id_whatsappchatblock_agent`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_zone` (
  `id_zone` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_zone`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_zone_shop` (
  `id_zone` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_zone`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_andreani_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attachment_path` varchar(255) NOT NULL,
  `id_manufacturer` int(10) unsigned DEFAULT NULL,
  `id_type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_type_path_brand` (`id_type`,`attachment_path`,`id_manufacturer`),
  KEY `fk_py_attachment_manufacturer` (`id_manufacturer`),
  CONSTRAINT `fk_py_attachment_manufacturer` FOREIGN KEY (`id_manufacturer`) REFERENCES `ps_manufacturer` (`id_manufacturer`) ON DELETE CASCADE,
  CONSTRAINT `py_attachment_py_attachment_type_id_fk` FOREIGN KEY (`id_type`) REFERENCES `py_attachment_type` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=198781 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_attachment_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `id_attachment` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `py_attachment_product_ibfk_1` (`id_product`),
  KEY `py_attachment_product_ibfk_2` (`id_attachment`),
  CONSTRAINT `py_attachment_product_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `py_attachment_product_ibfk_2` FOREIGN KEY (`id_attachment`) REFERENCES `py_attachment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=762831 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_attachment_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_by_city_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_category_tag` (
  `id_category` int(10) unsigned NOT NULL,
  `id_tag` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_category`,`id_tag`),
  KEY `py_category_tag_ps_tag_id_tag_fk` (`id_tag`),
  CONSTRAINT `py_category_tag_ps_category_id_category_fk` FOREIGN KEY (`id_category`) REFERENCES `ps_category` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `py_category_tag_ps_tag_id_tag_fk` FOREIGN KEY (`id_tag`) REFERENCES `ps_tag` (`id_tag`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_compat_tables_equivalences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `replicates_product_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `replicates_product_id` (`replicates_product_id`),
  CONSTRAINT `py_compat_tables_equivalences_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE,
  CONSTRAINT `py_compat_tables_equivalences_ibfk_2` FOREIGN KEY (`replicates_product_id`) REFERENCES `ps_product` (`id_product`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_compat_tables_replaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text_to_replace` varchar(255) NOT NULL,
  `capitalized_text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=575 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_customacces_compat_tables` (
  `Marca` text DEFAULT NULL,
  `Modelo` text DEFAULT NULL,
  `Years` text DEFAULT NULL,
  `Referencia` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_customacces_stock` (
  `reference` varchar(255) NOT NULL,
  `available_date` text DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_degend_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_givi_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_hevik_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_hours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `name` varchar(128) NOT NULL,
  `hours` float NOT NULL,
  `required_hours` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `_date_name_uc` (`date`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3232 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_list_compat_tables` (
  `id_compat_list` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(64) NOT NULL,
  `id_product` int(10) unsigned DEFAULT NULL,
  `id_manufacturer` int(10) unsigned DEFAULT NULL,
  `manufacturer_compat_list` text DEFAULT NULL,
  `manufacturer_update_date` datetime DEFAULT NULL,
  `custom_compat_list` text DEFAULT NULL,
  `custom_update_date` datetime DEFAULT NULL,
  `status` enum('auto_generated','pending_review','reviewed_ok','outdated','pending_update') NOT NULL DEFAULT 'auto_generated',
  `universal` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_compat_list`),
  UNIQUE KEY `uq_reference` (`reference`)
) ENGINE=InnoDB AUTO_INCREMENT=17293 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_list_compat_tables_history` (
  `id_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_compat_list` int(10) unsigned NOT NULL,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp(),
  `type` enum('manufacturer','custom') NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  PRIMARY KEY (`id_history`),
  KEY `idx_compat_list` (`id_compat_list`)
) ENGINE=InnoDB AUTO_INCREMENT=5439 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_nzi_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_on_board_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_order_billing_status` (
  `id_order` int(10) unsigned NOT NULL,
  `current_state` enum('NEW','INTERNAL','BILLING','REIMBURSING','OK') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `billed` tinyint(1) DEFAULT NULL,
  `billed_at` datetime DEFAULT NULL,
  `reimbursed` tinyint(1) DEFAULT NULL,
  `reimbursed_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_order`),
  KEY `ix_py_order_billing_status_current_state` (`current_state`),
  CONSTRAINT `py_order_billing_status_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `ps_orders` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_preferred_combinations` (
  `id_product` int(10) unsigned NOT NULL,
  `preferred_reference` varchar(64) NOT NULL,
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_providers_ean` (
  `id_manufacturer` int(10) unsigned NOT NULL,
  `reference` varchar(255) NOT NULL,
  `ean13` varchar(13) NOT NULL,
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_manufacturer`,`reference`),
  CONSTRAINT `py_providers_ean_ibfk_1` FOREIGN KEY (`id_manufacturer`) REFERENCES `ps_manufacturer` (`id_manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_providers_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_manufacturer` int(10) unsigned NOT NULL,
  `reference` varchar(255) NOT NULL,
  `image_url` varchar(512) NOT NULL,
  `s3_key` varchar(512) DEFAULT NULL,
  `synced_url` varchar(512) DEFAULT NULL,
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_provider_image` (`id_manufacturer`,`reference`,`image_url`(400)),
  KEY `idx_manufacturer` (`id_manufacturer`),
  CONSTRAINT `fk_providers_image_manufacturer` FOREIGN KEY (`id_manufacturer`) REFERENCES `ps_manufacturer` (`id_manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=33348 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_providers_price` (
  `id_manufacturer` int(10) unsigned NOT NULL,
  `reference` varchar(255) NOT NULL,
  `price` decimal(20,6) NOT NULL,
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_manufacturer`,`reference`),
  CONSTRAINT `py_providers_price_ibfk_1` FOREIGN KEY (`id_manufacturer`) REFERENCES `ps_manufacturer` (`id_manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_providers_stock` (
  `id_manufacturer` int(10) unsigned NOT NULL,
  `reference` varchar(255) NOT NULL,
  `status` enum('NUMERIC_STOCK','WILL_BE_AVAILABLE','DISCONTINUED') NOT NULL,
  `quantity` int(11) NOT NULL,
  `restock_date` date DEFAULT NULL,
  PRIMARY KEY (`id_manufacturer`,`reference`),
  CONSTRAINT `py_providers_stock_ibfk_1` FOREIGN KEY (`id_manufacturer`) REFERENCES `ps_manufacturer` (`id_manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_puig_color_feature_mapping` (
  `letter` char(1) NOT NULL,
  `id_feature_value` int(11) NOT NULL,
  PRIMARY KEY (`letter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_puig_compat_tables` (
  `Marca` text DEFAULT NULL,
  `Modelo` text DEFAULT NULL,
  `Years` text DEFAULT NULL,
  `Referencia` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_puig_images` (
  `id_image` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) NOT NULL,
  `image_type` enum('generic','on_bike') NOT NULL,
  `image_url` varchar(512) NOT NULL,
  PRIMARY KEY (`id_image`),
  KEY `idx_reference` (`reference`)
) ENGINE=InnoDB AUTO_INCREMENT=12390594 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_puig_stock` (
  `reference` varchar(255) NOT NULL,
  `available_date` text DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_rainers_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_rider_valley_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_shad_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_shiro_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stock_updater_logs` (
  `Timestamp` text DEFAULT NULL,
  `Log_level` text DEFAULT NULL,
  `Provider` text DEFAULT NULL,
  `Producto_activo` tinyint(1) DEFAULT NULL,
  `Product_id` double DEFAULT NULL,
  `Product_reference` text DEFAULT NULL,
  `Attribute_id` double DEFAULT NULL,
  `Attribute_ref` text DEFAULT NULL,
  `Status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Value` text DEFAULT NULL,
  `Available_date` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stock_updater_logs_old` (
  `Timestamp` text DEFAULT NULL,
  `Log_level` text DEFAULT NULL,
  `Provider` text DEFAULT NULL,
  `Producto_activo` tinyint(1) DEFAULT NULL,
  `Product_id` bigint(20) DEFAULT NULL,
  `Product_reference` text DEFAULT NULL,
  `Attribute_id` double DEFAULT NULL,
  `Attribute_ref` text DEFAULT NULL,
  `Status` text DEFAULT NULL,
  `Value` double DEFAULT NULL,
  `Available_date` double DEFAULT NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`Producto_activo` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stock_updatr_logs` (
  `Timestamp` text DEFAULT NULL,
  `Log_level` text DEFAULT NULL,
  `Provider` text DEFAULT NULL,
  `Producto_activo` tinyint(1) DEFAULT NULL,
  `Product_id` double DEFAULT NULL,
  `Product_reference` text DEFAULT NULL,
  `Attribute_id` double DEFAULT NULL,
  `Attribute_ref` text DEFAULT NULL,
  `Status` text DEFAULT NULL,
  `Value` text DEFAULT NULL,
  `Available_date` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stocks` (
  `id_stock` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(32) NOT NULL,
  `id_manufacturer` int(10) unsigned NOT NULL,
  `id_location` int(11) NOT NULL,
  `id_location_box` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `date_add` datetime DEFAULT current_timestamp(),
  `date_upd` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_stock`),
  UNIQUE KEY `reference` (`reference`),
  KEY `id_manufacturer` (`id_manufacturer`),
  KEY `id_location` (`id_location`),
  KEY `id_location_box` (`id_location_box`),
  KEY `idx_reference` (`reference`),
  CONSTRAINT `py_stocks_ibfk_1` FOREIGN KEY (`id_manufacturer`) REFERENCES `ps_manufacturer` (`id_manufacturer`),
  CONSTRAINT `py_stocks_ibfk_2` FOREIGN KEY (`id_location`) REFERENCES `py_stocks_locations` (`id_location`),
  CONSTRAINT `py_stocks_ibfk_3` FOREIGN KEY (`id_location_box`) REFERENCES `py_stocks_locations_box` (`id_box`)
) ENGINE=InnoDB AUTO_INCREMENT=1164 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stocks_history` (
  `id_history` int(11) NOT NULL AUTO_INCREMENT,
  `id_stock` int(11) NOT NULL,
  `initial_quantity` int(11) NOT NULL,
  `final_quantity` int(11) NOT NULL,
  `date_upd` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_history`),
  KEY `id_stock` (`id_stock`),
  CONSTRAINT `py_stocks_history_ibfk_1` FOREIGN KEY (`id_stock`) REFERENCES `py_stocks` (`id_stock`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stocks_locations` (
  `id_location` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`id_location`),
  UNIQUE KEY `location` (`location`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_stocks_locations_box` (
  `id_box` int(11) NOT NULL AUTO_INCREMENT,
  `id_location` int(11) NOT NULL,
  `box` varchar(255) NOT NULL,
  PRIMARY KEY (`id_box`),
  KEY `id_location` (`id_location`),
  CONSTRAINT `py_stocks_locations_box_ibfk_1` FOREIGN KEY (`id_location`) REFERENCES `py_stocks_locations` (`id_location`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template` (
  `id_template` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_manufacturer` int(11) NOT NULL,
  `date_add` datetime NOT NULL DEFAULT current_timestamp(),
  `date_upd` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_template`),
  KEY `idx_manufacturer` (`id_manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_input` (
  `id_input` int(11) NOT NULL AUTO_INCREMENT,
  `id_template` int(11) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `position` smallint(6) NOT NULL DEFAULT 0,
  `is_system` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_input`),
  UNIQUE KEY `uniq_template_key` (`id_template`,`key_name`),
  KEY `idx_template_pos` (`id_template`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_names` (
  `id_names` int(11) NOT NULL AUTO_INCREMENT,
  `id_template` int(11) NOT NULL,
  `id_lang` tinyint(4) NOT NULL,
  `name_tpl` varchar(500) NOT NULL DEFAULT '',
  `meta_title` varchar(500) NOT NULL DEFAULT '',
  `meta_description` varchar(1000) NOT NULL DEFAULT '',
  `link_rewrite` varchar(500) NOT NULL DEFAULT '',
  `description_short` text NOT NULL,
  PRIMARY KEY (`id_names`),
  UNIQUE KEY `uniq_template_lang` (`id_template`,`id_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_point` (
  `id_point` int(11) NOT NULL AUTO_INCREMENT,
  `id_template` int(11) NOT NULL,
  `point_type` char(2) NOT NULL DEFAULT 'p',
  `position` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_point`),
  KEY `idx_template_pos` (`id_template`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_point_variant` (
  `id_variant` int(11) NOT NULL AUTO_INCREMENT,
  `id_point` int(11) NOT NULL,
  `id_lang` tinyint(4) NOT NULL,
  `variant_text` text NOT NULL,
  PRIMARY KEY (`id_variant`),
  KEY `idx_point_lang` (`id_point`,`id_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_product` (
  `id_product_tpl` int(11) NOT NULL AUTO_INCREMENT,
  `id_template` int(11) NOT NULL,
  `reference` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `position` smallint(6) NOT NULL DEFAULT 0,
  `id_product` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_product_tpl`),
  UNIQUE KEY `uniq_template_ref` (`id_template`,`reference`),
  KEY `idx_template_pos` (`id_template`,`position`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_product_point` (
  `id_product_tpl` int(11) NOT NULL,
  `id_point` int(11) NOT NULL,
  PRIMARY KEY (`id_product_tpl`,`id_point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_template_product_value` (
  `id_value` int(11) NOT NULL AUTO_INCREMENT,
  `id_product_tpl` int(11) NOT NULL,
  `id_input` int(11) NOT NULL,
  `id_lang` tinyint(4) NOT NULL,
  `value` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_value`),
  UNIQUE KEY `uniq_product_input_lang` (`id_product_tpl`,`id_input`,`id_lang`),
  KEY `idx_product_tpl` (`id_product_tpl`)
) ENGINE=InnoDB AUTO_INCREMENT=16823 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_tucano_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_unik_stock` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_unik_stock_old` (
  `reference` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_diagnostic_session` (
  `session_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_date` datetime NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `session_date` (`session_date`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_duplicate_meta_descr` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `id_lang` int(9) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `meta_descr` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `id_lang` (`id_lang`),
  KEY `idx_prod` (`id_product`,`id_shop`,`id_lang`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1633 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_duplicate_meta_titles` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `id_lang` int(9) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `id_lang` (`id_lang`),
  KEY `idx_prod` (`id_product`,`id_shop`,`id_lang`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_external_urls_in_descr` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `id_langs` varchar(255) NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `idx_prod` (`id_product`,`id_shop`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_html_tag_in_meta` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `id_langs` varchar(255) NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `idx_prod` (`id_product`,`id_shop`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_meta_out_of_range` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `id_langs` varchar(255) NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `id_hint` int(3) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `idx_prod` (`id_product`,`id_shop`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5775 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_missing_images` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `image_id` int(9) unsigned NOT NULL,
  `product_id` int(9) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `image_title` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_missing_meta` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `id_langs` varchar(255) NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `idx_prod` (`id_product`,`id_shop`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_missing_product_langs` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `id_langs` varchar(255) NOT NULL,
  `id_shops` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_missing_thumbnail_images` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `image_id` int(9) unsigned NOT NULL,
  `product_id` int(9) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `image_title` varchar(255) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `thumbnails` text DEFAULT '',
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=71494 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_needless_product_langs` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `id_lang` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_needless_product_shops` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_needless_stock_avail_records` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_stock_available` int(11) unsigned NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_product_without_image` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `prod_id` int(9) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `prod_sku` varchar(255) NOT NULL,
  `prod_title` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_shop` (`id_shop`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=862 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_product_without_image_cover` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `id_shop` int(9) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_product_shop` (`id_product`,`id_shop`),
  KEY `id_product` (`id_product`),
  KEY `id_shop` (`id_shop`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_product_without_shops` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `product_sku` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_unused_images` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(9) unsigned NOT NULL,
  `session_date` datetime NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `image_preview` varchar(255) NOT NULL,
  `is_fixed` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64078 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `table_content_en` AS SELECT
 1 AS `id_fsch_block`,
  1 AS `content` */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `table_content_es` AS SELECT
 1 AS `id_fsch_block`,
  1 AS `content` */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP VIEW IF EXISTS `contenidos_tablas_modelos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`soladmin_acm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `contenidos_tablas_modelos` AS select `a`.`id_fsch_block` AS `id_fsch_block`,`a`.`name` AS `name`,`es`.`content` AS `content_es`,`en`.`content` AS `content_en` from ((`ps_fsch_block` `a` join `table_content_es` `es` on(`a`.`id_fsch_block` = `es`.`id_fsch_block`)) join `table_content_en` `en` on(`a`.`id_fsch_block` = `en`.`id_fsch_block`)) where `a`.`hook` = 'product-models' and `a`.`name` like 'Product Models%' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `datastudio_ventas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`it-acmotos`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `datastudio_ventas` AS select `ord`.`id_order` AS `id_pedido`,`ord`.`reference` AS `ref_pedido`,`carr`.`name` AS `transportista`,`lang`.`name` AS `idioma`,`stat`.`name` AS `estado`,`ord`.`payment` AS `forma_pago`,`ord`.`total_discounts_tax_incl` AS `total_descuento_con_iva`,`ord`.`total_discounts_tax_excl` AS `total_descuento_sin_iva`,`ord`.`total_paid_tax_incl` AS `total_pagado_con_iva`,`ord`.`total_paid_tax_excl` AS `total_pagado_sin_iva`,`ord`.`total_products_wt` AS `total_pagado_productos_con_iva`,`ord`.`total_products` AS `total_pagado_productos_sin_iva`,`ord`.`total_shipping_tax_incl` AS `total_pagado_envio_con_iva`,`ord`.`total_shipping_tax_excl` AS `total_pagado_envio_sin_iva`,`ord`.`invoice_number` AS `numero_factura`,`ord`.`delivery_number` AS `numero_albaran`,date_format(`ord`.`invoice_date`,'%Y%m%d') AS `fecha_factura`,date_format(`ord`.`date_add`,'%Y%m%d') AS `fecha_pedido` from (((`ps_orders` `ord` join `ps_lang` `lang` on(`ord`.`id_lang` = `lang`.`id_lang`)) join `ps_carrier` `carr` on(`ord`.`id_carrier` = `carr`.`id_carrier`)) join `ps_order_state_lang` `stat` on(`ord`.`current_state` = `stat`.`id_order_state`)) where `stat`.`id_lang` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `export_tabla_filtros`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`soladmin_acm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `export_tabla_filtros` AS select `prestashop`.`ps_fsch_block`.`id_fsch_block` AS `id_fsch_block`,`prestashop`.`ps_fsch_block`.`name` AS `name` from `ps_fsch_block` where `prestashop`.`ps_fsch_block`.`hook` = 'product-models' and `prestashop`.`ps_fsch_block`.`name` like '%Product Models - %' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `lucas_domain_selectors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`it-acmotos`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `lucas_domain_selectors` AS select `ld`.`domain_id` AS `domain_id`,`ld`.`domain` AS `domain`,`sel`.`selector_id` AS `selector_id`,`sel`.`selector_order` AS `selector_order`,`sel`.`attr` AS `attr` from (`lucas_domain` `ld` left join `lucas_domain_selector` `sel` on(`ld`.`domain_id` = `sel`.`domain_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `lucas_prices_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`it-acmotos`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `lucas_prices_report` AS select `prestashop`.`lucas_route`.`id_product` AS `id_product`,`product`.`name` AS `name`,`domain`.`domain` AS `domain`,`lrp`.`price` AS `price` from (((`lucas_route` left join `lucas_route_price` `lrp` on(`prestashop`.`lucas_route`.`route_id` = `lrp`.`route_id`)) join `lucas_domain` `domain` on(`prestashop`.`lucas_route`.`domain_id` = `domain`.`domain_id`)) join `ps_product_lang` `product` on(`prestashop`.`lucas_route`.`id_product` = `product`.`id_product`)) where `prestashop`.`lucas_route`.`is_current` = 1 and `lrp`.`price` is not null and `product`.`id_lang` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `pending_billing`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`prestashop`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `pending_billing` AS select `py_order_billing_status`.`id_order` AS `id_order`,`py_order_billing_status`.`current_state` AS `current_state`,`py_order_billing_status`.`created_at` AS `created_at`,`py_order_billing_status`.`billed` AS `billed`,`py_order_billing_status`.`billed_at` AS `billed_at`,`py_order_billing_status`.`reimbursed` AS `reimbursed`,`py_order_billing_status`.`reimbursed_at` AS `reimbursed_at` from `py_order_billing_status` where `py_order_billing_status`.`current_state` not in ('OK','INTERNAL') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `physical_stock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`prestashop`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `physical_stock` AS select `ps_stock`.`id_stock` AS `id_stock`,`ps_stock`.`id_product` AS `id_product`,`ps_stock`.`id_product_attribute` AS `id_product_attribute`,`ps_stock`.`reference` AS `reference`,cast(sum(`ps_stock`.`usable_quantity`) as unsigned) AS `sum_usable_quantity` from `ps_stock` where `ps_stock`.`id_warehouse` <> 2 and `ps_stock`.`usable_quantity` > 0 group by `ps_stock`.`id_product`,`ps_stock`.`id_product_attribute` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `pr_cat_tags`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`soladmin_acm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `pr_cat_tags` AS select `blcks`.`id_fsch_block` AS `id_fsch_block`,`blcks`.`name` AS `name`,`blcks`.`active` AS `active` from `ps_fsch_block` `blcks` where `blcks`.`hook` = 'product-tags' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `table_content_en`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`soladmin_acm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `table_content_en` AS select `prestashop`.`ps_fsch_block_lang`.`id_fsch_block` AS `id_fsch_block`,`prestashop`.`ps_fsch_block_lang`.`content` AS `content` from `ps_fsch_block_lang` where `prestashop`.`ps_fsch_block_lang`.`id_lang` = 3 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `table_content_es`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`soladmin_acm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `table_content_es` AS select `prestashop`.`ps_fsch_block_lang`.`id_fsch_block` AS `id_fsch_block`,`prestashop`.`ps_fsch_block_lang`.`content` AS `content` from `ps_fsch_block_lang` where `prestashop`.`ps_fsch_block_lang`.`id_lang` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

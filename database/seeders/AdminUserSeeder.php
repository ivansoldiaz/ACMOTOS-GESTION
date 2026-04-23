<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        $email = config('gestion.admin.email');
        $name = config('gestion.admin.name');
        $password = config('gestion.admin.password');

        if (!$email || !$password) {
            $this->command->warn('AdminUserSeeder omitido: faltan GESTION_ADMIN_EMAIL o GESTION_ADMIN_PASSWORD en .env');
            return;
        }

        User::updateOrCreate(
            ['email' => $email],
            [
                'name' => $name ?: 'Admin',
                'password' => Hash::make($password),
                'email_verified_at' => now(),
            ],
        );

        $this->command->info("Usuario admin listo: {$email}");
    }
}

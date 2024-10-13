<?php

namespace App\Http\DTOs;

use Carbon\Carbon;
use Spatie\LaravelData\Data;

class UserData extends Data
{
    public function __construct(
        public ?string $name = null,
        public ?string $email = null,
        public ?Carbon $email_verified_at = null,
        public ?string $password = null,
        public ?string $remember_token = null,
    ) {}
}

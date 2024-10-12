<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Location extends Model
{
    use HasFactory;

    #region Relations

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class);
    }

    #endregion Relations
}

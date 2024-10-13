<?php

namespace App\Models;

use App\Traits\IsApiModel;
use Illuminate\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, IsApiModel, MustVerifyEmail, Notifiable;

    /**
     * The attributes that should be mass assignable.
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    #region Relations

    public function badges(): BelongsToMany
    {
        return $this->belongsToMany(Badge::class);
    }

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class);
    }

    #endregion Relations
    #region Api

    public function scopeFilter(Builder $query, string $column = '', mixed $value = null): void
    {
        switch ($column) {
            case 'ids':
                $query->whereIn('id', $value);
                break;
            default:
                $query->where($column, $value);
                break;
        }
    }

    #endregion Api
}

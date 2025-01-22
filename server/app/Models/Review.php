<?php

namespace App\Models;

use App\Traits\IsApiModel;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Review extends Model
{
    use HasFactory, IsApiModel;

    #region Relations

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
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

<?php

namespace App\Models;

use App\Services\OpenStreetMap\Models\OverpassData;
use App\Traits\IsApiModel;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Location extends Model
{
    use HasFactory, IsApiModel;

    # region Relations

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class);
    }

    # endregion Relations
    # region Factories

    public static function fromOverpassData(OverpassData $data, bool $persist = false): self
    {
        $location = new Location;
        $location->id = null;
        $location->overpass_id = $data->id;
        $location->latitude = $data->lat;
        $location->longitude = $data->lon;
        $location->name = $data->name;
        $location->website = $data->website;
        $location->overpass_data = $data->toArray();

        if ($persist) {
            $location->save();
        }

        return $location;
    }

    # endregion Factories
    # region Api

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

    # endregion Api
}

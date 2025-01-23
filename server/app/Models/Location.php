<?php

namespace App\Models;

use App\Services\OpenStreetMap\Models\OverpassData;
use App\Traits\IsApiModel;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;

class Location extends Model
{
    use HasFactory, IsApiModel;

    /**
     * The attributes that should be cast.
     */
    protected $casts = [
        'overpass_data' => 'array',
    ];

    #region Relations

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class);
    }

    public function accessibilityDatas(): HasMany
    {
        return $this->hasMany(AccessibilityData::class);
    }

    #endregion Relations
    #region Factories

    public static function fromOverpassData(OverpassData $data, bool $withImageUrl = true, bool $persist = false): self
    {
        $location = new Location;
        $location->id = null;
        $location->overpass_id = $data->id;
        $location->latitude = $data->lat;
        $location->longitude = $data->lon;
        $location->name = $data->name;
        $location->website = $data->website;
        $location->overpass_data = $data->toArray();

        if ($withImageUrl && $data->wikidata) {
            $response = Http::get("https://www.wikidata.org/w/api.php?action=wbgetentities&ids={$data->wikidata}&format=json&props=claims");
            $imageArray = ($response->json('entities')[$data->wikidata]['claims']['P18'] ?? $response->json('entities')[$data->wikidata]['claims']['P154'] ?? [])[0] ?? [];
            $imageName = Str::replace(' ', '_', $imageArray['mainsnak']['datavalue']['value'] ?? '');
            $location->image_url = stringNullOrEmpty($imageName) ? null : "https://commons.wikimedia.org/wiki/Special:FilePath/$imageName";
        }

        if ($persist) {
            $location->save();
        }

        return $location;
    }

    #endregion Factories
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

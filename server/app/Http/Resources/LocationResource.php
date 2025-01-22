<?php

namespace App\Http\Resources;

use App\Enums\AccessibilityEntry;
use App\Models\AccessibilityDataReport;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LocationResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

        return [
            'id' => $this->id,
            'overpass_id' => $this->overpass_id,
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
            'name' => $this->name,
            'website' => $this->website,
            'image_url' => $this->image_url,
            'opening_times' => $this->opening_times,
            'overpass_data' => $this->overpass_data,
            'reviews' => $this->prepareReviewOverview(),
            'accessibility' => $this->prepareAccessibilityOverview(),
        ];
    }

    private function prepareReviewOverview(): array
    {
        $result = [
            'count' => $this->reviews->count() ?? 0,
            'score' => round($this->reviews->avg('score') ?? 0, 1),
        ];

        for ($i = 1; $i < 6; $i++) {
            if ($result['count'] > 0) {
                $result["{$i}star"] = round(($this->reviews->where('score', $i)->count() / $result['count']), 2);
            } else {
                $result["{$i}star"] = 0;
            }
        }

        return $result;
    }

    private function prepareAccessibilityOverview(): array
    {
        $result = [];
        $allReports = $this->accessibilityDatas;

        foreach (AccessibilityEntry::cases() as $entry) {
            $category = AccessibilityEntry::getCategory($entry);
            $datas = $allReports->where('category', $category->value)->where('entry', $entry->value);
            $result[$entry->value]['value'] = $datas->count() > 1 ? $datas->average('value') > 0.5 : null;
            $result[$entry->value]['trusted'] = AccessibilityDataReport::whereIn('accessibility_data_id', $datas->pluck('id')->toArray())->count() < 4;
        }

        return $result;
    }
}

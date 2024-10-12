<?php

namespace App\Traits;

use ArrayAccess;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

/**
 * The class that uses this trait should implement the ApiModel interface.
 */
trait IsApiModel
{
    /**
     * Filter and sort the query by the given api request.
     */
    public function scopeForRequest(Builder $query, Request $request): void
    {
        // Apply filters to query
        $filters = $request->filters;
        if ($filters && is_array($filters) && method_exists($this, 'scopeFilter')) {
            foreach ($filters as $column => $value) {
                $query->filter($column, $value);
            }
        }

        // Apply sorts to query
        $sorts = $request->sorts;
        if ($sorts && is_array($sorts)) {
            // If the array is a list, multiple sorts have to be applied
            if (array_is_list($sorts)) {
                foreach ($sorts as $sort) {
                    $query->applyApiModelSort($sort);
                }
            } else {
                $query->applyApiModelSort($sorts);
            }
        }

        // Load relations
        $relations = $request->relations;
        if ($relations && is_array($relations)) {
            foreach ($relations as $relation) {
                $query->with($relation);
            }
        }
    }

    /**
     * Adds an orderBy clause to the query.
     *
     * @param  null|ArrayAccess|array  $sort  Has to be ArrayAccess with the keys 'column' and optionally 'direction'.
     */
    protected function scopeApplyApiModelSort(Builder $query, null|ArrayAccess|array $sort = []): void
    {
        if (array_key_exists('column', $sort)) {
            $query->orderBy($sort['column'], $sort['direction'] ?? 'asc');
        }
    }
}

<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Http\Resources\ReviewResource;
use App\Models\Review;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    /**
     * Get all: apply filters, sorts etc from request.
     */
    public function getReviews(Request $request): mixed
    {
        $reviews = Review::forRequest($request)->get();

        return ReviewResource::collection($reviews);
    }
}

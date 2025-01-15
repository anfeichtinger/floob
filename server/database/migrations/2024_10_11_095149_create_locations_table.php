<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('locations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('overpass_id');
            $table->string('latitude');
            $table->string('longitude');
            $table->string('name');
            $table->string('website')->nullable()->default(null);
            $table->string('opening_times')->nullable()->default(null);
            $table->string('image_url')->nullable()->default(null);
            $table->json('overpass_data')->nullable()->default(null);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('locations');
    }
};

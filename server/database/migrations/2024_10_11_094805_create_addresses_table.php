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
        Schema::create('addresses', function (Blueprint $table) {
            $table->id();
            $table->morphs('addressable');
            $table->string('country')->nullable()->default(null);
            $table->string('state')->nullable()->default(null);
            $table->string('city')->nullable()->default(null);
            $table->string('post_code')->nullable()->default(null);
            $table->string('street')->nullable()->default(null);
            $table->text('additional_info')->nullable()->default(null);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('addresses');
    }
};

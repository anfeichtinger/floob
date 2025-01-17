<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class File extends Model
{
    use HasFactory;

    #region Relations

    public function fileable(): MorphTo
    {
        return $this->morphTo();
    }

    #endregion Relations
}

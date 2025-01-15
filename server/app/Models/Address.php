<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Address extends Model
{
    use HasFactory;

    /**
     * The attributes that should be mass assignable.
     */
    protected $fillable = [
        'country',
        'state',
        'city',
        'post_code',
        'street',
    ];

    #region Relations

    public function addressable(): MorphTo
    {
        return $this->morphTo();
    }

    #endregion Relations
    #region Helpers

    /**
     * Returns the address string based on the given format.
     *
     * C = Country,
     * S = State,
     * c = City,
     * p = Post code,
     * s = Street,
     */
    public function format(string $format = 's, p c'): string
    {
        $result = '';
        foreach (str_split($format) as $char) {
            switch ($char) {
                case 'C':
                    $result .= trans("enums/country.{$this->country}");
                    break;
                case 'S':
                    $result .= $this->state;
                    break;
                case 'c':
                    $result .= $this->city;
                    break;
                case 'p':
                    $result .= $this->post_code;
                    break;
                case 's':
                    $result .= $this->street;
                    break;
                default:
                    $result .= $char;
            }
        }

        return $result;
    }

    #endregion Helpers
}

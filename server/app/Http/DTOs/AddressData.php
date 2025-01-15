<?php

namespace App\Http\DTOs;

use Spatie\LaravelData\Data;

class AddressData extends Data
{
    public function __construct(
        public ?string $country = null,
        public ?string $state = null,
        public ?string $city = null,
        public ?string $post_code = null,
        public ?string $street = null,
    ) {}

    public function asString(): string
    {
        return ($this->street ? $this->street . ', ' : '') . ($this->post_code ?? '') . ' ' . ($this->city ?? '');
    }

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
                    if ($this->country) {
                        $result .= trans("enums/country.{$this->country}");
                    }
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

        // Trim and remove trailing ',' if given. This is a workaround for issues with the country.
        $result = trim($result);
        if (substr($result, -1) === ',') {
            $result = substr($result, 0, -1);
        }

        return $result;
    }
}

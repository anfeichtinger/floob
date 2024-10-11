<?php

namespace App\Traits;

use Illuminate\Routing\Exceptions\BackedEnumCaseNotFoundException;

/**
 * Use this trait to extend the functionality of your nativ enums.
 */
trait EnumEnhancements
{
    /**
     * Returns all values of the enum as an array.
     *
     * @param  mixed  $except  A value or array of values that should not be in the array.
     */
    public static function toArray(mixed $except = null): array
    {
        $values = array_column(self::cases(), 'value');

        $diff = is_array($except) ? $except : (($except !== null) ? [$except] : null);

        return $diff ? array_diff($values, $diff) : $values;
    }

    public static function isValid($value): bool
    {
        return in_array($value, self::toArray());
    }

    public static function tryFromCase(string $case): ?static
    {
        try {
            return static::fromCase($case);
        } catch (BackedEnumCaseNotFoundException $e) {
            return null;
        }
    }

    public static function fromCase(string $case): ?static
    {
        foreach (static::cases() as $enum) {
            if (isset($enum->name) && $enum->name == strtoupper($case)) {
                return $enum;
            }
        }
        throw new BackedEnumCaseNotFoundException(static::class, $case);
    }

    /**
     * Whether two enums have the same string value.
     */
    public static function same(null|self|string $case1 = null, null|self|string $case2 = null): bool
    {
        return (is_string($case1) ? $case1 : ($case1?->value ?? null)) === (is_string($case2) ? $case2 : ($case2?->value ?? null));
    }

    /**
     * Whether the current enum instance has the same string value as the given $case.
     */
    public function is(null|self|string $case = null): bool
    {
        return static::same($this, $case);
    }
}

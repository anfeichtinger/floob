<?php

if (!function_exists('stringNullOrEmpty')) {
    /**
     * Check if a string is null or only contains whitespaces
     */
    function stringNullOrEmpty(?string $str): bool
    {
        return $str === null || trim($str) === '';
    }
}

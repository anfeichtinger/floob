<?php

namespace App\Http\Controllers;

class PublicController extends Controller
{
    public function welcome()
    {
        return view('welcome-view');
    }
}

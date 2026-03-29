<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class PagesController extends Controller
{
    public function newPage() : View
    {
        return view('newPage');
    }

    public function teste(): View
    {
        $user = Auth::user();
        return \view('publicPage', ['user' => $user]);
    }
}

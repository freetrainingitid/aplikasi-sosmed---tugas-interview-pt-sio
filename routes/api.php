<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::middleware('auth:api')->get('/user', function (Request $request) {
//    return $request->user();
//});

Route::prefix('v1')->group(function(){
    Route::post('register','Api\V1\AuthController@register');
    Route::post('login','Api\V1\AuthController@login');
    Route::group(['middleware' => 'auth:api'], function(){
		Route::get('user', 'Api\V1\AuthController@profile');
        Route::get('logout','Api\V1\AuthController@logout');
        Route::get('usrprofile', 'Api\V1\UserController@showProfile');
        Route::put('updprofile', 'Api\V1\UserController@updateProfile');

        Route::get('followers', 'UserController@followers');
        Route::get('following', 'UserController@following');
        Route::get('posts', 'PostController@index');
        Route::post('posts', 'PostController@store');
        Route::get('posts/{id}', 'PostController@show');
        Route::put('posts/{id}', 'PostController@update');
        Route::delete('posts/{id}', 'PostController@destroy');
        Route::post('posts/{id}/like', 'PostController@like');
        Route::post('posts/{id}/comment', 'PostController@comment');
    });
});
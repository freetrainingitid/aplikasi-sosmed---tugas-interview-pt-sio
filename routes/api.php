<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\API\RegisterController;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\PostController;

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

/*Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});*/

Route::post('register', [RegisterController::class, 'register']);
Route::post('login', [RegisterController::class, 'login']);
Route::get('logout', [RegisterController::class, 'logout']);
     
Route::middleware('auth:api')->group( function () {
	Route::get('usrprofile', [UserController::class, 'showProfile']);
	Route::put('updprofile', [UserController::class, 'updateProfile']);
    Route::get('users/search', [UserController::class, 'search'])->name('user.search');

    Route::get('logout', [RegisterController::class, 'logout']);

    Route::post('/users/{userId}/follow', [UserController::class, 'follow']);
    Route::post('/users/{userId}/unfollow', [UserController::class, 'unfollow']);

    Route::get('followers', [UserController::class, 'followers']);
    Route::get('following', [UserController::class, 'following']);

    Route::get('posts', [PostController::class, 'index']);
    Route::post('posts', [PostController::class, 'store']);
    Route::get('posts/{id}', [PostController::class, 'show']);
    Route::put('posts/{id}', [PostController::class, 'update']);
    Route::delete('posts/{id}', [PostController::class, 'destroy']);
    Route::get('/users/{userId}/posts', [PostController::class, 'showPostsByUserId']);

    Route::post('posts/{id}/like', [PostController::class, 'likePost']);
    Route::post('posts/{id}/comment', [PostController::class, 'comment']);

});

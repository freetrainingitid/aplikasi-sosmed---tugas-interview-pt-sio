<?php

namespace App\Http\Controllers\Api\V1;

use App\User;
use Validator;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{

    public function showProfile(Request $request)
    {
        $user = Auth::user();

        return response()->json([
            'status' => 'success',
            'message' = 'User login profil';
            'data' => $user
        ]);
    }

    public function updateProfile(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone_number' => 'required|numeric',
            'image' => 'required|image',
            'username' => 'required|string|max:255',
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'date_of_birth' => 'required|date'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => $validator->errors()->all()
            ], 422);
        }

        $user = Auth::user();

        $user->phone_number = $request->phone_number;
        $user->username = $request->username;
        $user->first_name = $request->first_name;
        $user->last_name = $request->last_name;
        $user->date_of_birth = $request->date_of_birth;

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $filename = time() . '.' . $image->getClientOriginalExtension();
            $path = public_path('uploads/profile_images/' . $filename);
            $image->move(public_path('uploads/profile_images'), $filename);
            $user->image = $filename;
        }

        $user->save();

        return response()->json([
            'status' => 'success',
            'message' => 'Profile updated successfully',
            'data' => $user
        ]);
    }

    public function followers()
    {
        $user = auth()->user();
        $followers = $user->followers;
        return response()->json($followers, 200);
    }

    public function following()
    {
        $user = auth()->user();
        $following = $user->following;
        return response()->json($following, 200);
    }

    public function search(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'query' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $query = $request->input('query');
        $users = User::where('username', 'LIKE', "%$query%")
                     ->orWhere('first_name', 'LIKE', "%$query%")
                     ->orWhere('last_name', 'LIKE', "%$query%")
                     ->get();

        return response()->json($users, 200);
    }

    public function followers()
    {
        return $this->belongsToMany(User::class, 'followers', 'followed_user_id', 'follower_user_id')
                    ->withTimestamps();
    }

    public function following()
    {
        return $this->belongsToMany(User::class, 'followers', 'follower_user_id', 'followed_user_id')
                    ->withTimestamps();
    }

    public function isFollowing(User $user)
    {
        return $this->following()->where('id', $user->id)->exists();
    }

    public function follow(User $user)
    {
        $this->following()->syncWithoutDetaching($user->id);
    }

    public function unfollow(User $user)
    {
        $this->following()->detach($user->id);
    }

    public function follow(Request $request, $userId)
    {
        $user = User::find($userId);

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $authUser = Auth::user();

        if ($authUser->isFollowing($user)) {
            return response()->json(['error' => 'Already following user'], 400);
        }

        $authUser->follow($user);

        return response()->json(['message' => 'User followed'], 200);
    }

    public function unfollow(Request $request, $userId)
    {
        $user = User::find($userId);

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $authUser = Auth::user();

        if (!$authUser->isFollowing($user)) {
            return response()->json(['error' => 'Not following user'], 400);
        }

        $authUser->unfollow($user);

        return response()->json(['message' => 'User unfollowed'], 200);
    }

}

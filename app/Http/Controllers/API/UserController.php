<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\API\BaseController as BaseController;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Validator;

class UserController extends BaseController
{

    public function showProfile(Request $request)
    {
        $user = Auth::user();
        return response()->json([
            'status' => 'success',
            'message' => 'User login profil',
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

    public function showfollowers()
    {
        $user = auth()->user();
        $followers = $user->followers;
        return response()->json($followers, 200);
    }

    public function showfollowing()
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

    public function follow(Request $request, $userId)
    {
        $follower = Auth::user();
        $following = User::findOrFail($userId);
        if (!$following) {
            return response()->json(['error' => 'User not found'], 404);
        }
        if ($follower->isFollowing($following)) {
            return response()->json(['error' => 'Already following user'], 400);
        }

        $follower->following()->attach($following->user_id);
        return response()->json([
            'message' => 'Successfully followed user ' . $following->username
        ], 200);
    }

    public function unfollow(Request $request, $userId)
    {
        $follower = Auth::user();
        $following = User::findOrFail($userId);
        if (!$following) {
            return response()->json(['error' => 'User not found'], 404);
        }
        if (!$follower->isFollowing($following)) {
            return response()->json(['error' => 'Not following user'], 400);
        }

        $follower->following()->detach($following->user_id);
        return response()->json([
            'message' => 'Successfully unfollowed user ' . $following->username
        ], 200);
    }


}

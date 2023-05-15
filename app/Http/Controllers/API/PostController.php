<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\API\BaseController as BaseController;
use App\Models\Post;
use Illuminate\Support\Facades\Auth;
use Validator;

class PostController extends BaseController
{

    public function index()
    {
        $posts = Post::all();
        return response()->json($posts, 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'image' => 'required|image',
            'caption' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = auth()->user();
        $image = $request->file('image')->store('images', 'public');

        $post = Post::create([
            'user_id' => $user->user_id,
            'image' => $image,
            'caption' => $request->input('caption'),
        ]);

        return response()->json($post, 201);
    }

    public function show($id)
    {
        $post = Post::findOrFail($id);
        return response()->json($post, 200);
    }

    public function showPostsByUserId($userId)
    {
        $posts = Post::where('user_id', $userId)->get();
        return response()->json($posts);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'caption' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $post = Post::findOrFail($id);
        $post->update([
            'caption' => $request->input('caption'),
        ]);

        return response()->json($post, 200);
    }

    public function destroy($id)
    {
        $post = Post::findOrFail($id);
        $post->delete();
        return response()->json(['message' => 'Post deleted successfully'], 200);
    }

    public function like($id)
    {
        $post = Post::findOrFail($id);
        $user = auth()->user();
        if ($post->likes()->where('user_id', $user->user_id)->exists()) {
            return response()->json(['message' => 'You have already liked this post'], 422);
        }

        $post->likes()->create([
            'user_id' => $user->user_id,
        ]);
        return response()->json(['message' => 'Post liked successfully'], 200);
    }

    public function comment(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'comment' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $post = Post::findOrFail($id);
        $user = auth()->user();
        $comment = $post->comments()->create([
            'user_id' => $user->id,
			'comment' => $request->input('comment'),
			]);
       return response()->json($comment, 201);
   }

}

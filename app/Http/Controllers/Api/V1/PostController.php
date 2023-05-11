<?php

namespace App\Http\Controllers\Api\V1;

use App\Post;
use Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PostController extends Controller
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
            'user_id' => $user->id,
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

        if ($post->likes()->where('user_id', $user->id)->exists()) {
            return response()->json(['message' => 'You have already liked this post'], 422);
        }

        $post->likes()->create([
            'user_id' => $user->id,
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

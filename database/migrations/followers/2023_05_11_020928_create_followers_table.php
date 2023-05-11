<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFollowersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('followers', function (Blueprint $table) {
            $table->unsignedBigInteger('follower_user_id');
            $table->unsignedBigInteger('followed_user_id');
            $table->timestamps();

            $table->foreign('follower_user_id')->references('user_id')->on('users')->onDelete('cascade');
            $table->foreign('followed_user_id')->references('user_id')->on('users')->onDelete('cascade');

            $table->unique(['follower_user_id', 'followed_user_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('followers');
    }

}

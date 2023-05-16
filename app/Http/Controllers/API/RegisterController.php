<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\API\BaseController as BaseController;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Validator;
use Carbon\Carbon;

class RegisterController extends BaseController
{

    /**
     * Register api
     *
     * @return \Illuminate\Http\Response
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required',
            'last_name' => 'required',
            'phone_number' => 'required',
            'image' => 'required',
            'date_of_birth' => 'required',
            'username'    => 'required|unique:users',
            'password' => 'required|min:8',
        ]);
   
        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());       
        }
   
        $input = $request->all();
        $input['password'] = bcrypt($input['password']);
        $user = User::create($input);
        $success['token'] =  $user->createToken('sosmed-api')->accessToken;
        $success['username']  = $user->username;
   
        //return response()->json(['success'=>$success],200); 
        return $this->sendResponse($success, 'User register successfully.');
    }
   
    /**
     * Login api
     *
     * @return \Illuminate\Http\Response
     */
    public function login(Request $request)
    {
        if(Auth::attempt(['username' => $request->username, 'password' => $request->password])){ 
            $user = Auth::user(); 
            $tokenResult =  $user->createToken('sosmed-api');
            $token = $tokenResult->token;
            if($request->remember_me){
                $token->expires_at = Carbon::now()->addWeeks(1);
            }
            $token->save();

            //$success['token'] =  $user->createToken('sosmed-api')-> accessToken; 
            //$success['username'] =  $user->username;
            //$success['first_name'] =  $user->first_name;
            //$success['last_name'] =  $user->last_name;
            //return $this->sendResponse($success, 'User login successfully.');
            return response()->json([
                'access_token'=>$tokenResult->accessToken,
                'token_type' => 'Bearer', 
                'expires_at' => Carbon::parse($tokenResult->token->expires_at)->toDateTimeString()
            ]);
        } 
        else{ 
            return $this->sendError('Unauthorised.', ['error'=>'Unauthorised']);
        } 
    }

    /**
     * @ logout function
     */
    public function logout(Request $request){
        if(Auth::user()){
           $user = Auth::user()->token();
           $user->revoke();
            return response()->json([
                'success' => true,
                'message' => 'Logout successfully',
               ]);
          } else {
               return response()->json([
                'success' => false,
                'message' => 'Unable to Logout',
               ]);
          }
    }

}

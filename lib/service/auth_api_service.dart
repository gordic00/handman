import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:handman/core/constants/api_urls.dart';
import 'package:handman/core/network/dio_client.dart';
import 'package:handman/data/model/signin_req_params.dart';
import 'package:handman/data/model/signup_req_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.register, data: signupReq.toMap());

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.login, data: signinReq.toMap());
      setJwtToken(response);

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  void setJwtToken(Response response) async {
    final jwtToken = response.data['jwt'];
    if (jwtToken != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', jwtToken);
    } else {
      throw Exception('JWT token not found in response.');
    }
  }
}

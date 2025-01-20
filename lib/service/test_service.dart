import 'package:dio/dio.dart';
import 'package:handman/core/constants/api_urls.dart';
import 'package:handman/core/network/dio_client.dart';
import 'package:handman/data/entity/test_item.dart';
import 'package:handman/data/model/load_req_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

abstract class TestService {
  Future<List<TestItem>> load(LoadReqParams params);
  Future<List<TestItem>> loadSecond(LoadReqParams params);
}

class TestServiceImpl extends TestService {
  @override
  Future<List<TestItem>> load(LoadReqParams params) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing. Please login again.');
    }

    Map<String, String> bearer = {'Authorization': 'Bearer $token'};
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.test,
        queryParameters: params.toMap(),
        options: Options(headers: bearer),
      );

      if (response.data != null && response.data['content'] is List) {
        List<TestItem> items = (response.data['content'] as List)
            .map((item) => TestItem.fromJson(item))
            .toList();

        return items;
      } else {
        throw Exception('Unexpected response format.');
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ??
          'An error occurred during the request.';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<TestItem>> loadSecond(LoadReqParams params) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing. Please login again.');
    }

    Map<String, String> bearer = {'Authorization': 'Bearer $token'};
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.testSecond,
        queryParameters: params.toMap(),
        options: Options(headers: bearer),
      );

      if (response.data != null && response.data['content'] is List) {
        List<TestItem> items = (response.data['content'] as List)
            .map((item) => TestItem.fromJson(item))
            .toList();

        return items;
      } else {
        throw Exception('Unexpected response format.');
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ??
          'An error occurred during the request.';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

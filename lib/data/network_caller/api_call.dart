import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_manager/data/controller/authentication_controller.dart';
import 'package:task_manager/data/model/api_response.dart';

class ApiCall {
  static Future<ApiResponse> getResponse(String url) async {
    try {
      Response serverResponse = await get(Uri.parse(url),headers: {'token':AuthenticationController.accessToken});
      if (serverResponse.statusCode == 200) {
        final dynamic serverResponseData = jsonDecode(serverResponse.body);
        return ApiResponse(
            statusCode: serverResponse.statusCode,
            isSuccess: true,
            responseData: serverResponseData,
            errorMessage: null);
      } else {
        return ApiResponse(
            statusCode: serverResponse.statusCode, isSuccess: false);
      }
    } catch (e) {
      return ApiResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<ApiResponse> postResponse(
      String url, Map<String, dynamic>? body) async {
    try {
      Response serverResponse = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'token':AuthenticationController.accessToken});
      if (serverResponse.statusCode == 200 ||
          serverResponse.statusCode == 201) {
        final dynamic serverResponseData = jsonDecode(serverResponse.body);
        return ApiResponse(
            statusCode: serverResponse.statusCode,
            isSuccess: true,
            responseData: serverResponseData,
            errorMessage: null);
      } else {
        return ApiResponse(
            statusCode: serverResponse.statusCode, isSuccess: false);
      }
    } catch (e) {
      return ApiResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}

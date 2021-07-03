import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:astrometry_net/resources/app_log.dart';
import 'package:astrometry_net/resources/storage.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class Api {
  static const TIMEOUT = Duration(seconds: 60);
  static const URL = 'https://nova.astrometry.net';
  static const BASE_URL = '$URL/api';

  var apiKey = '';
  var session = '';

  static final dio = Dio();
  
  static Future<ApiResponse> _request(String path, {dynamic data}) async {
    final url = '$BASE_URL$path';
    
    try {
      late final Response response;

      if (data != null) {
        final body = {
          'request-json': json.encode(data),
        };
        dio.options.contentType= Headers.formUrlEncodedContentType;
        response = await dio.post(
          url,
          data: body,
          options: Options(
            contentType: Headers.formUrlEncodedContentType
          )
        );
      } else {
        response = await dio.get(url);
      }

      AppLog.d('REQUEST URL: $path'
        + '\n\nREQUEST HEADERS: ${response.headers}'
        + '\n\nREQUEST DATA: $data'
        + '\n\nRESPONSE: ${response.data}'
      );

      final responseData = json.decode(response.data);

      if (responseData.containsKey('status')) {
        if (responseData['status'] == 'error') {
          return ApiResponse(
            success: false,
            statusCode: ApiResponse.API_ERROR_CODE,
            data: responseData
          );
        }
      }

      return ApiResponse(
        success: response.statusCode == 200,
        statusCode: response.statusCode ?? 0,
        data: responseData
      );
    } on SocketException {
      AppLog.e('==== Api SocketException ====');
      return ApiResponse(statusCode: ApiResponse.NO_INTERNET_CONNECTION_CODE);
    } on TimeoutException {
      AppLog.e('==== Api TimeoutException ====');
      return ApiResponse(statusCode: ApiResponse.NO_INTERNET_CONNECTION_CODE);
    } on DioError {
      return ApiResponse(statusCode: ApiResponse.NO_INTERNET_CONNECTION_CODE);
    }
  }
  
  static Future<String> login() async {
    final response = await _request('/login', data: {
      'apikey': Storage.getApiKey()
    });
    var sessionKey = '';

    if (response.success) {
      if (response.data.containsKey('session')) {
        sessionKey = response.data['session'];
        Storage.saveSessionKey(sessionKey);
      }
    }

    return sessionKey;
  }

  /// Getting submission status
  static Future<ApiResponse> getSubmissionStatus(int submissionId) {
    return _request('/submissions/$submissionId');
  }

  /// Getting job status
  static Future<ApiResponse> getJobStatus(int jobId) {
    return _request('/jobs/$jobId');
  }

  /// Getting job results: calibration
  static Future<ApiResponse> getJobCalibration(String jobId) {
    return _request('/jobs/$jobId/calibration');
  }

  /// Getting job results: tagged objects in your image
  static Future<ApiResponse> getTags(String jobId) {
    return _request('/jobs/$jobId/tags');
  }

  /// Getting job results: tagged objects in your image
  static Future<ApiResponse> getMachineTags(String jobId) {
    return _request('/jobs/$jobId/machine_tags');
  }

  /// Getting job results: known objects in your image
  static Future<ApiResponse> getObjects(String jobId) {
    return _request('/jobs/$jobId/objects_in_field');
  }

  /// Getting job results: known objects in your image, with coordinates
  static Future<ApiResponse> getAnnotations(String jobId) {
    return _request('/jobs/$jobId/annotations');
  }

  /// Getting job results
  static Future<ApiResponse> getJobInfo(int jobId) {
    return _request('/jobs/$jobId/info');
  }

  static Future<ApiResponse> getJobs() async {
    return await _request('/myjobs/', data: {
      'session': await Storage.getSessionKey(),
    });
  }

  /// Submitting a file
  static Future<ApiResponse> uploadFile(String filePath, String fileName) async {
    final path = '/upload';
    var session = await Storage.getSessionKey();

    final url = '$BASE_URL$path';
    
    try {
      var formData = FormData.fromMap({
        'request-json': json.encode({
          'session': session,
          'publicly_visible': 'y',
          'allow_modifications': 'd',
          'allow_commercial_use': 'd'
        }),
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName
        )
      });

      final response = await dio.post(
        url,
        data: formData,
      );

      AppLog.d('REQUEST URL: $path'
        + '\n\nREQUEST HEADERS: ${response.headers}'
        + '\n\nREQUEST DATA: $formData'
        + '\n\nRESPONSE: ${response.data}'
      );

      return ApiResponse.fromJson(await json.decode(response.data));
    } on SocketException {
      AppLog.e('==== SocketException ====');
      return ApiResponse(statusCode: ApiResponse.NO_INTERNET_CONNECTION_CODE);
    } on TimeoutException {
      AppLog.e('==== TimeoutException ====');
      return ApiResponse(statusCode: ApiResponse.NO_INTERNET_CONNECTION_CODE);
    }
  }

  /// Submitting a file by url
  static Future<ApiResponse> uploadFileByUrl(String url) async {
    final data = {
      'session': await Storage.getSessionKey(),
      'url': url,
      'publicly_visible': 'y',
      'allow_modifications': 'd',
      'allow_commercial_use': 'd',
    };
    
    return _request('/url_upload', data: data);
  }
  
}

class ApiResponse {
  static const GENERAL_ERROR_CODE = 0;
  static const NO_INTERNET_CONNECTION_CODE = 1;
  static const API_ERROR_CODE = 2;

  final bool success;
  final int statusCode;
  final dynamic data;

  ApiResponse({
    this.success = false,
    this.statusCode = GENERAL_ERROR_CODE,
    this.data = const {}
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['status'] == 'success',
      statusCode: 2,
      data: json,
    );
  }
}

import 'package:algostudio/services/network/api_response.dart';
import 'package:algostudio/services/network/url.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  //Dio instance
  final Dio _dio;

  //Cancel token
  final CancelToken _cancelToken;

  //Network client constructor
  NetworkClient({
    required Dio dioClient,
    Iterable<Interceptor>? interceptors,
  })  : _dio = dioClient,
        _cancelToken = CancelToken() {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
  }

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  /// HTTP Methods `GET`
  ///
  /// This methods return `Response` from [Dio]
  ///
  /// Keep [Dio] instance isolated from other layers
  Future<Response> get({
    required String endpoint,
    JSONData? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken);
    return response;
  }

  /// HTTP Methods `POST`
  ///
  /// Add new [data] to database
  ///
  /// This methods will send [data] to backend
  ///
  /// Keep [Dio] instance isolated from other layers
  Future<Response> post({
    required String endpoint,
    JSONData? queryParams,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post(endpoint,
        queryParameters: queryParams,
        data: data,
        options: options,
        cancelToken: cancelToken);
    return response;
  }

  /// HTTP Methods `PUT`
  ///
  /// This methods will send [data] to backend
  ///
  /// Keep [Dio] instance isolated from other layers
  Future<Response> put({
    required String endpoint,
    JSONData? queryParams,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.put(endpoint,
        queryParameters: queryParams,
        data: data,
        options: options,
        cancelToken: cancelToken);
    return response;
  }

  /// HTTP Methods `DELETE`
  ///
  /// This methods will delete [data]
  ///
  /// Keep [Dio] instance isolated from other layers
  Future<Response> delete({
    required String endpoint,
    Object? data,
    JSONData? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete(endpoint,
        data: data,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken);
    return response;
  }

  /// ApiResponse errorParser. This method
  /// will parse error based on DioErrorType
  ///
  /// Will return [ApiReponse]
  Future<APIResponse<T>> errorParser<T>(DioError e) {
    APIResponse<T> result = APIResponse<T>(
      code: e.response!.statusCode!,
      message: '',
      success: false,
    );

    switch (e.type) {
      case DioErrorType.connectionTimeout:
        result = result.copyWith(message: 'Can not connect to server');
        break;
      case DioErrorType.sendTimeout:
        result = result.copyWith(message: 'Can not connect to server');
        break;
      case DioErrorType.receiveTimeout:
        result = result.copyWith(message: 'Can not connect to server');
        break;
      case DioErrorType.badCertificate:
        result = result.copyWith(message: 'Bad certificate');
        break;
      case DioErrorType.badResponse:
        result = result.copyWith(message: 'Bad Response');
        break;
      case DioErrorType.cancel:
        result = result.copyWith(message: 'Request cancelled');
        break;
      case DioErrorType.connectionError:
        result = result.copyWith(message: 'No Internet connection');
        break;
      case DioErrorType.unknown:
        result = result.copyWith(message: 'Can not connect to server');
        break;
    }

    return Future(() => result);
  }
}

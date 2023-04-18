import 'dart:developer';
import 'dart:io';
import 'package:algostudio/utils/constants.dart';
import 'package:dio/dio.dart';

///Interceptor for http method that needs token
class NetworkInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    RequestOptions customOptions = options;

    // Check if path request is not in Endpoint.excludedPath, then
    // add Authorization header. Else, will not add Authorization header
    customOptions.headers = { HttpHeaders.contentTypeHeader : Constants.appJson };

    log(
      customOptions.headers.toString(),
      name: "Headers from NetworkInterceptor",
    );
    handler.next(customOptions);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}

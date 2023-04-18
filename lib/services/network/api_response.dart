// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

class APIResponse<T> {
  APIResponse({this.data, required this.code, required this.message, required this.success});

  final T? data;
  final int code;
  final String message;
  final bool success;

  APIResponse<T> copyWith({
    T? data,
    int? code,
    String? message,
    bool? success,
  }) {
    return APIResponse<T>(
      data: data ?? data,
      code: code ?? this.code,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  factory APIResponse.fromRawJson(String str) => APIResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse(
    data: json["data"],
    code: json["code"],
    message: json["message"],
    success: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "code": code,
    "message": message,
    "error": success,
  };
}
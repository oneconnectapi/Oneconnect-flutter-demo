import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:one_vpn/core/utils/constant.dart';
import '../models/model.dart';

abstract class HttpConnection {
  final BuildContext context;



  HttpConnection(this.context);




  static String paramsToString(Map<String, String>? params) {
    if (params == null) return "";
    String output = "?";
    params.forEach((key, value) {
      output += "$key=$value&";
    });
    return output.substring(0, output.length - 1);
  }

  void _printRequest(String type, String url,
      {Map<String, dynamic>? body, bool showDebug = false}) {
    if (kDebugMode && showDebug) {
      log("${type.toUpperCase()} REQUEST : $url \n");
      if (body != null) {
        try {
          JsonEncoder encoder = const JsonEncoder.withIndent('  ');
          String prettyprint = encoder.convert(body);
          log("BODY / PARAMETERS : $prettyprint");
        } catch (e) {
          log("CAN'T FETCH BODY");
        }
      }
    }
  }

  void _printResponse(dynamic response, [bool showDebug = false]) {
    String? prettyprint;
    if (response is Map) {
      try {
        JsonEncoder encoder = const JsonEncoder.withIndent('  ');
        prettyprint = encoder.convert(response);
      } catch (_) {}
    }
    if (kDebugMode && showDebug) {
      log(prettyprint ?? response.toString());
      log("=======================================================\n\n");
    }
  }

}

class ApiResponse<T> extends Model {
  ApiResponse({
    this.success = false,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  T? data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

import 'package:one_vpn/core/utils/constant.dart';

class BaseModel {
  static String sign = AppConstants.sign;
  static String salt = AppConstants.randomSalt.toString();
  static String packageName = AppConstants.packageName;
  final String methodName;

  BaseModel({
    required this.methodName,
  });

  Map<String, dynamic> toJson() {
    return {
      'sign': sign,
      'salt': salt,
      'package_name': packageName,
      'method_name': methodName,
    };
  }
}

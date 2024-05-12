

import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:one_vpn/core/utils/network_available.dart';
import 'package:url_launcher/url_launcher.dart';

export 'preferences.dart';
export 'navigations.dart';

NetworkInfo networkInfo = NetworkInfo(Connectivity());

Future<bool> assetExists(String path) async {
  try {
    await rootBundle.load(path);
    return true;
  } catch (e) {
    return false;
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

extension CheckProForAd on AdWithoutView {
  void showIfNotPro(BuildContext context) {
    instanceManager.showAdWithoutView(this);

  }
}

Future<bool> checkUpdate(BuildContext context) async {
  try {
    var info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      if (info.flexibleUpdateAllowed) {
        InAppUpdate.startFlexibleUpdate().then((value) {
          InAppUpdate.completeFlexibleUpdate();
        });
      }
      if (info.immediateUpdateAllowed) {
        InAppUpdate.performImmediateUpdate();
      }
      return true;
    }
  } catch (_) {}
  return false;
}

class AssetsPath {
  static const String imagepath = "assets/images/";
  static const String iconpath = "assets/icons/";
}

void showToast(String message) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
}

void launchEmail({required String appEmail}) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: appEmail,
  );
  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  }
}

void launchWebsite({required String url}) async {
  if (!url.startsWith("http://") && !url.startsWith("https://")) {
    url = "http://$url";
  }

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}

void makePhoneCall({required String appContact}) async {
  if (appContact != "Not Available") {
    final Uri phoneCallUri = Uri(scheme: 'tel', path: appContact);

    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    }
  }
}

String formatWebText({required String text}) {
  return '''
            <html>
              <head>
                <style type="text/css">
                  @font-face {
                    font-family: MyFont;
                    src: url("file:///android_asset/fonts/opensans_semi_bold.TTF");
                  }
                  p {
                    color: white;
                    text-indent: 30px;
                  }
                  body {
                    font-family: MyFont;
                    color: #fffffff;
                    line-height: 1.6;
                  }
                  a {
                    color: #fffffff;
                    text-decoration: none;
                  }
                </style>
              </head>
              <body>
               $text
              </body>
            </html>
          ''';
}

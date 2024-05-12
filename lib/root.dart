import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:one_vpn/core/providers/globals/iap_provider.dart';
import 'package:one_vpn/core/resources/environment.dart';
import 'package:one_vpn/core/utils/config.dart';
import 'package:one_vpn/core/utils/utils.dart';
import 'package:one_vpn/ui/screens/main_screen.dart';
import 'core/providers/globals/ads_provider.dart';
import 'ui/screens/splash_screen.dart';
import 'package:http/http.dart' as http;

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with WidgetsBindingObserver {
  bool _ready = false;
  AppOpenAd? _appOpenAd;
  Timer? openAdTimeout;
  DateTime _lastShownTime = DateTime.now();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceid = '';
  bool isFirstTime = Preferences.isFirstTime();

  @override
  void initState() {
    if (Preferences.getDeviceId() == "unknown") {
      if (Platform.isAndroid) {
        deviceInfo.androidInfo.then((AndroidDeviceInfo androidInfo) {
          deviceid = androidInfo.serialNumber;
          Preferences.setDeviceId(deviceid: deviceid);
        });
      } else if (Platform.isIOS) {
        deviceInfo.iosInfo.then((IosDeviceInfo iosInfo) {
          deviceid = iosInfo.identifierForVendor!;
          Preferences.setDeviceId(deviceid: deviceid);
        });
      }
    }

    WidgetsBinding.instance.addObserver(this);
    if (Preferences.showLogin()) {
      Preferences.setShowLogin(showLogin: false);
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 5)).then((value) async {
        if (!_ready) {
          if (Preferences.isLogin()) {
            bool isConnected = await networkInfo.isConnected;
            if (isConnected) {
              replaceScreen(context, const MainScreen());
            } else {
              replaceScreen(context, const MainScreen());
            }
          } else {
            setState(() {
              _ready = true;
            });
          }
        }
      });
      await IAPProvider().initialize(context);
      await loadAppOpenAd()
          .then((value) => _appOpenAd?.showIfNotPro(context))
          .catchError((_) {});
      if (Preferences.isLogin()) {
          replaceScreen(context, const MainScreen());
      } else {
        setState(() {
          _ready = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    openAdTimeout?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_lastShownTime.difference(DateTime.now()).inMinutes > 5) {
        _appOpenAd?.showIfNotPro(context);
        _lastShownTime = DateTime.now();
      }
    } else if (state == AppLifecycleState.paused) {
      loadAppOpenAd();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return _ready ? const MainScreen() : const SplashScreen();
  }


  Future loadAppOpenAd() async {
    openAdTimeout?.cancel();
    return AdsProvider.read(context).loadOpenAd(openAdUnitID).then((value) {
      if (value != null) {
        _appOpenAd = value;
        _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            _appOpenAd!.dispose();
            _appOpenAd = null;
            loadAppOpenAd();
          },
        );
      } else {
        openAdTimeout = Timer(const Duration(minutes: 1), loadAppOpenAd);
      }
      return value;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String vpnUsername = "";
const String vpnPassword = "";
const bool certificateVerify = true;

const String appName = "OneConnect VPN";

ThemeMode themeMode = ThemeMode.system;
bool allowUserChangeTheme = true;

List<Locale> supportedLocales = const [
  Locale('en', 'US'), //English
];

const bool showSignalStrength = true;

const bool cacheServerList = true;

const String providerBundleIdentifier =
    "com.oneconnectflutter.iosdemo.VPNExtension";
const String groupIdentifier = "com.oneconnectflutter.iosdemo";
const String iosAppID = "1234567890";
const String localizationDescription = "OneConnect VPN";

AdRequest get adRequest => const AdRequest();

bool unlockProServerWithRewardAds = true;

bool unlockProServerWithRewardAdsFail = false;


const String interstitialAdUnitID = "ca-app-pub-3940256099942544/1033173712";
const String bannerAdUnitID = "ca-app-pub-3940256099942544/6300978111";
const String interstitialRewardAdUnitID =
    "ca-app-pub-3940256099942544/5354046379";
const String openAdUnitID = "ca-app-pub-3940256099942544/3419835294";

const String oneConnectKey = 'uuGGv.3PUlueN8PrZDwAQ13XVUTeuhs7nhgJimc3wUNhxw8SPY'; //Android key
const String oneConnectKey2 = 'J3epTkqMrAhTovQJv.afqMYGLubaaAHPcwKMRjh0mgIDGHxuZc'; //IOS key

///TODO: Set your custom subscription identifier here
Map<String, Map<String, dynamic>> subscriptionIdentifier = {};

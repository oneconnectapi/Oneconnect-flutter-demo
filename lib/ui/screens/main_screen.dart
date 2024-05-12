import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ndialog/ndialog.dart';
import 'package:one_vpn/core/providers/globals/ads_provider.dart';
import 'package:one_vpn/core/providers/globals/vpn_provider.dart';
import 'package:one_vpn/core/resources/environment.dart';
import 'package:one_vpn/core/utils/utils.dart';
import 'package:one_vpn/ui/components/custom_divider.dart';
import 'package:one_vpn/ui/screens/server_list_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../components/connection_button.dart';
import '../components/custom_image.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const ColumnDivider(space: 30),
              _appbarWidget(context),
              const ColumnDivider(space: 30),
              _selectVpnWidget(context),
              const ColumnDivider(space: 30),
              const ColumnDivider(space: 20),
              const Center(child: ConnectionButton()),
              const ColumnDivider(),
              const SizedBox.shrink(),
              const Center(child: ColumnDivider(space: 20)),
              const ColumnDivider(space: 20),
              Center(
                  child: AdsProvider.bannerAd(bannerAdUnitID,
                          adsize: AdSize.mediumRectangle)),
              const ColumnDivider(space: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _selectVpnWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _selectVpnClick(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.pink,
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Consumer<VpnProvider>(
                builder: (context, vpnProvider, child) {
                  var config = vpnProvider.vpnConfig;
                  return Row(
                    children: [
                      if (config != null)
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: config.flagUrl.contains("http")
                              ? CustomImage(
                                  url: config.flagUrl,
                                  fit: BoxFit.contain,
                                  borderRadius: BorderRadius.circular(5),
                                )
                              : Image.asset(
                                  "icons/flags/png/${config.flagUrl}.png",
                                  package: "country_icons"),
                        ),
                      if (config == null)
                        const SizedBox(
                            width: 32, height: 32, child: Icon(Icons.location_on, color: Colors.white,)),
                      const SizedBox(width: 10),
                      Text(config?.serverName ?? 'select_server'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      const Spacer(),
                      const Icon(Icons.expand_more, color: Colors.white,),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbarWidget(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                ),
                child: Text(
                  appName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white.withOpacity(1),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void menuClick() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void _selectVpnClick(BuildContext context) {
    startScreen(context, const ServerListScreen());
  }

  void _checkUpdate() async {
    if (Platform.isAndroid) {
      checkUpdate(context).then((value) {
        if (!value) {
          NAlertDialog(
            title: const Text("update_not_available").tr(),
            content: const Text("update_not_available_content").tr(),
            blur: 10,
            actions: [
              TextButton(
                  onPressed: () => closeScreen(context),
                  child: const Text("close").tr())
            ],
          ).show(context);
        }
      });
    } else {
      launchUrlString("https://apps.apple.com/app/id$iosAppID");
    }
  }

  Future<void> shareApp() async {
    try {
      String packageName = (await PackageInfo.fromPlatform()).packageName;
      String message =
          "\n I recommend you this app \n\n${Platform.isAndroid ? "https://play.google.com/store/apps/details?id=$packageName" : "https://apps.apple.com/app/idYOUR_APP_ID"}";

      if (Platform.isAndroid) {
        await Share.share(
          message,
          subject: appName,
        );
      } else if (Platform.isIOS) {
        launchUrlString("https://apps.apple.com/app/id$iosAppID");
      }
    } catch (e) {

    }
  }

  Future<void> rateUs() async {
    final String packageName = (await PackageInfo.fromPlatform()).packageName;

    final Uri uri = Platform.isAndroid
        ? Uri.parse('market://details?id=$packageName')
        : Uri.parse('https://apps.apple.com/app/$iosAppID');

    try {
      await launchUrl(
        uri,
      );
    } catch (e) {
      if (Platform.isAndroid) {
        await launch(
            'https://play.google.com/store/apps/details?id=$packageName');
      } else if (Platform.isIOS) {
        launchUrlString("https://apps.apple.com/app/id$iosAppID");
      }
    }
  }
}

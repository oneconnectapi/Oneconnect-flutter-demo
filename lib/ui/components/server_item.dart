import 'package:dart_ping/dart_ping.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:oneconnect_flutter/openvpn_flutter.dart';
import 'package:one_vpn/core/providers/globals/vpn_provider.dart';
import 'package:one_vpn/core/utils/config.dart';
import 'package:one_vpn/core/utils/utils.dart';
import 'package:one_vpn/ui/components/custom_divider.dart';
import 'package:one_vpn/ui/components/custom_image.dart';

import '../../core/providers/globals/ads_provider.dart';
import '../../core/resources/environment.dart';

class ServerItem extends StatefulWidget {
  final VpnServer config;
  const ServerItem(this.config, {super.key});

  @override
  State<ServerItem> createState() => _ServerItemState();
}

class _ServerItemState extends State<ServerItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    super.build(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _itemClick,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: widget.config.flagUrl.contains("http")
                  ? CustomImage(
                      url: widget.config.flagUrl,
                      fit: BoxFit.contain,
                      borderRadius: BorderRadius.circular(5),
                    )
                  : Image.asset(
                      "icons/flags/png/${widget.config.flagUrl}.png",
                      package: "country_icons",
                    ),
            ),
            const RowDivider(),
            Expanded(
                child: Text(widget.config.serverName,
                    style: const TextStyle(color: Colors.white))),
            const RowDivider(),
            if (showSignalStrength)
              FutureBuilder(
                  future: Future.microtask(
                      () => Ping(widget.config.server, count: 1).stream.first),
                  builder: (context, snapshot) {
                    var ms = DateTime.now().difference(now).inMilliseconds;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Image.asset("assets/icons/signal0.png",
                          width: 32, height: 32, color: Colors.grey.shade400);
                    }
                    if (ms < 80) {
                      return Image.asset("assets/icons/signal3.png",
                          width: 32, height: 32);
                    } else if (ms < 150) {
                      return Image.asset("assets/icons/signal2.png",
                          width: 32, height: 32);
                    } else if (ms < 300) {
                      return Image.asset("assets/icons/signal1.png",
                          width: 32, height: 32);
                    } else if (ms > 300) {
                      return Image.asset("assets/icons/signal0.png",
                          width: 32, height: 32);
                    }
                    return Image.asset("assets/icons/signal0.png",
                        width: 32, height: 32, color: Colors.grey);
                  }),
          ],
        ),
      ),
    );
  }

  void _itemClick([bool force = false]) async {
    if (Config.appleOn != "1" && int.parse(widget.config.isFree) == 1 &&
        !force) {
      return NAlertDialog(
        blur: 10,
        title: const Text("premium_servers").tr(),
        content: Text(unlockProServerWithRewardAds
                ? "also_allowed_with_watch_ad_description"
                : "not_allowed_description")
            .tr(),
        actions: [
          if (unlockProServerWithRewardAds)
            TextButton(
              child: Text("watch_ad".tr()),
              onPressed: () {
                Navigator.pop(context);
                showReward();
              },
            ),
        ],
      ).show(context);
    }
    VpnProvider.read(context)
        .selectServer(context, widget.config)
        .then((value) {
      if (value != null) {
        VpnProvider.read(context).disconnect();
        closeScreen(context);
      }
    });
  }

  void showReward() async {
    CustomProgressDialog customProgressDialog =
        CustomProgressDialog(context, dismissable: false, onDismiss: () {});

    customProgressDialog.show();

    AdsProvider.read(context)
        .loadRewardAd(interstitialRewardAdUnitID)
        .then((value) async {
      customProgressDialog.dismiss();
      if (value != null) {
        value.show(onUserEarnedReward: (ad, reward) {
          _itemClick(true);
        });
      } else {
        if (unlockProServerWithRewardAdsFail) {
          await NAlertDialog(
            blur: 10,
            title: Text("no_reward_title".tr()),
            content: Text("no_reward_but_unlock_description".tr()),
            actions: [
              TextButton(
                  child: Text("understand".tr()),
                  onPressed: () => Navigator.pop(context))
            ],
          ).show(context);
          _itemClick(true);
        } else {
          NAlertDialog(
            blur: 10,
            title: Text("no_reward_title".tr()),
            content: Text("no_reward_description".tr()),
            actions: [
              TextButton(
                  child: Text("understand".tr()),
                  onPressed: () => Navigator.pop(context))
            ],
          ).show(context);
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}

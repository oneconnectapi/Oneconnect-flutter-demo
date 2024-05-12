import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:one_vpn/core/providers/globals/ads_provider.dart';
import 'package:one_vpn/core/resources/environment.dart';
import 'package:one_vpn/core/utils/utils.dart';
import 'package:oneconnect_flutter/openvpn_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/globals/vpn_provider.dart';
import '../../core/resources/colors.dart';

class ConnectionButton extends StatefulWidget {
  const ConnectionButton({super.key});

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  InterstitialAd? interstitialAd;
  Timer? interstitialTimeout;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      loadInterstitial();
    });
    super.initState();
  }

  @override
  void dispose() {
    interstitialTimeout?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _connectButtonClick(context),
      child: SizedBox(
        height: 160,
        width: 160,
        child: Consumer<VpnProvider>(
          builder: (context, value, child) {
            switch (value.vpnStage ?? VPNStage.disconnected) {
              case VPNStage.connected:
                _controller.stop();
                return _connectedUI(context);
              case VPNStage.disconnected:
                _controller.stop();
                return _disconnectedUI(context);
              default:
                if (!_controller.isAnimating) {
                  _controller.repeat();
                }
                return _connectingUI(context, value.vpnStage!);
            }
          },
        ),
      ),
    );
  }

  Widget _connectedUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: connectedGradient,
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: connectedGradient),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.power_settings_new_rounded,
                size: 70, color: Colors.white),
            Text(
              "CONNECTED",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _connectingUI(BuildContext context, VPNStage stage) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: Tween<double>(begin: 0, end: 1).animate(_controller),
          builder: (context, child) => Transform.rotate(
            angle: _controller.value * 2 * 3.14,
            child: child,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: Lottie.asset(
                  "assets/animations/connecting.json",
                ),
              ),
              Text(
                stage.name.toUpperCase().replaceAll("_", " "),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _disconnectedUI(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink,
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.pink),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.power_settings_new_rounded,
              size: 70,
              color: Colors.white.withOpacity(1),
            ),
            Text(
              "DISCONNECTED",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white.withOpacity(1),
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _connectButtonClick(BuildContext context) {
    var vpnProvider = VpnProvider.read(context);
    if (vpnProvider.vpnStage != VPNStage.disconnected) {
      vpnProvider.disconnect();
      if (vpnProvider.isConnected) {
        interstitialAd?.showIfNotPro(context);
      }
    } else {
      vpnProvider.connect();
      interstitialAd?.showIfNotPro(context);
    }
  }

  void loadInterstitial() {
    interstitialTimeout?.cancel();
    AdsProvider.read(context)
        .loadInterstitial(interstitialAdUnitID)
        .then((value) {
      if (value != null) {
        interstitialAd = value;
        interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            interstitialAd!.dispose();
            interstitialAd = null;
            loadInterstitial();
          },
        );
      } else {
        interstitialTimeout =
            Timer(const Duration(minutes: 1), loadInterstitial);
      }
    });
  }
}

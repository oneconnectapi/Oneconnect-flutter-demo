import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_vpn/core/utils/preferences.dart';
import 'package:oneconnect_flutter/openvpn_flutter.dart';
import 'package:provider/provider.dart';

import '../../resources/environment.dart';

class VpnProvider extends ChangeNotifier {
  VPNStage? vpnStage;
  VpnStatus? vpnStatus;
  VpnServer? _vpnConfig;

  VpnServer? get vpnConfig => _vpnConfig;
  set vpnConfig(VpnServer? value) {
    _vpnConfig = value;
    Preferences.instance().then((prefs) {
      prefs.setTrueServer(value);
    });
    notifyListeners();
  }

  ///VPN engine
  late OpenVPN engine;

  ///Check if VPN is connected
  bool get isConnected => vpnStage == VPNStage.connected;

  ///Initialize VPN engine and load last server
  void initialize(BuildContext context) {
    engine = OpenVPN(
        onVpnStageChanged: onVpnStageChanged,
        onVpnStatusChanged: onVpnStatusChanged)
      ..initialize(
        lastStatus: onVpnStatusChanged,
        lastStage: (stage) => onVpnStageChanged(stage, stage.name),
        groupIdentifier: groupIdentifier,
        localizedDescription: localizationDescription,
        providerBundleIdentifier: providerBundleIdentifier,
      );

    Preferences.instance().then((value) async {
      vpnConfig =
          value.getTrueServer(); //?? await ServersHttp(context).random();
      notifyListeners();
    });
  }

  ///VPN status changed
  void onVpnStatusChanged(VpnStatus? status) {
    vpnStatus = status;
    notifyListeners();
  }

  ///VPN stage changed
  void onVpnStageChanged(VPNStage stage, String rawStage) {
    vpnStage = stage;
    if (stage == VPNStage.error) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        vpnStage = VPNStage.disconnected;
      });
    }
    notifyListeners();
  }

  ///Connect to VPN server
  void connect() async {

    log("username: ${vpnConfig?.vpnUserName}");
    log("password: ${vpnConfig?.vpnPassword}");

    print("LOGCRED: ${vpnConfig?.vpnUserName}");
    print("LOGCRED: ${vpnConfig?.vpnPassword}");
    print("LOGCRED: ${vpnConfig?.ovpnConfiguration}");

    String? config;
    try {
      config = await OpenVPN.filteredConfig(vpnConfig?.ovpnConfiguration);
    } catch (e) {
      config = vpnConfig?.ovpnConfiguration;
    }
    if (config == null) return;
    log(config);
    engine.connect(
      config,
      vpnConfig!.serverName,
      certIsRequired: certificateVerify,
      username: vpnConfig!.vpnUserName,
      password: vpnConfig!.vpnPassword,
    );
  }

  ///Select server from list
  Future<VpnServer?> selectServer(
      BuildContext context, VpnServer config) async {
    vpnConfig = config;
    notifyListeners();
    return vpnConfig;
  }

  ///Disconnect from VPN server if connected
  void disconnect() {
    engine.disconnect();
  }

  static VpnProvider watch(BuildContext context) => context.watch();
  static VpnProvider read(BuildContext context) => context.read();
}

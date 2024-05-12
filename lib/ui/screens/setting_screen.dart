import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:one_vpn/core/utils/preferences.dart';
import 'package:one_vpn/core/utils/settings_item_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  bool _notificationActive = true;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() {
    _notificationActive = Preferences.getNotificationSetting();
    setState(() {});
  }

  void _updateOnSignal(bool value) {
    setState(() {
      _notificationActive = value;
    });
    Preferences.setNotificationSetting(isActive: _notificationActive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('settings').tr(),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SettingItemWidget(
            leading: const Icon(Icons.notifications_active),
            title: 'Enable Push Notification',
            trailing: Switch(
              value: _notificationActive,
              onChanged: _updateOnSignal,
            ),
          ),
        ])));
  }
}

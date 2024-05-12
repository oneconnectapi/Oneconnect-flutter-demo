import 'package:country_codes/country_codes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:one_vpn/core/resources/environment.dart';
import 'package:provider/provider.dart';

import '../../../ui/components/custom_divider.dart';
import '../../utils/navigations.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void changeThemeMode(BuildContext context) {
    NAlertDialog(
      title: const Text('theme_mode_title').tr(),
      blur: 10,
      content: Consumer<ThemeProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("theme_mode_subtitle").tr(),
            const ColumnDivider(),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: provider.themeMode,
              title: const Text("system_theme_mode").tr(),
              onChanged: (value) {
                provider.setThemeMode(value!);
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: provider.themeMode,
              title: const Text("light_theme_mode").tr(),
              onChanged: (value) {
                provider.setThemeMode(value!);
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: provider.themeMode,
              title: const Text("dark_theme_mode").tr(),
              onChanged: (value) {
                provider.setThemeMode(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => closeScreen(context),
          child: const Text("close").tr(),
        ),
      ],
    ).show(context);
  }


  void changeLanguage(BuildContext context) {
    NAlertDialog(
      title: const Text('language_title').tr(),
      blur: 10,
      content: Consumer<ThemeProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("language_subtitle").tr(),
            const ColumnDivider(),
            ...supportedLocales
                .map((item) => RadioListTile<Locale>(
                      value: item,
                      groupValue: context.locale,
                      title: Text(CountryCodes.detailsForLocale(item).localizedName ?? "Unknown ${item.languageCode}"),
                      onChanged: (value) => context.setLocale(value!),
                    ))
                
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => closeScreen(context),
          child: const Text("close").tr(),
        ),
      ],
    ).show(context);
  }

  static ThemeProvider read(BuildContext context) => context.read();
  static ThemeProvider watch(BuildContext context) => context.watch();
}

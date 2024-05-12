import 'package:flutter/material.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final double? width;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final Function? onTap;
  final EdgeInsets? padding;
  final int paddingAfterLeading;
  final int paddingBeforeTrailing;
  final Color? titleTextColor;
  final Color? subTitleTextColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;
  final Decoration? decoration;
  final double? borderRadius;
  final BorderRadius? radius;

  const SettingItemWidget({
    required this.title,
    this.onTap,
    this.width,
    this.subTitle = '',
    this.leading,
    this.trailing,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.padding,
    this.paddingAfterLeading = 16,
    this.paddingBeforeTrailing = 16,
    this.titleTextColor,
    this.subTitleTextColor,
    this.decoration,
    this.borderRadius,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: hoverColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      onTap: onTap as void Function()?,
      child: Container(
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: decoration ?? const BoxDecoration(),
        child: Row(
          children: [
            leading ?? const SizedBox(),
            if (leading != null)
              SizedBox(width: paddingAfterLeading.toDouble()),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (trailing != null)
              SizedBox(width: paddingBeforeTrailing.toDouble()),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

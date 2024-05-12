import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatelessWidget {
  final String initialHtml;

  const CustomWebView({super.key, required this.initialHtml});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          transparentBackground: true,
        ),
      ),
      onWebViewCreated: (controller) async {
        await controller.loadData(
          data: initialHtml,
          mimeType: 'text/html',
          encoding: 'utf-8',
        );
      },
    );
  }
}

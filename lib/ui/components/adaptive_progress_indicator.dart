import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  const AdaptiveProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const CircularProgressIndicator();
    } else {
      return const CupertinoActivityIndicator();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:one_vpn/core/utils/utils.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imageUrl;

  const CustomCircleAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Image.asset(
                  "${AssetsPath.iconpath}logo_android.png",
                  fit: BoxFit.cover,
                  height: 125,
                  width: 125,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "${AssetsPath.iconpath}logo_android.png",
                  fit: BoxFit.cover,
                  height: 125,
                  width: 125,
                ),
                imageBuilder: (context, imageProvider) => Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                height: 125,
                width: 125,
              )
            : Image.asset(
                "${AssetsPath.iconpath}logo_android.png",
                fit: BoxFit.cover,
                height: 125,
                width: 125,
              ),
      ),
    );
  }
}

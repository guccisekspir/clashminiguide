import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:octo_image/octo_image.dart';

class MiniNetworkImage extends StatelessWidget {
  final String imageURL;
  final bool isOval;
  final BoxFit boxFit;
  const MiniNetworkImage({Key? key, required this.imageURL, this.isOval = false, this.boxFit = BoxFit.fill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isOval
        ? ClipOval(
            child: OctoImage(
              image: CachedNetworkImageProvider(imageURL),
              placeholderBuilder: OctoPlaceholder.blurHash(
                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              errorBuilder: OctoError.icon(color: Colors.red),
              fit: boxFit,
            ),
          )
        : OctoImage(
            image: CachedNetworkImageProvider(imageURL),
            placeholderBuilder: OctoPlaceholder.blurHash(
              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
            ),
            errorBuilder: OctoError.icon(color: Colors.red),
            fit: boxFit,
          );
  }
}

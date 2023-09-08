import 'package:flutter/material.dart';

import '../../../../common/constants/app_color.dart';

class StaggeredWidget extends StatelessWidget {
  final String image;
  final num width;
  final num height;
  final String text;

  const StaggeredWidget({
    required this.text,
    required this.width,
    required this.height,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: width.toDouble() / height.toDouble(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                width: width.toDouble(),
                height: height.toDouble(),
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          left: 20,
          width: size.width,
          child: Container(
            width: size.width,
            height: 40,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColor.black,
                    blurRadius: 30,
                    spreadRadius: 20,
                    blurStyle: BlurStyle.normal,
                    offset: Offset(-20, 20)),
              ],
            ),
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColor.white,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

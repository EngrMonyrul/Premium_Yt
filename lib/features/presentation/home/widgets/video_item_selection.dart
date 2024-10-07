import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoItemSelection extends StatelessWidget {
  const VideoItemSelection(
      {super.key, this.onPressed, this.icon, this.title, this.subTitle});

  final VoidCallback? onPressed;
  final IconData? icon;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                    Text(
                      subTitle ?? "",
                      style: const TextStyle(
                        fontSize: 10,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';
import 'package:provider/provider.dart';
import 'package:tubebuddy_3/core/enums/media_options.dart';
import 'package:tubebuddy_3/features/presentation/home/page/home_page.dart';
import 'package:tubebuddy_3/features/presentation/home/provider/home_provider.dart';
import 'package:tubebuddy_3/features/presentation/home/widgets/video_item_selection.dart';
import 'package:tubebuddy_3/features/presentation/home/widgets/yt_pip_view.dart';

class MediaOptionDialog extends StatelessWidget {
  const MediaOptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return AlertDialog(
      content: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Select Option Below",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            VideoItemSelection(
              onPressed: () {
                homeProvider.setMediaOption(option: MediaOptions.video);
              },
              icon: Icons.ondemand_video_rounded,
              title: "Watch Now",
              subTitle: "Watch in YouTube",
            ),
            const SizedBox(
              height: 10,
            ),
            VideoItemSelection(
              onPressed: () {
                homeProvider.setMediaOption(option: MediaOptions.audio);
              },
              icon: Icons.music_note,
              title: "Listen Now",
              subTitle: "Listen in Audio Player",
            ),
            const SizedBox(
              height: 10,
            ),
            VideoItemSelection(
              onPressed: () {
                homeProvider.setMediaOption(option: MediaOptions.pip);
                Navigator.push(context, MaterialPageRoute(builder: (context) => YtPipView()));
              },
              icon: Icons.featured_video_outlined,
              title: "Watch in PIP",
              subTitle: "Watch the video in Picture in Picture",
            ),
          ],
        ),
      ),
    );
  }
}

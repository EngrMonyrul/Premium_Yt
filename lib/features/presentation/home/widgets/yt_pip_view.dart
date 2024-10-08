import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

class YtPipView extends StatefulWidget {
  const YtPipView({super.key});

  @override
  State<YtPipView> createState() => _YtPipViewState();
}

class _YtPipViewState extends State<YtPipView> {
  void showPipWidget() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Show")),
        ],
      ),
    );
  }
}

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubebuddy_3/config/extensions/context_ext.dart';
import 'package:tubebuddy_3/core/constants/assets_const.dart';
import 'package:tubebuddy_3/features/presentation/home/provider/home_provider.dart';
import 'package:tubebuddy_3/features/presentation/home/widgets/media_option_dialog.dart';
import 'package:tubebuddy_3/features/presentation/home/widgets/video_item_selection.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*<<----------->> variables <<----------->>*/
  late WebViewController webViewController;
  bool visiableFullScreenAds = false;
  String url = "https://m.youtube.com/";

  /*<<----------->> methods <<----------->>*/
  Future<void> webViewControllerInit() async {
    final homeProvider = context.read<HomeProvider>();

    /* <<--------->> controller <<---------->> */
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        /* <<--------->> navigation request <<---------->> */
        onNavigationRequest: (request) {
          print("Url Navigating");
          if (request.url == "https://m.youtube.com/") {
            return NavigationDecision.navigate;
          } else {
            return NavigationDecision.prevent;
          }
        },

        /* <<--------->> url change <<---------->> */
        onUrlChange: (change) {
          print("Url Changing");
          homeProvider.setFileUrl(url: change.url!);
          if (change.url != "" && change.url!.contains("watch")) {
            showVideoOptions();
          }
        },
      ))
      ..loadRequest(
        Uri.parse("https://www.youtube.com/"),
      );
  }

  showVideoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return const MediaOptionDialog();
      },
    );
  }

  Future<void> refreshPage() async {
    await webViewController.reload();
  }

  @override
  void initState() {
    webViewControllerInit();
    super.initState();
  }

  /*<<----------->> builder method <<----------->>*/
  @override
  Widget build(BuildContext context) {
    /*<<----------->> variables <<----------->>*/
    final screenSize = context.screenSize;
    final homeProvider = Provider.of<HomeProvider>(context);

    /*<<----------->> scaffold <<----------->>*/
    return PopScope(
      canPop: homeProvider.popPressed == 2 ? true : false,
      onPopInvokedWithResult: (didPop, result) {
        homeProvider.setPopPressed();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: CustomMaterialIndicator(
            onRefresh: refreshPage,
            child: Stack(
              children: [
                /*<<----------->> web view <<----------->>*/
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: screenSize.width,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: WebViewWidget(
                        controller: webViewController,
                      ),
                    ),
                  ],
                ),

                /*<<----------->> ads <<----------->>*/
                if (visiableFullScreenAds)
                  SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Image.network(
                      "https://developers.google.com/static/admob/images/full-screen/image00.png",
                      fit: BoxFit.fill,
                    ),
                  ),

                /*<<----------->> visible button <<----------->>*/
                if (visiableFullScreenAds)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          visiableFullScreenAds = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.cancel),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Cancel Ads"),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: (homeProvider.mediaOptions?.isAudio ?? false)
              ? Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1eClYk1nSha-lhUoxFPpRRbEP3ZQAu2nhsH7hmQ1KnSpx-SeS2RrcZnAeQvlufETwDSg&usqp=CAU"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pehle Bhi Main Tumshe Mila Huu",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Pehle Bhi Main Tumshe Mila Huu",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "440M Views",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle_fill,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeProvider.setMediaOption(option: null);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          floatingActionButton: (homeProvider.fileUrl != "" &&
                  homeProvider.fileUrl.contains("watch"))
              ? InkWell(
                  onTap: showVideoOptions,
                  child: CircleAvatar(
                    backgroundColor: CupertinoColors.systemGrey5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(AssetsConsts.icMenu),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

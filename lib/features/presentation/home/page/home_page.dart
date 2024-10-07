import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubebuddy_3/config/extensions/context_ext.dart';
import 'package:tubebuddy_3/features/presentation/home/provider/home_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*<<----------->> variables <<----------->>*/
  late WebViewController webViewController;
  bool visiableFullScreenAds = true;

  /*<<----------->> methods <<----------->>*/
  Future<void> webViewControllerInit() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..loadRequest(
        Uri.parse("https://www.youtube.com/"),
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
        ),
      ),
    );
  }
}

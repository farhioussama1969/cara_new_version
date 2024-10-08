import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'header_component.dart';

class WebViewComponent extends StatefulWidget {
  const WebViewComponent(
      {Key? key,
      required this.url,
      this.onExitWebView,
      this.title,
      required this.onPageFinished})
      : super(key: key);

  final String url;
  final Function? onExitWebView;
  final String? title;
  final Function(String url) onPageFinished;

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  bool isLoading = true;

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    WebViewController? webViewController;
    return WillPopScope(
      onWillPop: () async {
        if (widget.onExitWebView != null) {
          widget.onExitWebView!();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: HeaderComponent(
          title: widget.title,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      WebViewWidget(
                        // initialUrl: widget.url,
                        // javascriptMode: JavascriptMode.unrestricted,
                        // zoomEnabled: true,
                        // onWebViewCreated: (controller) {
                        //   webViewController = controller;
                        // },
                        // onPageFinished: (url) {
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        //   widget.onPageFinished(url);
                        // },
                        // onPageStarted: (url) {},
                        controller: controller,
                      ),
                      if (isLoading)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.beat(
                              color: MainColors.primaryColor,
                              size: 70.h,
                            ),
                            SizedBox(height: 20.h),
                            Center(
                              child: Text(
                                '${StringsAssetsConstants.pleaseWait}...',
                                style: TextStyles.mediumBodyTextStyle(context),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

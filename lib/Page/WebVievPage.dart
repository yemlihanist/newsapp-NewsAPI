import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVievPage extends StatefulWidget {
  String url;
  WebVievPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebVievPage> createState() => _WebVievPageState();
}

class _WebVievPageState extends State<WebVievPage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios)),
                    const Text(
                      "News Source",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left,
                    ),
                    Center(),
                  ],
                ),
              ),
              Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
                      onProgress: (int progress) {
                        print('WebView is loading (progress : $progress%)');
                      },
                      javascriptChannels: <JavascriptChannel>{
                        _toasterJavascriptChannel(context),
                      },
                      navigationDelegate: (NavigationRequest request) {
                        if (request.url
                            .startsWith('https://www.youtube.com/')) {
                          print('blocking navigation to $request}');
                          return NavigationDecision.prevent;
                        }
                        print('allowing navigation to $request');
                        return NavigationDecision.navigate;
                      },
                      onPageStarted: (String url) {
                        print('Page started loading: $url');
                      },
                      onPageFinished: (String url) {
                        print('Page finished loading: $url');
                      },
                      gestureNavigationEnabled: true,
                      backgroundColor: const Color(0x00000000),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

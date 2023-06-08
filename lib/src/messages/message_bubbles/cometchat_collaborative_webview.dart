import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///Collaborative  Web view uses WebView
class CometChatCollaborativeWebView extends StatefulWidget {
  const CometChatCollaborativeWebView(
      {Key? key,
      required this.title,
      required this.webviewUrl,
      this.titleStyle,
      this.backIcon,
      this.appBarColor})
      : super(key: key);

  ///[title] of the page
  final String title;

  ///[titleStyle]  text style
  final TextStyle? titleStyle;

  ///WebView package use [webviewUrl] to render page
  final String webviewUrl;

  ///[backIcon] displays back  Icon
  final Icon? backIcon;

  ///[appBarColor] , default is Color(0xffFFFFFF)
  final Color? appBarColor;

  @override
  _CometChatCollaborativeWebViewState createState() => _CometChatCollaborativeWebViewState();
}

class _CometChatCollaborativeWebViewState extends State<CometChatCollaborativeWebView> {
  late WebViewController _controller;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) changeLoading(false);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webviewUrl));
  }

  void changeLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.appBarColor ?? const Color(0xffFFFFFF),
        elevation: 0,
        toolbarHeight: 56,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: widget.backIcon ??
              const Icon(
                Icons.close,
                size: 24,
                color: Color(0xff3399FF),
              ),
        ),
        title: Text(
          widget.title,
          style: widget.titleStyle ??
              const TextStyle(color: Color(0xff141414), fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}

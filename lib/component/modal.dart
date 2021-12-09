import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Modal extends StatefulWidget {
  final String url;
  const Modal({Key? key, required this.url}) : super(key: key);

  @override
  _ModalState createState() => _ModalState();
}



class _ModalState extends State<Modal> {

  double _webViewHeight = 1;
  late WebViewController _webViewController;

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _webViewController
          .evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(10),
                topLeft: const Radius.circular(10),
              ),
            ),
            child: Align(alignment: Alignment.center,
              child: Text("Article",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Pacifico'
                  )
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: _webViewHeight,
                color: Colors.white,
                child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (String url) => _onPageFinished(context, url),
                      onWebViewCreated: (controller) async {
                        _webViewController = controller;
                      },
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayFastCheckoutScreen extends StatefulWidget {
  final String actionUrl;
  final Map<String, String> fields;

  const PayFastCheckoutScreen({
    super.key,
    required this.actionUrl,
    required this.fields,
  });

  @override
  State<PayFastCheckoutScreen> createState() => _PayFastCheckoutScreenState();
}

class _PayFastCheckoutScreenState extends State<PayFastCheckoutScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    debugPrint('PayFast action URL: ${widget.actionUrl}');
    debugPrint('PayFast field names: ${widget.fields.keys.toList()}');
    // Do not print field values; they may contain sensitive data.

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('PAGE STARTED: $url');
          },
          onPageFinished: (url) {
            debugPrint('PAGE FINISHED: $url');
          },
          onNavigationRequest: (request) {
            debugPrint('NAVIGATION: ${request.url}');
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            debugPrint('WEB RESOURCE ERROR');
            debugPrint('Code: ${error.errorCode}');
            debugPrint('Description: ${error.description}');
            debugPrint('URL: ${error.url}');
            debugPrint('Main frame: ${error.isForMainFrame}');
          },
        ),
      )
      ..loadHtmlString(_buildPaymentForm());
  }

  String _buildPaymentForm() {
    final fieldsHtml = widget.fields.entries
        .map((entry) {
          final name = _escapeHtml(entry.key);
          final value = _escapeHtml(entry.value);

          return '<input type="hidden" '
              'name="$name" value="$value">';
        })
        .join('\n');

    final action = _escapeHtml(widget.actionUrl);

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">
</head>
<body>
  <p id="status">Preparing PayFast checkout...</p>

  <form id="payfastForm" method="POST" action="$action">
    $fieldsHtml
    <button type="submit">Continue to PayFast</button>
  </form>

  <script>
    document.getElementById('payfastForm').submit();
  </script>
</body>
</html>
''';
  }

  String _escapeHtml(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('"', '&quot;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayFast Payment')),
      body: WebViewWidget(controller: _controller),
    );
  }
}

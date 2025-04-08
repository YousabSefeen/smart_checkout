import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../ Transaction Process States/data/Models/paymob_transaction_data_result_model.dart';
import '../../../../../Core/Error/paymob_error_handler.dart';

import '../../../../../Core/app strings manager/app_strings.dart';
import '../../../../../Core/payment_gateway_manager/payment_gateway_manager.dart';

import '../../../../../Core/payment_gateway_manager/paymob_payment/paymob_keys.dart';
import '../../../../../enums/web_view_status.dart';

class PaymobWebViewProvider extends ChangeNotifier {
  late WebViewController? _webViewController;

  String? _currentUrl;
  PaymobTransactionDataModel? transactionResult;
  WebViewStatus _webViewStatus = WebViewStatus.init;
  String? errorMessage;
  String? transactionDate;
  String? transactionTime;

  WebViewController get webViewController => _webViewController!;

  WebViewStatus get webViewStatus => _webViewStatus;

  void initializeWebView(BuildContext context) {
    _webViewStatus = WebViewStatus.init;
    notifyListeners();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView loading progress: $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            _currentUrl = url;
            debugPrint('Page finished loading: $url');

            if (url.contains(PaymobKeys.ngrokUrl)) {
              _fetchTransactionResult();
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebResourceError: ${error.description}');
            _webViewStatus = WebViewStatus.onHttpError;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('JavaScript message received: ${message.message}');
        },
      )
      ..loadRequest(
        PaymentGatewayManager.selectedPaymentMethod == AppStrings.mobileWallets
            ? Uri.parse(PaymobKeys.mobileWalletRedirectUrl!)
            : Uri.parse(
                PaymobKeys.onlineCardIframeUrl(PaymobKeys.paymentToken!),
              ),
      );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _webViewController = controller;
    notifyListeners();
  }

  @override
  void dispose() {
    clearWebView();
    super.dispose();
  }

  void clearWebView() {
    _webViewStatus = WebViewStatus.init;
    _webViewController?.clearCache();
    _webViewController = null;
    notifyListeners();
  }

  void _fetchTransactionResult() {
    notifyListeners();

    final uri = Uri.parse(_currentUrl!);
    final queryParams = uri.queryParameters;

    transactionResult = PaymobTransactionDataModel.fromJson(queryParams);

    if (transactionResult?.success == 'true') {
      _webViewStatus = WebViewStatus.success;
      _extractTransactionDateTime();
    } else {
      _webViewStatus = WebViewStatus.error;
      errorMessage =
          PaymobErrorHandler.getErrorMessage(transactionResult?.dataMessage);
    }

    notifyListeners();
  }

  void _extractTransactionDateTime() {
    String dateTimeString = transactionResult!.created_at!;
    DateTime parsedDateTime = DateTime.parse(dateTimeString);

    transactionDate =
        "${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')}";
    transactionTime =
        "${parsedDateTime.hour.toString().padLeft(2, '0')}:${parsedDateTime.minute.toString().padLeft(2, '0')}:${parsedDateTime.second.toString().padLeft(2, '0')}";
  }
}

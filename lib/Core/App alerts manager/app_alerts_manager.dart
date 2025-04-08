import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppAlerts {
  static customErrorSnackBar({
    required BuildContext context,
    required String msg,
  }) {
    showTopSnackBar(
      displayDuration: const Duration(seconds: 2),
      Overlay.of(context),
      CustomSnackBar.error(
        icon: const SizedBox(),
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),

        message: msg,
      ),
    );
  }

  static customDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Canceled'),
          content: const Text('The payment process was canceled by the user.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

 static void customToast({ required bool isIncreaseButton}){
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg:isIncreaseButton? 'Quantity increased':'Quantity decreased',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,

        backgroundColor:isIncreaseButton?   const Color(0xFF34C759):Colors.red.shade500,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../Presentation/Controller/paymob_web_view_provider.dart';

class PaymobErrorMessage extends StatelessWidget {
  const PaymobErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        textAlign: TextAlign.center,
        //  text:  _buildHighlightedText(invalidCardMessage ,),
        text: _buildHighlightedText(
            text:
                context.watch<PaymobWebViewProvider>().errorMessage ?? 'Null'),
      ),
    );
  }

  TextSpan _buildHighlightedText({required String text}) {
    final TextStyle generalTextStyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
        height: 1.5);
    final TextStyle boldWordsTextStyle = GoogleFonts.roboto(
        textStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: .5));
    final List<String> boldWords = [
      'Card Number',
      'Number',
      'Expiration Date',
      'CVV'
    ];
    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in RegExp(boldWords.join("|")).allMatches(text)) {
      // إضافة النص العادي قبل الكلمة المحددة
      if (match.start > lastIndex) {
        spans.add(TextSpan(
            text: text.substring(lastIndex, match.start),
            style: generalTextStyle));
      }

      // إضافة الكلمة بخط سميك
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: boldWordsTextStyle,
      ));

      lastIndex = match.end;
    }

    // إضافة أي نص متبقي بعد آخر كلمة مميزة
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: generalTextStyle,
      ));
    }

    return TextSpan(
      children: spans,
    );
  }
}

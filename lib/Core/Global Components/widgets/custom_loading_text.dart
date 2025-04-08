import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingText extends StatelessWidget {
  const CustomLoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.black,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            WavyAnimatedText('Loading...', speed: const Duration(seconds: 5)),
          ],
        ),
      ),
    );
  }
}

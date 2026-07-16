import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotSeparator extends StatelessWidget {
  const DotSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(
        horizontal: 6.w,
      ),
      child: const Text('·'),
    );
  }
}
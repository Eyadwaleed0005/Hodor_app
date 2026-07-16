import 'package:flutter/material.dart';
import 'package:Hodor/core/style/textstyles.dart';

class TitleSection extends StatelessWidget {
  final String title;

  const TitleSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: Textstyles.font20BlackBold(),
        textAlign: TextAlign.right,
      ),
    );
  }
}
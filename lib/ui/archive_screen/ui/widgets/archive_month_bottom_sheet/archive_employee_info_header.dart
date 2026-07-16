import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/style/textstyles.dart';

class ArchiveEmployeeInfoHeader extends StatelessWidget {
  const ArchiveEmployeeInfoHeader({
    super.key,
    required this.employeeName,
    required this.color,
  });

  final String employeeName;
  final Color color;

  String get initials {
    final cleanName = employeeName.trim();
    if (cleanName.length <= 2) return cleanName;
    return cleanName.substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14.r),
          ),
          alignment: Alignment.center,
          child: Text(
            initials,
            style: Textstyles.font18WhiteBold(),
          ),
        ),

        horizontalSpace(10),

        Expanded(
          child: Text(
            employeeName,
            overflow: TextOverflow.ellipsis,
            style: Textstyles.font16BlackBold(),
          ),
        ),
      ],
    );
  }
}
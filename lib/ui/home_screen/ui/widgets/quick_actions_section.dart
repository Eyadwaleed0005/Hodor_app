import 'package:flutter/material.dart';
import 'package:Hodor/core/helper/spacer.dart';
import 'package:Hodor/core/routes/route_names.dart';
import 'package:Hodor/core/style/app_color.dart';
import 'package:Hodor/ui/home_screen/ui/widgets/quick_action_card.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickActionCard(
            icon: Icons.person_off_outlined,
            color: ColorPalette.red,
            title: 'تسجيل الغياب',
            onTap: () {
               Navigator.pushNamed(
                context,
                RouteNames.absenceRegistrationScreen,
              );
            },
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: QuickActionCard(
            icon: Icons.person_add_alt_1_outlined,
            color: ColorPalette.blue,
            title: 'إضافة موظف',
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.addEmployee,
              );
            },
          ),
        ),
      ],
    );
  }
}

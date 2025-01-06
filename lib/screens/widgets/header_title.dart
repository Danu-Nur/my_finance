import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const HeaderTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalGap5(),
        Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: textColor,
            ),
            const HorizontalGap5(),
            Text(
              title,
              style: poppinsH1.copyWith(color: textColor),
            ),
          ],
        ),
      ],
    );
  }
}

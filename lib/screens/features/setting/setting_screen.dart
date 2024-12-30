import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/common/static.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static const routeName = '/settings';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              profileSection(),
              const VerticalGap10(),
            ],
          ),
        ),
      ),
    );
  }

  Container profileSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                      image: AssetImage(imgProfile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const HorizontalGap10(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Listyo Adi Pamungkas',
                    style: poppinsH4.copyWith(color: textColor),
                  ),
                  Text(
                    'listyoap.work@gmail.com',
                    style: poppinsCaption.copyWith(
                      color: textColor.withOpacity(.75),
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor,
              ),
              child: const Icon(
                Icons.edit,
                color: buttonColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

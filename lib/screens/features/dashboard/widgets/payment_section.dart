import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_event.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/common/static.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

Widget paymentSection(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: secondaryColor,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.read<NavBarBloc>().add(ChangeTabIndex(widgetOnTabs[index]));
          },
          splashColor: buttonColor,
          highlightColor: buttonColor,
          focusColor: buttonColor,
          child: Column(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: primaryColor,
                ),
                child: Icon(
                  widgetIcons[index],
                  color: textColor,
                ),
              ),
              const VerticalGap5(),
              Expanded(
                child: Text(
                  widgetTitles[index],
                  style: poppinsCaption.copyWith(
                    color: textColor.withOpacity(.75),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    ),
  );
}

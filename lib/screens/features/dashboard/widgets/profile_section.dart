import 'package:flutter/material.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/common/static.dart';
import 'package:my_finance/blocs/navbar/navbar_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_event.dart';

Widget profileSection(BuildContext context) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: poppinsBody2.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
              Text(
                'Nola Listiana Devi',
                style: poppinsBody1.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              context.read<NavBarBloc>().add(ChangeTabIndex(3));
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage(imgProfile),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }
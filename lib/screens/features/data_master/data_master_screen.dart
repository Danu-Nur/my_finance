import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_event.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';
import 'package:my_finance/common/menu.dart';

class DataMasterScreen extends StatefulWidget {
  const DataMasterScreen({super.key});

  @override
  State<DataMasterScreen> createState() => _DataMasterScreenState();
}

class _DataMasterScreenState extends State<DataMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const VerticalGap10(),
              headerSection(),
              const VerticalGap20(),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const VerticalGap10(),
                  itemCount: Menu.widgetTitles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.read<NavBarBloc>().add(ChangeTabIndex(2));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: buttonColor,
                                      ),
                                      child: Icon(
                                        Menu.widgetIconsMenu[index],
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                const HorizontalGap20(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Menu.widgetTitles[index],
                                      style: poppinsH3.copyWith(
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Menu : ${Menu.widgetDesc[index]}',
                                      style: poppinsCaption.copyWith(
                                        color: textColor.withOpacity(.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_circle_right,
                              color: textColor,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row headerSection() {
    return Row(
      children: [
        const Icon(
          Icons.storage_sharp,
          size: 26,
          color: textColor,
        ),
        const HorizontalGap5(),
        Text(
          'Data Master & Settings',
          style: poppinsH1.copyWith(color: textColor),
        ),
      ],
    );
  }
}

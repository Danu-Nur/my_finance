import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/data/model/saving_target_model.dart';
import 'package:my_finance/data/repository/repository.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/formatters.dart';
import 'package:my_finance/utils/typography.dart';

Widget monthlyBudgetSection(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.pie_chart,
                  color: textColor,
                  size: 24,
                ),
                const HorizontalGap5(),
                Text(
                  'Monthly Budget Check',
                  style: poppinsH4.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_circle_right,
                color: textColor,
                size: 28,
              ),
            )
          ],
        ),
        const VerticalGap10(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 140,
          child: FutureBuilder<List<SavingTargetModel>>(
            future: Repository().getSavingTarget(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const HorizontalGap10(),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final savingValue =
                        rupiahFormatter.format(data[index].hasSaving);
                    final targetValue =
                        rupiahFormatter.format(data[index].totalSaving);
                    return Container(
                      width: MediaQuery.of(context).size.width / 1.25,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[index].purposeName,
                                style: poppinsBody1.copyWith(
                                  color: textColor.withOpacity(.75),
                                ),
                              ),
                              const VerticalGap5(),
                              Text(
                                '$savingValue',
                                style: poppinsBody1.copyWith(
                                  fontSize: 28,
                                  color: buttonColor,
                                ),
                              ),
                              const VerticalGap5(),
                              Text(
                                '$targetValue left in ${data[index].monthDuration} months',
                                style: poppinsBody2.copyWith(
                                  color: textColor.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: data[index].monthDuration > 8
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            child: Icon(
                              data[index].monthDuration > 8
                                  ? Icons.check
                                  : Icons.close,
                              color: textColor,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                  ),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}

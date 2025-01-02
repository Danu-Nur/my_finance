import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_event.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/data/model/transaction_model.dart';
import 'package:my_finance/data/repository/repository.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

Widget transactionSection(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.receipt_rounded,
                color: textColor,
                size: 24,
              ),
              const HorizontalGap5(),
              Text(
                'Recent Activities',
                style: poppinsH4.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              context.read<NavBarBloc>().add(ChangeTabIndex(2));
            },
            child: const Icon(
              Icons.arrow_circle_right,
              color: textColor,
              size: 28,
            ),
          ),
        ],
      ),
      const VerticalGap10(),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: FutureBuilder<List<TransactionModel>>(
          future: Repository().getTransaction(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.separated(
                separatorBuilder: (context, index) => const VerticalGap10(),
                itemCount: data!.length,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: primaryColor,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        data[index].photoUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: data[index].status == true
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    child: Icon(
                                      data[index].status == false
                                          ? Icons.arrow_upward_rounded
                                          : Icons.arrow_downward_rounded,
                                      color: textColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const HorizontalGap10(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name,
                                  style: poppinsBody1.copyWith(
                                    color: textColor,
                                  ),
                                ),
                                Text(
                                  '${data[index].dateTransfer}, ${data[index].timeTransfer}',
                                  style: poppinsCaption.copyWith(
                                    color: textColor.withOpacity(.75),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              data[index].status == false
                                  ? '- \$${data[index].totalMoney}'
                                  : '+ \$${data[index].totalMoney}',
                              style: poppinsH3.copyWith(
                                color: data[index].status == false
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
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
  );
}

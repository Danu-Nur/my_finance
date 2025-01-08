import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/data/model/transaction_model.dart';
import 'package:my_finance/data/repository/repository.dart';
import 'package:my_finance/screens/widgets/dynamic_F_A_B.dart';
import 'package:my_finance/screens/features/data_master/data_master_screen.dart';
import 'package:my_finance/screens/widgets/header_title.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/formatters.dart';
import 'package:my_finance/utils/typography.dart';
import 'package:my_finance/screens/widgets/card_balance.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  // static const routeName = '/history-page';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Color fabColor = Colors.green;
  // List to hold the isMore values for each group
  List<bool> isMoreList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              HeaderTitle(
                  icon: Icons.history_edu_rounded,
                  title: 'Transaction History'),
              const VerticalGap10(),
              transactionSection(),
            ],
          ),
        ),
        // floatingActionButton: DynamicFAB(
        //   addDataPage: DataMasterScreen(), // Halaman tujuan
        //   fabColor: fabColor, // Warna dinamis
        // ),
      ),
    );
  }

  Expanded transactionSection() {
    return Expanded(
      child: FutureBuilder<Map<String, Map<String, List<TransactionModel>>>>(
        future: Repository().getGroupTransactionsByYearAndMonth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: buttonColor),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final groupedData = snapshot.data!;
            final yearKeys = groupedData.keys.toList();

            return ListView.builder(
              itemCount: yearKeys.length,
              itemBuilder: (context, yearIndex) {
                final year = yearKeys[yearIndex];
                final monthsData = groupedData[year]!;
                final monthKeys = monthsData.keys.toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        year,
                        style: poppinsH3.copyWith(color: textColor),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: monthKeys.length,
                      itemBuilder: (context, monthIndex) {
                        final month = monthKeys[monthIndex];
                        final transactions = monthsData[month]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CardBalance(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            month,
                                            style: poppinsH3.copyWith(
                                                color: textColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _buildTransactionSummary(
                                              transactions,
                                              true, // Income
                                            ),
                                          ],
                                        ),
                                        const VerticalGap5(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            _buildTransactionSummary(
                                              transactions,
                                              false, // Expense
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const VerticalGap10(),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 2,
                                      color: textColor.withOpacity(.25),
                                    ),
                                    const VerticalGap10(),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const VerticalGap10(),
                                      itemCount: transactions.length,
                                      itemBuilder: (context, index) {
                                        final transaction = transactions[index];

                                        return SizedBox(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        transaction.name,
                                                        style: poppinsBody2
                                                            .copyWith(
                                                          color: textColor
                                                              .withOpacity(.75),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${_formatDateTransfer(transaction.dateTransfer)}, ${transaction.timeTransfer}',
                                                        style: poppinsCaption
                                                            .copyWith(
                                                          color: textColor
                                                              .withOpacity(.75),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${transaction.status ? '+ ' : '- '} ${rupiahFormatter.format(transaction.totalMoney)}",
                                                style: poppinsH5.copyWith(
                                                  color: transaction.status
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const VerticalGap10(),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No data available.',
                style: TextStyle(color: textColor),
              ),
            );
          }
        },
      ),
    );
  }

// Helper method to format `dateTransfer` using DateFormat('dddd')
  String _formatDateTransfer(String dateTransfer) {
    try {
      final parsedDate = DateFormat('d MMMM yyyy').parse(dateTransfer);
      return DateFormat('dd EEEE').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

// Helper widget for transaction summary
  Widget _buildTransactionSummary(
      List<TransactionModel> transactions, bool isIncome) {
    final color = isIncome ? Colors.green : Colors.red;
    final icon =
        isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;

    final totalAmount = transactions.fold<double>(
      0,
      (previousValue, transaction) {
        final isStatusTrue = transaction.status == true;
        return isIncome == isStatusTrue
            ? previousValue + transaction.totalMoney
            : previousValue;
      },
    );

    return Row(
      children: [
        Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: color,
          ),
          child: Icon(icon, color: textColor, size: 15),
        ),
        const HorizontalGap5(),
        Text(
          rupiahFormatter.format(totalAmount),
          style: poppinsH5.copyWith(color: textColor),
        ),
      ],
    );
  }
}

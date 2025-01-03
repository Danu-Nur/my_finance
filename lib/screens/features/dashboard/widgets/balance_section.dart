import 'package:flutter/material.dart';
import 'package:my_finance/screens/widgets/card_balance.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/common/static.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';
import 'package:my_finance/utils/formatters.dart';

class BalanceSection extends StatefulWidget {
  const BalanceSection(BuildContext context, {super.key});

  @override
  _BalanceSectionState createState() => _BalanceSectionState();
}

class _BalanceSectionState extends State<BalanceSection> {
  bool _isLoad = true;
  bool _isHidden = true;
  bool _isMore = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoad = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardBalance(
          children: [
            totalBalance(),
            loadMoreBalance(),
          ],
        ),
        const VerticalGap10(),
        CardBalance(children: [totalIncome()]),
        const VerticalGap10(),
        CardBalance(children: [totalExpense()]),
        const VerticalGap10(),
        CardBalance(children: [totalAsset()]),
      ],
    );
  }

  Widget loadMoreBalance() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState:
          _isMore ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: const SizedBox(),
      secondChild: Column(
        children: [
          const VerticalGap10(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 2,
            color: textColor.withOpacity(.25),
          ),
          const VerticalGap10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Investation (0,00%)',
                style: poppinsH5.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
              Text(
                'Rp 0',
                style: poppinsH5.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
            ],
          ),
          const VerticalGap5(),
          _buildItemRow('Reksa Dana Bibit', 'Rp 0', imgBibit),
          const VerticalGap10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cash Money (100,00%)',
                style: poppinsH5.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
              Text(
                '\$550,752,210',
                style: poppinsH5.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
            ],
          ),
          const VerticalGap5(),
          _buildItemRow('Saving Pocket', 'Rp 0', imgProfile),
          const VerticalGap5(),
          _buildItemRow('Payment Pocket', '\$550,752,210', imgProfile),
          const VerticalGap5(),
          _buildItemRow('Gopay', 'Rp 0', imgGopay),
        ],
      ),
    );
  }

  Widget totalBalance() {
    return Column(
      children: [
        _viewBalance(
            'Total Balance',
            _isHidden ? rupiahFormatter.format(1000000000) : '---------',
            buttonColor)
      ],
    );
  }

  Widget totalIncome() {
    return Column(
      children: [
        _viewBalance(
            'Total Income', rupiahFormatter.format(5000000000), Colors.green),
      ],
    );
  }

  Widget totalExpense() {
    return Column(
      children: [
        _viewBalance(
            'Total Expense', rupiahFormatter.format(20000000), Colors.red),
      ],
    );
  }

  Widget totalAsset() {
    return Column(children: [
      _viewBalance('My Asset', rupiahFormatter.format(1000000000), Colors.blue),
    ]);
  }

  Widget _viewBalance(String title, String amount, Color amountColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: poppinsBody2.copyWith(
                color: textColor.withOpacity(.75),
              ),
            ),
            Row(
              children: [
                if (title == 'Total Balance')
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                    child: Icon(
                      _isHidden
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: textColor.withOpacity(.75),
                      size: 20,
                    ),
                  ),
                  const HorizontalGap5(),
                if (title == 'Total Balance')
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isMore = !_isMore;
                      });
                    },
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: textColor.withOpacity(.75),
                    ),
                  ),
              ],
            ),
          ],
        ),
        // const SizedBox(height: 8), // Jarak antar elemen
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              amount, // Sembunyikan atau tampilkan jumlah
              style: poppinsH2.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            // const SizedBox(width: 40), // Jarak antar elemen horizontal
          ],
        ),
      ],
    );
  }

  Widget _buildItemRow(String title, String amount, String image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const HorizontalGap5(),
            Text(
              title,
              style: poppinsBody2.copyWith(
                color: textColor.withOpacity(.75),
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: poppinsBody2.copyWith(
            color: textColor.withOpacity(.75),
          ),
        ),
      ],
    );
  }
}

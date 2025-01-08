import 'package:flutter/material.dart';
import 'package:my_finance/screens/widgets/card_balance.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';
import 'package:my_finance/utils/formatters.dart';

class MonthlyBalanceSection extends StatefulWidget {
  const MonthlyBalanceSection(BuildContext context, {super.key});

  @override
  _MonthlyBalanceSectionState createState() => _MonthlyBalanceSectionState();
}

class _MonthlyBalanceSectionState extends State<MonthlyBalanceSection> {
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
        // const VerticalGap10(),
        // CardBalance(children: [totalIncome()]),
        // const VerticalGap10(),
        // CardBalance(children: [totalExpense()]),
        // const VerticalGap10(),
        // CardBalance(children: [totalAsset()]),
      ],
    );
  }

  Widget totalBalance() {
    return Column(
      children: [
        _viewBalance(
            'My Balance',
            _isHidden ? rupiahFormatter.format(15000000) : '---------',
            buttonColor)
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
          _buildItemLoadMore(
              'Income', 20000000, Icons.arrow_upward_sharp, Colors.green),
          const VerticalGap10(),
          _buildItemLoadMore(
              'Expense', 5000000, Icons.arrow_downward_sharp, Colors.red),
          const VerticalGap10(),
        ],
      ),
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
                const HorizontalGap5(),
                if (title == 'Total Balance' || title == 'My Balance')
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isMore = !_isMore;
                      });
                    },
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: textColor.withOpacity(.75),
                      size: 20,
                    ),
                  ),
              ],
            ),
          ],
        ),
        // const SizedBox(height: 8), // Jarak antar elemen
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              amount, // Sembunyikan atau tampilkan jumlah
              style: poppinsH2.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            // const SizedBox(width: 10),
            if (title == 'Total Balance' || title == 'My Balance')
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
            // const SizedBox(width: 40), // Jarak antar elemen horizontal
          ],
        ), // Jarak antar elemen
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

  Widget _buildItemLoadMore(
      String title, int amount, IconData icon, Color bgColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: bgColor,
              ),
              child: Icon(
                icon,
                size: 16,
                color: textColor.withOpacity(.75), // Tambahkan warna ikon
              ),
            ),
            const SizedBox(width: 5), // Ganti HorizontalGap5 dengan SizedBox
            Text(
              title,
              style: poppinsH6.copyWith(
                color: textColor.withOpacity(.75),
              ),
            ),
          ],
        ),
        Text(
          rupiahFormatter.format(amount), // Tambahkan formatter
          style: poppinsH5.copyWith(
            color: bgColor.withOpacity(.90),
          ),
        ),
      ],
    );
  }
}

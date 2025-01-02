import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/common/static.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: poppinsBody2.copyWith(
                  color: textColor.withOpacity(.75),
                ),
              ),
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
          Row(
            children: [
              Text(
                _isHidden ? '\$550,752,210' : '---------',
                style: poppinsH1.copyWith(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const HorizontalGap5(),
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
            ],
          ),
          const VerticalGap10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "\$98,000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: textColor.withOpacity(0.5),
              ),
              Column(
                children: [
                  Text(
                    "\$50,500",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Expenses",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: textColor.withOpacity(0.5),
              ),
              Column(
                children: [
                  Text(
                    "\$89,000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "My Assets",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AnimatedCrossFade(
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
          ),
        ],
      ),
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

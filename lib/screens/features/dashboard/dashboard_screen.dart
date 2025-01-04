import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/screens/features/dashboard/widgets/profile_section.dart';
import 'package:my_finance/screens/features/dashboard/widgets/balance_section.dart';
import 'package:my_finance/screens/features/dashboard/widgets/payment_section.dart';
import 'package:my_finance/screens/features/dashboard/widgets/account_section.dart';
import 'package:my_finance/screens/features/dashboard/widgets/saving_target_section.dart';
import 'package:my_finance/screens/features/dashboard/widgets/transaction_section.dart';
import 'package:my_finance/screens/features/dashboard/widgets/daily_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoad = true;

  void isLoadingSuccess() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isLoadingSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileSection(context),
              const VerticalGap20(),
              BalanceSection(context),
              // const VerticalGap10(),
              // paymentSection(context),
              const VerticalGap20(),
              accountSection(context),
              const VerticalGap20(),
              savingTargetSection(context),
              const VerticalGap20(),
              DailySection(),
              // transactionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  

  
}

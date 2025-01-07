import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_event.dart';
import 'package:my_finance/blocs/navbar/navbar_state.dart';
import 'package:my_finance/screens/features/dashboard/dashboard_screen.dart';
import 'package:my_finance/screens/features/budget/budget_screen.dart';
import 'package:my_finance/screens/features/history/history_screen.dart';
import 'package:my_finance/screens/features/setting/setting_screen.dart';
import 'package:my_finance/screens/features/data_master/data_master_screen.dart';
// import 'package:my_finance/screens/daily_page.dart';
// import 'package:my_finance/screens/transection_page.dart';
import 'package:my_finance/utils/color.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc(),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: const HomeBody(),
        bottomNavigationBar: const HomeFooter(),
        // floatingActionButton: SafeArea(
        //   child: SizedBox(
        //     child: FloatingActionButton(
        //       onPressed: () {},
        //       backgroundColor: buttonColor,
        //       child: const Icon(
        //         Icons.add,
        //         size: 20,
        //       ),
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavBarTabChanged) {
          currentIndex = state.currentIndex;
        }

        List<Widget> pages = [
          DashboardScreen(),
          const BudgetScreen(),
          const HistoryScreen(),
          const SettingScreen(),
          const DataMasterScreen(),
        ];

        return IndexedStack(
          index: currentIndex,
          children: pages,
        );
      },
    );
  }
}

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> iconItems = [
      Icons.home,
      Icons.wallet_rounded,
      Icons.history,
      Icons.inventory_2,
      Icons.storage,
    ];

    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavBarTabChanged) {
          currentIndex = state.currentIndex;
        }

        return AnimatedBottomNavigationBar(
          backgroundColor: secondaryColor.withOpacity(0.5),
          icons: iconItems,
          splashColor: buttonColor,
          inactiveColor: textColor,
          activeColor: buttonColor,
          gapLocation: GapLocation.none,
          activeIndex: currentIndex,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 10,
          iconSize: 25,
          rightCornerRadius: 10,
          elevation: 2,
          onTap: (index) {
            context.read<NavBarBloc>().add(ChangeTabIndex(index));
          },
        );
      },
    );
  }
}

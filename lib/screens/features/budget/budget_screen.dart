import 'package:flutter/material.dart';
import 'package:my_finance/common/function/card_number_gap.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/common/static.dart';
import 'package:my_finance/data/repository/repository.dart';
import 'package:my_finance/screens/widgets/header_title.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/formatters.dart';
import 'package:my_finance/utils/typography.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});
  static const routeName = '/pocket';

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
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
    isLoadingSuccess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          // child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(title: 'My Accounts', icon: Icons.wallet_rounded),
                // const VerticalGap10(),
                // cardListSection(context),
                const VerticalGap10(),
                balanceSection(context),
                const VerticalGap10(),
                Expanded(child: pocketSection(context)),
                // pocketSection(context),
              ],
            ),
          // ),
        ),
      ),
    );
  }

  Widget pocketSection(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height / 2,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder(
        future: Repository().getPocket(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Optional: Show a loading indicator if data is still being fetched
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle errors if the future fails
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final pockets = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: pockets.length,
              itemBuilder: (context, index) {
                final data = pockets[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: data.typePocket == 3
                          ? Colors.blue.shade800
                          : (data.typePocket == 2
                              ? Colors.green.shade700
                              : Colors.blueGrey.shade700),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: data.typePocket == 3
                                ? Colors.blue.shade900
                                : (data.typePocket == 2
                                    ? Colors.green.shade900
                                    : primaryColor),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: data.typePocket == 3 || data.typePocket == 2
                              ? Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image: data.typePocket == 3
                                          ? const AssetImage(
                                              'lib/assets/images/gopay.jpg')
                                          : const AssetImage(
                                              'lib/assets/images/bibit.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                        ),
                        const VerticalGap5(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              data.pocket,
                              style: poppinsBody2.copyWith(
                                color:
                                    data.typePocket == 3 || data.typePocket == 2
                                        ? Colors.white
                                        : textColor.withOpacity(.75),
                              ),
                            ),
                            Text(
                              rupiahFormatter.format(data.totalMoney * 1000000),
                              style: poppinsH6.copyWith(
                                color:
                                    data.typePocket == 3 || data.typePocket == 2
                                        ? Colors.white
                                        : buttonColor,
                              ),
                            ),
                            Text(
                              data.typePocket == 3
                                  ? 'Gopay'
                                  : (data.typePocket == 2 ? 'Bibit' : 'Pocket'),
                              style: poppinsCaption.copyWith(
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }

  Widget balanceSection(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Balance',
              style: poppinsBody2.copyWith(
                color: textColor.withOpacity(.75),
              ),
            ),
            const VerticalGap5(),
            Text(
              rupiahFormatter.format(590000000),
              style: poppinsH5.copyWith(color: buttonColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardListSection(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: FutureBuilder(
        future: Repository().getCreditCard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load cards',
                style: poppinsBody2.copyWith(color: textColor),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No cards available',
                style: poppinsBody2.copyWith(color: textColor),
              ),
            );
          }

          return ListView.separated(
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const HorizontalGap10(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              String separatedNumber = separateNumber(data.cardNumber);
              String hiddenNumber = hideAndSeparateNumber(data.cardNumber);

              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: _buildCardDetailsModal(data),
                    ),
                  );
                },
                child: _buildCardItem(context, data, hiddenNumber),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCardItem(
      BuildContext context, dynamic data, String hiddenNumber) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.25,
      height: MediaQuery.of(context).size.height / 1.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: data.status == 1
                  ? buttonColor.withOpacity(.75)
                  : (data.status == 2 ? Colors.blue.shade900 : text2Color),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgChip),
                        ),
                      ),
                    ),
                    Text(
                      data.visa ? 'VISA' : 'GPN',
                      style: poppinsH2.copyWith(
                        color: data.visa ? buttonColor : textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  data.name,
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const VerticalGap5(),
                Text(
                  hiddenNumber,
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${data.balance}',
                      style: poppinsH3.copyWith(color: textColor),
                    ),
                    Text(
                      data.expirationDate,
                      style: poppinsBody2.copyWith(color: textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetailsModal(dynamic data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 10,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: buttonColor,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardDetailItem('Cardholder Name', data.name),
              _buildCardDetailItem('Card Number', data.cardNumber),
              _buildCardDetailItem('Expired Date', data.expirationDate),
              _buildCardDetailItem('CVV', data.cv),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: buttonColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.close_rounded, color: text2Color),
                  Text('Close', style: poppinsBody1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: poppinsBody2.copyWith(color: textColor),
        ),
        const VerticalGap5(),
        Text(
          value,
          style: poppinsH4.copyWith(color: textColor),
        ),
        Divider(
          color: textColor.withOpacity(0.5),
          thickness: 1,
        ),
        const VerticalGap5(),
      ],
    );
  }
}

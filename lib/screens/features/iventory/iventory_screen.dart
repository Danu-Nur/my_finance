import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/data/repository/repository.dart';
import 'package:my_finance/screens/widgets/dynamic_F_A_B.dart';
import 'package:my_finance/screens/features/data_master/data_master_screen.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

class IventoryScreen extends StatefulWidget {
  const IventoryScreen({super.key});

  @override
  State<IventoryScreen> createState() => _IventoryScreenState();
}

class _IventoryScreenState extends State<IventoryScreen> {
  Color fabColor = Colors.green;
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
              headerSection(),
              const VerticalGap10(),
              transactionSection(),
            ],
          ),
        ),
        floatingActionButton: DynamicFAB(
          addDataPage: DataMasterScreen(), // Halaman tujuan
          fabColor: fabColor, // Warna dinamis
        ),
      ),
    );
  }

  Expanded transactionSection() {
    return Expanded(
        child: FutureBuilder(
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
                                color: data[index].status == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              child: Icon(
                                data[index].status == false
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: textColor,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        const HorizontalGap20(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
    ));
  }

  Row headerSection() {
    return Row(
      children: [
        const Icon(
          Icons.inventory_2,
          size: 28,
          color: textColor,
        ),
        const HorizontalGap5(),
        Text(
          'Ivnentory',
          style: poppinsH1.copyWith(color: textColor),
        ),
      ],
    );
  }
}

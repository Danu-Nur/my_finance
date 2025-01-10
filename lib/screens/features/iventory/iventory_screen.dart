import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/data/repository/repository.dart';
import 'package:my_finance/screens/widgets/dynamic_F_A_B.dart';
import 'package:my_finance/screens/features/data_master/data_master_screen.dart';
import 'package:my_finance/screens/widgets/header_title.dart';
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
              HeaderTitle(icon: Icons.inventory_2, title: 'Iventory'),
              const VerticalGap10(),
              transactionSection(),
            ],
          ),
        ),
        floatingActionButton: DynamicFAB(
          addDataPage: DataMasterScreen(), // Halaman tujuan
          fabColor: fabColor.withOpacity(.4), // Warna dinamis
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
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
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
                          // const HorizontalGap20(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                          const HorizontalGap20(),
                          const HorizontalGap20(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '9',
                                    style: poppinsH1.copyWith(
                                      color: textColor.withOpacity(.75),
                                    ),
                                  ),
                                ],
                              ),
                              const HorizontalGap20(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 27,
                                    height: 27,
                                    child: Icon(
                                      Icons.add,
                                      color: textColor,
                                      size: 25,
                                    ),
                                  ),
                                  const VerticalGap5(),
                                  Container(
                                    width: 27,
                                    height: 2,
                                    color: secondaryColor,
                                  ),
                                  const VerticalGap5(),
                                  SizedBox(
                                    width: 27,
                                    height: 27,
                                    child: Icon(
                                      Icons.remove,
                                      color: textColor,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // const HorizontalGap10(),
                        ],
                      ),
                    ),
                    const VerticalGap10(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: secondaryColor,
                    )
                  ],
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
    );
  }
}

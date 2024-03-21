// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/models/response_models/payment_page_model.dart';
import 'package:room_rental/screens/create_bill.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/payment_card.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  ApplicationBloc? _bloc;

  bool activeWater = false;
  bool activeRent = false;
  bool activeService = false;
  bool activeElectricity = false;

  @override
  void initState() {
    super.initState();
    _bloc = ApplicationBloc();
    _bloc!.add(GetPaymentPageBillsEvent());
  }

  @override
  void dispose() {
    _bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payments",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
        leading: const Icon(
          Icons.payments_rounded,
          color: BrandingColors.primaryColor,
        ),
      ),
      body: BlocBuilder<ApplicationBloc, ApplicationState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is GetBillsFailed) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is GetBillsDonetInit) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetBillsDone) {
            BillStatus? rentData = state.responseData.rent!;
            BillStatus? electricityData = state.responseData.electricity!;
            BillStatus? serviceData = state.responseData.service!;
            BillStatus? waterData = state.responseData.water!;

            return ListView(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              children: <Widget>[
                PaymentCard(
                  title: "Rent",
                  amount: "23",
                  taxAmount: "23",
                  isActive: activeRent,
                  onTap: () {
                    setState(() {
                      if (activeRent == true) {
                        activeRent = false;
                      } else {
                        activeRent = true;
                      }
                    });
                  },
                  onBtnTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.createBill,
                      arguments: const CreateBillPage(billType: "house_rent"),
                    );
                  },
                ),
                ConstantWidgets.labelSizedBox(context),
                PaymentCard(
                  title: "Electricity",
                  amount: "23",
                  taxAmount: "23",
                  isActive: activeElectricity,
                  onTap: () {
                    setState(() {
                      if (activeElectricity == true) {
                        activeElectricity = false;
                      } else {
                        activeElectricity = true;
                      }
                    });
                  },
                ),
                ConstantWidgets.labelSizedBox(context),
                PaymentCard(
                  title: "Service",
                  amount: "23",
                  taxAmount: "23",
                  isActive: activeService,
                  onTap: () {
                    setState(() {
                      if (activeService == true) {
                        activeService = false;
                      } else {
                        activeService = true;
                      }
                    });
                  },
                ),
                ConstantWidgets.labelSizedBox(context),
                PaymentCard(
                  title: "Water",
                  amount: "23",
                  taxAmount: "23",
                  isActive: activeWater,
                  onTap: () {
                    setState(() {
                      if (activeWater == true) {
                        activeWater = false;
                      } else {
                        activeWater = true;
                      }
                    });
                  },
                  onBtnTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.createBill,
                      arguments: const CreateBillPage(billType: "water"),
                    );
                  },
                ),
                ConstantWidgets.gapSizedBox(context),
              ],
            );
          } else {
            return const Center(
              child: Text("Something is wrong!"),
            );
          }
        },
      ),
    );
  }

  Widget getStatusIcon(adminVerifiedStatus) => (adminVerifiedStatus == true)
      ? const Icon(
          Icons.verified,
          color: BrandingColors.primaryColor,
        )
      : const Icon(
          Icons.error,
          color: BrandingColors.danger,
        );
}

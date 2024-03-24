// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/models/response_models/payment_page_model.dart';
import 'package:room_rental/screens/bill_detail_page.dart';
import 'package:room_rental/screens/create_bill.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/month_dropdown.dart';
import 'package:room_rental/widgets/payment_card.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  ApplicationBloc? _bloc;
  String? selectedMonth;
  bool activeWater = false;
  bool activeRent = false;
  bool activeService = false;
  bool activeElectricity = false;

  @override
  void initState() {
    super.initState();
    _bloc = ApplicationBloc();
    selectedMonth = getCurrentMonth();
    _bloc!.add(GetPaymentPageBillsEvent(month: selectedMonth));
  }

  @override
  void dispose() {
    _bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MonthDropdown(
              selectedMonth: selectedMonth,
              size: size,
              height: size.height / 20,
              width: size.width / 4,
              onChanged: (val) {
                setState(() {
                  selectedMonth = val;
                });
                _bloc!.add(GetPaymentPageBillsEvent(month: val!.toLowerCase()));
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ApplicationBloc, ApplicationState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is GetBillsFailed) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is GetBillsInit) {
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
                  amount: rentData.total_amount,
                  taxAmount: rentData.total_tax,
                  isActive: activeRent,
                  isAdminVerified: rentData.admin_verified_status,
                  leftPropertiesCount:
                      rentData.not_gen_properties!.length.toString(),
                  onTap: () {
                    if (rentData.admin_verified_status == null) {
                      setState(() {
                        if (activeRent == true) {
                          activeRent = false;
                        } else {
                          activeRent = true;
                        }
                      });
                    } else {
                      Navigator.pushNamed(
                        context,
                        Routes.createBill,
                        arguments: CreateBillPage(
                          billType: "house_rent",
                          month: selectedMonth,
                          notGenProperties: rentData.not_gen_properties,
                        ),
                      ).then((value) {
                        _bloc!.add(GetPaymentPageBillsEvent());
                      });
                    }
                  },
                  onBtnTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.createBill,
                      arguments: CreateBillPage(
                        billType: "house_rent",
                        month: selectedMonth,
                        notGenProperties: rentData.not_gen_properties,
                      ),
                    ).then((value) {
                      _bloc!.add(GetPaymentPageBillsEvent());
                    });
                  },
                ),
                ConstantWidgets.labelSizedBox(context),
                PaymentCard(
                  title: "Electricity",
                  amount: electricityData.total_amount,
                  taxAmount: electricityData.total_tax,
                  isActive: activeElectricity,
                  leftPropertiesCount:
                      electricityData.not_gen_properties!.length.toString(),
                  isAdminVerified: electricityData.admin_verified_status,
                  onTap: () {
                    if (electricityData.admin_verified_status == true &&
                        electricityData.not_gen_properties!.isEmpty) {
                      setState(() {
                        if (activeElectricity == true) {
                          activeElectricity = false;
                        } else {
                          activeElectricity = true;
                        }
                      });
                    } else {
                      Navigator.pushNamed(
                        context,
                        Routes.createBill,
                        arguments: CreateBillPage(
                          billType: "electricity",
                          month: selectedMonth,
                          notGenProperties: electricityData.not_gen_properties,
                        ),
                      ).then((value) {
                        _bloc!.add(GetPaymentPageBillsEvent());
                      });
                    }
                  },
                  onBtnTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.billDetailPage,
                      arguments: BillDetailPage(
                        bills: electricityData.objs,
                        billType: "Electricity",
                      ),
                    ).then((value) {
                      _bloc!.add(GetPaymentPageBillsEvent());
                    });
                  },
                ),
                ConstantWidgets.labelSizedBox(context),
                PaymentCard(
                  title: "Service",
                  amount: serviceData.total_amount,
                  taxAmount: serviceData.total_tax,
                  isActive: activeService,
                  isAdminVerified: serviceData.admin_verified_status,
                  leftPropertiesCount: null,
                  onTap: () {
                    if (serviceData.total_amount != null) {
                      setState(() {
                        if (activeService == true) {
                          activeService = false;
                        } else {
                          activeService = true;
                        }
                      });
                    }
                    // }
                    // else {
                    // Navigator.pushNamed(
                    //   context,
                    //   Routes.createBill,
                    //   arguments: CreateBillPage(
                    //     billType: "service",
                    //     month: selectedMonth,
                    //     notGenProperties: serviceData.not_gen_properties,
                    //   ),
                    // ).then((value) {
                    //   _bloc!.add(GetPaymentPageBillsEvent());
                    // });
                    // }
                  },
                  onBtnTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.createBill,
                      arguments: CreateBillPage(
                        billType: "service",
                        month: selectedMonth,
                        notGenProperties: serviceData.not_gen_properties,
                      ),
                    ).then((value) {
                      _bloc!.add(GetPaymentPageBillsEvent());
                    });
                  },
                ),
                ConstantWidgets.labelSizedBox(context),
                PaymentCard(
                  title: "Water",
                  amount: waterData.total_amount,
                  taxAmount: waterData.total_tax,
                  isActive: activeWater,
                  isAdminVerified: waterData.admin_verified_status,
                  leftPropertiesCount:
                      waterData.not_gen_properties!.length.toString(),
                  onTap: () {
                    if (waterData.admin_verified_status == true &&
                        waterData.not_gen_properties!.isEmpty) {
                      setState(() {
                        if (activeWater == true) {
                          activeWater = false;
                        } else {
                          activeWater = true;
                        }
                      });
                    } else {
                      Navigator.pushNamed(
                        context,
                        Routes.createBill,
                        arguments: CreateBillPage(
                          billType: "water",
                          month: selectedMonth,
                          notGenProperties: waterData.not_gen_properties,
                        ),
                      ).then((value) {
                        _bloc!.add(GetPaymentPageBillsEvent());
                      });
                    }
                  },
                  onBtnTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.billDetailPage,
                      arguments: BillDetailPage(
                        bills: waterData.objs,
                        billType: "water",
                      ),
                    ).then((value) {
                      _bloc!.add(GetPaymentPageBillsEvent());
                    });
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

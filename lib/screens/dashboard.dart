// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/models/response_models/dashboard_chart_data.dart';
import 'package:room_rental/models/response_models/payment_page_model.dart';
import 'package:room_rental/models/response_models/property_model.dart';
import 'package:room_rental/models/response_models/rooms_data_model.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/service/api_service/api_urls.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/month_dropdown.dart';
import 'package:room_rental/widgets/property_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ApplicationBloc? _bloc1;
  ApplicationBloc? _bloc2;
  ApplicationBloc? _bloc3;
  List<_ChartData>? data;
  final PageController _propertyPageController = PageController();
  String? checkedLabel;
  String? selectedMonth;
  int selectedIndex = 0;
  String? selectedLabel;
  String selectedLabelPrice = "50";
  bool isZoomed = false;
  int currentPropertyIndex = 0;
  int propertysCount = 2;
  List<_ChartData>? chartData;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMonth = getCurrentMonth();
      selectedLabel = "OverAll";
    });
    _bloc1 = ApplicationBloc();
    _bloc2 = ApplicationBloc();
    _bloc3 = ApplicationBloc();
    _bloc1!.add(GetPaymentPageBillsEvent(month: selectedMonth));
    _bloc2!.add(GetChartDataEvent(month: selectedMonth!));
    _bloc3!.add(GetPropertiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Maran!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: BrandingColors.titleColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              "Please find your latest bill here!",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: BrandingColors.subtitleColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.translate_outlined,
              color: BrandingColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.languagesPage);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_sharp,
                color: BrandingColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.notificationsPage);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          // Payment indication
          ConstantWidgets.gapSizedBox(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Upload Documents",
                style: ConstantStyles.bodyTitleStyle(context),
              ),
              InkWell(
                child: Text(
                  "View all",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: BrandingColors.bodySmall,
                        decoration: TextDecoration.underline,
                      ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.indexPage,
                    arguments: const IndexingPage(selectedIndex: 1),
                  );
                },
              ),
            ],
          ),
          BlocBuilder<ApplicationBloc, ApplicationState>(
            bloc: _bloc1,
            builder: (context, state) {
              if (state is GetBillsInit) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetBillsDone) {
                return HorizontalCardListView(
                  month: selectedMonth!,
                  responseData: state.responseData,
                );
              } else {
                return const Center(child: Text("Something is wrong!"));
              }
            },
          ),
          ConstantWidgets.gapSizedBox(context),

          // Dashboard Chart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Dashboard",
                style: ConstantStyles.bodyTitleStyle(context),
              ),
              MonthDropdown(
                size: size,
                selectedMonth: selectedMonth,
                height: size.height / 20,
                width: size.width / 4,
                onChanged: (val) {
                  setState(() {
                    selectedMonth = val;
                  });
                  _bloc2!.add(GetChartDataEvent(month: selectedMonth!));
                  _bloc1!.add(GetPaymentPageBillsEvent(month: selectedMonth));
                },
              ),
            ],
          ),
          BlocBuilder<ApplicationBloc, ApplicationState>(
            bloc: _bloc2,
            builder: (context, state) {
              if (state is GetChartDataFailedState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              if (state is GetChartDataDoneState) {
                DashboardChartData data = state.responseData;
                List<_ChartData> source = [
                  _ChartData('Electricity', data.electricity, Colors.green),
                  _ChartData('Service', data.service, Colors.red),
                  _ChartData('Water', data.water, Colors.blue),
                  _ChartData('Rent', data.rent, Colors.yellow),
                ];
                double total =
                    data.electricity + data.service + data.water + data.rent;
                selectedLabelPrice = total.toString();
                return SfCircularChart(
                  enableMultiSelection: false,
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  margin: const EdgeInsets.all(0),
                  palette: const [
                    BrandingColors.donutChartPink,
                    BrandingColors.donutChartYellow,
                    BrandingColors.donutChartBlue,
                    BrandingColors.donutChartGreen,
                  ],
                  series: <CircularSeries<_ChartData, String>>[
                    DoughnutSeries<_ChartData, String>(
                      innerRadius: "60%",
                      dataSource: source,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      dataLabelMapper: (_ChartData data, _) => data.x,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: false,
                      ),
                      legendIconType: LegendIconType.circle,
                      enableTooltip: false,
                      onPointTap: (pointInteractionDetails) {
                        _ChartData chartData = source
                            .elementAt(pointInteractionDetails.pointIndex!);
                        setState(() {
                          selectedIndex = pointInteractionDetails.pointIndex!;
                          selectedLabel = chartData.x;
                          selectedLabelPrice = chartData.y.toString();
                        });
                      },
                    )
                  ],
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      angle: 20,
                      radius: "1%",
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "HK\$ $selectedLabelPrice",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            selectedLabel!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          ConstantWidgets.gapSizedBox(context),

          // My Stay
          Text(
            "My Stay",
            style: ConstantStyles.bodyTitleStyle(context),
          ),
          ConstantWidgets.labelSizedBox(context),
          BlocBuilder<ApplicationBloc, ApplicationState>(
            bloc: _bloc3,
            builder: (context, state) {
              if (state is GetPropertiesFailed) {
                return const Center(child: Text("Something is wrong!"));
              }
              if (state is GetPropertiesSuccess) {
                return propertiesList(state.response..response_data);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget propertiesList(TenantRentalRecordList response) {
    int? itemsCount = response.response_data!.length;
    String apiBaseUrl = ApiUrls.domain;
    return Column(
      children: [
        SizedBox(
          height: context.deviceHeight * 0.5,
          child: PageView.builder(
            controller: _propertyPageController,
            scrollDirection: Axis.horizontal,
            itemCount: itemsCount,
            onPageChanged: (index) {
              setState(() {
                currentPropertyIndex = index;
              });
            },
            itemBuilder: (context, page) {
              PropertyModel singlePropertyModel =
                  response.response_data!.elementAt(page).property!;
              List<TenantRoomDataModel?>? roomDataModel =
                  response.response_data!.elementAt(page).room;
              List<String> roomNames = roomDataModel
                      ?.map((room) => room?.room_name ?? '')
                      .toList() ??
                  [];

              String decodedText =
                  utf8.decode(singlePropertyModel.address!.runes.toList());

              String cleanedAddress =
                  decodedText.replaceAll(RegExp(r'[^\w\s]'), '');

              return PropertyCard(
                propertyImageUrl:
                    apiBaseUrl + singlePropertyModel.images!.first!.image!,
                flatNo: roomNames.join(", "),
                address: cleanedAddress,
              );
            },
          ),
        ),
        ConstantWidgets.gapSizedBox(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _propertyPageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
                setState(() {
                  selectedIndex = _propertyPageController.page!.toInt();
                });
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: BrandingColors.primaryColor,
              ),
            ),
            Row(
              children: List.generate(
                itemsCount,
                (index) => Container(
                  height: context.deviceHeight * 0.025,
                  width: context.deviceWidth * 0.04,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: (currentPropertyIndex == index)
                        ? BrandingColors.primaryColor
                        : BrandingColors.containerBorderColor,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _propertyPageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
                setState(() {
                  selectedIndex = _propertyPageController.page!.toInt();
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: BrandingColors.primaryColor,
              ),
            ),
          ],
        ),
        ConstantWidgets.gapSizedBox(context),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class HorizontalCardListView extends StatelessWidget {
  final String month;
  final PaymentPageModel responseData;
  const HorizontalCardListView({
    Key? key,
    required this.month,
    required this.responseData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.12,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (responseData.rent!.paid_status != true)
            DashboardPaymentCard(
              month: month,
              text: "Rent",
            ),
          if (responseData.electricity!.paid_status != true)
            DashboardPaymentCard(
              month: month,
              text: "Electricity",
            ),
          if (responseData.service!.paid_status != true)
            DashboardPaymentCard(
              month: month,
              text: "Service",
            ),
          if (responseData.water!.paid_status != true)
            DashboardPaymentCard(
              month: month,
              text: "Water",
            ),
        ],
      ),
    );
  }
}

class DashboardPaymentCard extends StatelessWidget {
  const DashboardPaymentCard({
    Key? key,
    required this.month,
    required this.text,
  }) : super(key: key);

  final String month;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.indexPage,
          arguments: const IndexingPage(
            selectedIndex: 1,
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: BrandingColors.containerBorderColor),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                color: Colors.white,
                child: Center(
                  child: Text(
                    text,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: const BoxDecoration(
                  color: BrandingColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    month,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

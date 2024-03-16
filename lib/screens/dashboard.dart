import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/models/response_models/property_model.dart';
import 'package:room_rental/models/response_models/rooms_data_model.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/service/api_service/api_urls.dart';
import 'package:room_rental/utils/constants/constant_values.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/month_dropdown.dart';
import 'package:room_rental/widgets/property_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/styles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMonth = "Feb";
      selectedLabel = "OverAll";
      selectedLabelPrice = "40";
    });

    context.read<ApplicationBloc>().add(GetPropertiesEvent());
  }

  List<_ChartData> _getData() {
    return <_ChartData>[
      _ChartData('Electricity', 20, Colors.green),
      _ChartData('Service', 30, Colors.red),
      _ChartData('Water', 25, Colors.blue),
      _ChartData('Rent', 15, Colors.yellow),
    ];
  }

  _ChartData _getChartData(int index) {
    List<_ChartData> chartData = _getData();
    return chartData.elementAt(index);
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
          const HorizontalCardListView(),
          ConstantWidgets.gapSizedBox(context),
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
              ),
            ],
          ),
          SfCircularChart(
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
                dataSource: _getData(),
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                dataLabelMapper: (_ChartData data, _) => data.x,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
                legendIconType: LegendIconType.circle,
                enableTooltip: false,
                onPointTap: (pointInteractionDetails) {
                  _ChartData chartData =
                      _getChartData(pointInteractionDetails.pointIndex!);
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
          ),
          ConstantWidgets.gapSizedBox(context),
          Text(
            "My Stay",
            style: ConstantStyles.bodyTitleStyle(context),
          ),
          ConstantWidgets.labelSizedBox(context),
          BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, state) {
              if (state is GetPropertiesSuccess) {
                return propertiesList(state.response..response_data);
              } else {
                return const Center(child: Text("Something is wrong!"));
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
  const HorizontalCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ConstantValues.billTypes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
                  const BorderSide(color: BrandingColors.containerBorderColor),
            ),
            child: SizedBox(
              width: context.deviceWidth / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: context.deviceHeight * 0.06,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        ConstantValues.billTypes.elementAt(index),
                      ),
                    ),
                  ),
                  Container(
                    height: context.deviceHeight * 0.04,
                    decoration: const BoxDecoration(
                      color: BrandingColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "June",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

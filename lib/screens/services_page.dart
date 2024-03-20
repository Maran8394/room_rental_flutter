import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/models/response_models/service_request_model.dart';
import 'package:room_rental/screens/edit_service_request.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/utils/enums/service_request_status.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/month_dropdown.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:room_rental/widgets/service_request_card.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  ApplicationBloc? _bloc;
  ProgressDialog? _dialog;
  final TextEditingController _reasonController = TextEditingController();

  List<String> toCancel = [
    ServiceRequestStatus.requested.name,
    ServiceRequestStatus.request_accepted.name,
  ];

  List<String> markToComplete = [
    ServiceRequestStatus.request_accepted.name,
    ServiceRequestStatus.on_progress.name,
  ];

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
    _bloc = ApplicationBloc();
    _bloc!.add(GetServiceRequests());
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
        leading: const Icon(
          Icons.construction_rounded,
          color: BrandingColors.primaryColor,
        ),
        title: Text(
          "Services",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MonthDropdown(
              selectedMonth: getCurrentMonth(),
              size: size,
              height: size.height / 20,
              width: size.width / 4,
              onChanged: (val) {
                _bloc!.add(GetServiceRequests(month: val));
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc!.add(GetServiceRequests());
        },
        child: BlocConsumer<ApplicationBloc, ApplicationState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ChangeServiceRequestStatusInit) {
              _dialog!.showAlertDialog(BrandingColors.backgroundColor);
            }
            if (state is ChangeServiceRequestStatusDone) {
              _dialog!.dimissDialog();
              _bloc!.add(GetServiceRequests());
            }
            if (state is GetServiceRequestInit) {
              _dialog!.showAlertDialog(BrandingColors.backgroundColor);
            }
            if (state is GetServiceRequestFailed) {
              _dialog!.dimissDialog();
              ConstantWidgets.showAlert(
                context,
                state.errorMessage,
                StateType.error,
              );
            }
            if (state is ChangeServiceRequestStatusFailed) {
              _dialog!.dimissDialog();
              ConstantWidgets.showAlert(
                context,
                state.errorMessage,
                StateType.error,
              );
            }
            if (state is GetServiceRequestDone) {
              _dialog!.dimissDialog();
            }
          },
          builder: (context, state) {
            if (state is GetServiceRequestDone) {
              return serviceRequestTile(state);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: context.deviceWidth * 0.80,
        height: context.buttonHeight,
        child: FloatingActionButton.small(
          elevation: 0,
          backgroundColor: BrandingColors.primaryColor,
          child: Text(
            "RAISE NEW REQUEST",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.createNewRequestPage,
            ).then((value) => _bloc!.add(GetServiceRequests()));
          },
        ),
      ),
    );
  }

  Widget serviceRequestTile(GetServiceRequestDone state) => ListView(
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 10,
          left: 10,
          right: 10,
        ),
        children: [
          for (var data in state.responseData.data) ...[
            Text(
              data.month!,
              style: ConstantStyles.bodyTitleStyle(context),
            ),
            ConstantWidgets.labelSizedBox(context),
            for (var serviceRequestData in data.objects!) ...[
              ServiceRequestCard(
                title: serviceRequestData.service_type!,
                priority: serviceRequestData.priority!,
                description: serviceRequestData.description!,
                requestStatus: serviceRequestData.request_status!,
                onTap: () {
                  showBottomSheet(serviceRequestData);
                },
              ),
            ],
          ]
        ],
      );

  void showBottomSheet(ServiceRequestModel modelData) {
    showModalBottomSheet<void>(
      backgroundColor: BrandingColors.cardBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          height: context.deviceHeight * 0.21,
          width: context.deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 3,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 100.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: BrandingColors.listTileTitleColor,
                ),
              ),
              if (modelData.request_status.toString() != "requested")
                ListTile(
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  dense: true,
                  leading: const Icon(
                    Icons.visibility,
                    color: BrandingColors.primaryColor,
                  ),
                  title: Text(
                    "View",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      Routes.editServiceRequest,
                      arguments: EditServiceRequest(
                        data: modelData,
                        readOnly: true,
                      ),
                    );
                  },
                ),
              if (modelData.request_status.toString() == "requested")
                ListTile(
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  dense: true,
                  leading: const Icon(
                    Icons.edit,
                    color: BrandingColors.primaryColor,
                  ),
                  title: Text(
                    "Edit",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      Routes.editServiceRequest,
                      arguments: EditServiceRequest(data: modelData),
                    );
                  },
                ),
              if (markToComplete.contains(modelData.request_status.toString()))
                ListTile(
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  dense: true,
                  leading: const Icon(
                    Icons.check_circle,
                    color: BrandingColors.primaryColor,
                  ),
                  title: Text(
                    "Mark as resolved",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await confirmationDialog(
                      "mark as resolved",
                      ServiceRequestStatus.completed,
                      modelData.id.toString(),
                    );
                  },
                ),
              if (toCancel.contains(modelData.request_status.toString()))
                ListTile(
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  dense: true,
                  leading: const Icon(
                    Icons.cancel,
                    color: BrandingColors.danger,
                  ),
                  title: Text(
                    "Cancel Request",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await confirmationDialog(
                      "cancel",
                      ServiceRequestStatus.cancelled,
                      modelData.id.toString(),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> confirmationDialog(
    String status,
    ServiceRequestStatus statusEnum,
    String objectId,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            "Do you want ${status.toLowerCase()} this request?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: (statusEnum == ServiceRequestStatus.cancelled)
              ? SizedBox(
                  height: context.deviceHeight * 0.1,
                  child: Column(
                    children: [
                      InputWidget(
                        maxLines: 2,
                        controller: _reasonController,
                        hintText: "Reason",
                      ),
                    ],
                  ),
                )
              : null,
          actionsPadding: const EdgeInsets.only(top: 0, bottom: 10),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                if (statusEnum == ServiceRequestStatus.completed) {
                  _bloc!.add(
                    ChangeServiceRequestStatusEvent(
                      objectId: objectId,
                      requestData: {
                        "request_status": "completed",
                      },
                    ),
                  );
                }
                if (statusEnum == ServiceRequestStatus.cancelled) {
                  _bloc!.add(
                    ChangeServiceRequestStatusEvent(
                      objectId: objectId,
                      requestData: {
                        "request_status": "cancelled",
                        "cancelled_reason": _reasonController.text.trim(),
                      },
                    ),
                  );
                }
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

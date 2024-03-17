// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/blocs/cubits/select_room/select_room_cubit.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/models/response_models/rooms_data_model.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/screens/camera_page.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/dropdown_widget.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/month_dropdown.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class CreateBillPage extends StatefulWidget {
  final String billType;
  final String? capturedCameraImage;

  const CreateBillPage({
    Key? key,
    required this.billType,
    this.capturedCameraImage,
  }) : super(key: key);

  @override
  State<CreateBillPage> createState() => _CreateBillPageState();
}

class _CreateBillPageState extends State<CreateBillPage> {
  final _formKey = GlobalKey<FormState>();
  ApplicationBloc? _bloc;
  final TextEditingController month = TextEditingController();
  final TextEditingController billNumber = TextEditingController();
  final TextEditingController units = TextEditingController();
  final TextEditingController remarks = TextEditingController();
  final Map<int, TenantRentalRecord> propertiesData = {};
  final Map<int, String> roomsList = {};
  ProgressDialog? dialog;

  TenantRentalRecord? selectedProperty;
  TenantRoomDataModel? selectedRoom;

  List<String> allowedExtension = ["png", "jpeg", "jpg"];
  List<String> selectedFilePaths = [];
  bool canUpload = true;
  bool notUploaded = false;
  String? fileExtension;

  @override
  void initState() {
    super.initState();

    String currentMonthAbbreviation = DateFormat.MMM().format(DateTime.now());
    setState(() {
      month.text = currentMonthAbbreviation;
    });
    _bloc = ApplicationBloc();
    _bloc!.add(GetPropertiesEvent());
    dialog = ProgressDialog(context);
  }

  @override
  void dispose() {
    _bloc!.close();
    month.dispose();
    billNumber.dispose();
    units.dispose();
    remarks.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Upload Documents",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: BrandingColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: MonthDropdown(
              height: size.height / 20,
              width: size.width / 4,
              size: size,
              selectedMonth: month.text,
              onChanged: (val) {
                setState(() {
                  month.text = val!;
                });
              },
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => SelectRoomCubit(),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              // Property
              const RequiredInputLabel(
                label: "Property",
                isRequired: true,
              ),
              ConstantWidgets.labelSizedBox(context),
              BlocBuilder<ApplicationBloc, ApplicationState>(
                builder: (context, state) {
                  if (state is GetPropertiesSuccess) {
                    TenantRentalRecordList propertyModel = state.response;
                    List<String> propertiesNameList = propertyModel
                        .response_data!
                        .map((value) => value.property!.property_name!)
                        .toList();
                    for (var i = 0; i < propertiesNameList.length; i++) {
                      propertiesData[i] =
                          propertyModel.response_data!.elementAt(i);
                    }
                    selectedProperty = propertyModel.response_data!.first;
                    context.read<SelectRoomCubit>().getRooms(selectedProperty!);
                    return DropDownWidget(
                      menuWidth: context.deviceWidth * 0.94,
                      selectedValue: selectedProperty!.property!.property_name!,
                      dropDownItems: propertiesNameList,
                      onChanged: (value) {
                        int? selectedPropertyIndex =
                            propertiesNameList.indexOf(value!);
                        selectedProperty =
                            propertiesData[selectedPropertyIndex];
                        context
                            .read<SelectRoomCubit>()
                            .getRooms(selectedProperty!);
                      },
                    );
                  } else if (state is GetPropertiesFailed) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              // Rooms dropdown
              const RequiredInputLabel(
                label: "Rooms",
                isRequired: true,
              ),
              ConstantWidgets.labelSizedBox(context),
              BlocBuilder<SelectRoomCubit, SelectRoomState>(
                builder: (context, state) {
                  if (state is SelectRoomSuccessState) {
                    List<TenantRoomDataModel?>? roomListModel = state.roomData;
                    List<String> roomList =
                        roomListModel!.map((val) => val!.room_name!).toList();
                    selectedRoom = roomListModel.first!;
                    return DropDownWidget(
                      menuWidth: context.deviceWidth * 0.94,
                      selectedValue: roomList.first,
                      dropDownItems: roomList,
                      onChanged: (value) {
                        debugPrint(value);
                        int? selectedRoomIndex = roomList.indexOf(value!);
                        selectedRoom =
                            roomListModel.elementAt(selectedRoomIndex);
                      },
                    );
                  }
                  return const Center(child: Text("Something is wrong?"));
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              // Bill Number
              const RequiredInputLabel(
                label: "Bill Number",
                isRequired: true,
              ),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                controller: billNumber,
                validator: (dynamic value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              // Units
              const RequiredInputLabel(
                label: "Units",
                isRequired: true,
              ),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                controller: units,
                keyboardType: TextInputType.number,
                validator: (dynamic value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              ConstantWidgets.gapSizedBox(context),

              //Remarks

              const RequiredInputLabel(
                label: "Remarks",
                isRequired: false,
              ),
              ConstantWidgets.labelSizedBox(context),
              InputWidget(
                controller: remarks,
              ),
              ConstantWidgets.gapSizedBox(context),

              // upload doc
              const RequiredInputLabel(
                label: "Upload Reference Document",
                isRequired: true,
              ),
              ConstantWidgets.labelSizedBox(context),
              Visibility(
                visible: canUpload,
                child: GestureDetector(
                  onTap: () {
                    showUploadFile(context);
                  },
                  child: Container(
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: (!notUploaded)
                            ? BrandingColors.containerBorderColor
                            : Colors.red.shade800,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.black,
                            weight: 10,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Upload File",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !canUpload,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: BrandingColors.containerBorderColor,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (allowedExtension.contains(fileExtension)) ...[
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Image.file(
                                        File(selectedFilePaths.first),
                                        height: context.deviceHeight * 0.25,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0 - 2,
                                      top: 0,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedFilePaths.clear();
                                            canUpload = true;
                                            fileExtension = null;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: BrandingColors.danger,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ConstantWidgets.labelSizedBox(context),
                                Text(getFileName(selectedFilePaths.first))
                              ],
                            ),
                          ),
                        ] else ...[
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      AssetsPath.pdfSVGIcon,
                                      height: context.deviceHeight * 0.18,
                                      width: context.deviceHeight * 0.2,
                                    ),
                                  ),
                                  ConstantWidgets.labelSizedBox(context),
                                  if (selectedFilePaths.isNotEmpty)
                                    Text(getFileName(selectedFilePaths.first)),
                                ],
                              ),
                              Positioned(
                                top: context.deviceHeight * 0.01,
                                right: context.deviceWidth * 0.05,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedFilePaths.clear();
                                      canUpload = true;
                                      fileExtension = null;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    color: BrandingColors.danger,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              ConstantWidgets.gapSizedBox(context),
              BlocListener<ApplicationBloc, ApplicationState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is CreateBillInitState) {
                    dialog!.showAlertDialog(
                      BrandingColors.primaryColor,
                    );
                  } else if (state is CreateBillFiledState) {
                    dialog!.dimissDialog();
                    ConstantWidgets.showAlert(
                      context,
                      state.errorMessage,
                      StateType.error,
                    );
                  } else if (state is CreateBillSuccessState) {
                    dialog!.dimissDialog();

                    ConstantWidgets.showAlert(
                      context,
                      "Success",
                      StateType.success,
                    ).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: CustomTextButton(
                  text: "DONE",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> requestData = {
                        "month": month.text.toLowerCase(),
                        "bill_type": widget.billType,
                        "bill_number": billNumber.text,
                        "units": units.text,
                        "property": selectedProperty!.id,
                        "room": selectedRoom!.id,
                        "remarks": remarks.text,
                      };
                      _bloc!.add(
                        CreateBillEvent(
                          requestData: requestData,
                          imagePath: selectedFilePaths.first,
                        ),
                      );
                    } else {
                      setState(() {
                        notUploaded = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showUploadFile(BuildContext context) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          backgroundColor: Colors.white,
          elevation: 0,
          content: SizedBox(
            height: context.deviceHeight * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_upload_rounded,
                  color: Colors.blueAccent,
                  size: 35,
                ),
                SizedBox(height: context.gapHeight),

                // Browse Files button
                ElevatedButton(
                  style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      BrandingColors.backgroundColor,
                    ),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: BrandingColors.containerBorderColor,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Browse Files",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    var status = await Permission.storage.status;
                    if (status == PermissionStatus.granted) {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'png', 'jpg', "jpeg"],
                      );
                      if (result != null) {
                        List<String> paths =
                            result.paths.map((path) => path!).toList();
                        String filePath = paths.first;
                        String extension =
                            filePath.split('.').last.toLowerCase();
                        setState(() {
                          selectedFilePaths.addAll(paths);
                          canUpload = false;
                          fileExtension = extension;
                          notUploaded = false;
                        });
                        Navigator.pop(context);
                      }
                    } else {
                      ConstantWidgets.errorShowToaster(
                        context,
                        "Storage Access Required",
                      );
                      await Future.delayed(const Duration(seconds: 2));
                      await openAppSettings();
                    }
                  },
                ),

                // Take Picture  button
                ElevatedButton(
                  style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      BrandingColors.backgroundColor,
                    ),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: BrandingColors.containerBorderColor,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Take Picture",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    var status = await Permission.camera.status;

                    if (status == PermissionStatus.granted) {
                      await availableCameras().then(
                        (value) => Navigator.pushNamed(
                          context,
                          Routes.cameraPage,
                          arguments: CameraPage(
                            cameras: value,
                          ),
                        ).then((value) {
                          List<String> paths = [value.toString()];
                          String filePath = paths.first;
                          String extension =
                              filePath.split('.').last.toLowerCase();
                          setState(() {
                            selectedFilePaths.addAll(paths);
                            canUpload = false;
                            fileExtension = extension;
                          });
                          Navigator.pop(context);
                        }),
                      );
                    } else {
                      ConstantWidgets.errorShowToaster(
                        context,
                        "Camera Access Required",
                      );
                      await Future.delayed(const Duration(seconds: 2));
                      await openAppSettings();
                    }
                  },
                ),

                SizedBox(height: context.gapHeight),
                RichText(
                  text: TextSpan(
                    text: 'Supported File Types: ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'JPG, JPEG, PNG & PDF',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

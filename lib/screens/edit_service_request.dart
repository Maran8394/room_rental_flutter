// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/models/response_models/service_request_model.dart';
import 'package:room_rental/models/response_models/tenant_rental_record_model.dart';
import 'package:room_rental/screens/camera_page.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/service/api_service/api_urls.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/constant_values.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/utils/extensions/string_extenstions.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/dropdown_widget.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/progress_indicator.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class EditServiceRequest extends StatefulWidget {
  final ServiceRequestModel data;
  final bool? readOnly;
  const EditServiceRequest({
    Key? key,
    required this.data,
    this.readOnly,
  }) : super(key: key);

  @override
  State<EditServiceRequest> createState() => _EditServiceRequestState();
}

class _EditServiceRequestState extends State<EditServiceRequest> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog? dialog;
  ApplicationBloc? _bloc;

  String selectedRequestType = "Plumbing";
  String selectedCategory = "Repair";
  String selectedPriority = "Normal";
  final TextEditingController _descriptionController = TextEditingController();

  List<String> allowedExtension = ["png", "jpeg", "jpg"];
  List<String> selectedFilePaths = [];
  Map<String, int> selectedFilPathIds = {};
  List<String> removedImagesIds = [];
  bool canUpload = true;
  bool notUploaded = false;
  String? fileExtension;

  final Map<int, TenantRentalRecord> propertiesData = {};
  TenantRentalRecord? selectedProperty;

  @override
  void initState() {
    super.initState();
    setupPageData();
    dialog = ProgressDialog(context);
    _bloc = ApplicationBloc();
    _bloc!.add(GetPropertiesEvent());
  }

  @override
  void dispose() {
    _bloc!.close();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          (widget.readOnly == true) ? "Submited Request" : "Edit Request",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: BrandingColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            const RequiredInputLabel(
              label: "Property",
              isRequired: true,
            ),
            ConstantWidgets.labelSizedBox(context),
            BlocBuilder<ApplicationBloc, ApplicationState>(
              builder: (context, state) {
                if (state is GetPropertiesSuccess) {
                  TenantRentalRecordList propertyModel = state.response;
                  List<String> propertiesNameList = propertyModel.response_data!
                      .map((value) => value.property!.property_name!)
                      .toList();
                  for (var i = 0; i < propertiesNameList.length; i++) {
                    propertiesData[i] =
                        propertyModel.response_data!.elementAt(i);

                    int? objectId =
                        propertyModel.response_data!.elementAt(i).id;

                    if (objectId.toString() ==
                        widget.data.tenant_rental_record.toString()) {
                      selectedProperty =
                          propertyModel.response_data!.elementAt(i);
                    }
                  }

                  return DropDownWidget(
                    menuWidth: context.deviceWidth * 0.94,
                    selectedValue: selectedProperty!.property!.property_name!,
                    dropDownItems: propertiesNameList,
                    onChanged: widget.readOnly == true
                        ? null
                        : (value) {
                            int? selectedPropertyIndex =
                                propertiesNameList.indexOf(value!);
                            selectedProperty =
                                propertiesData[selectedPropertyIndex];
                          },
                  );
                } else if (state is GetPropertiesFailed) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            ConstantWidgets.gapSizedBox(context),

            // Request Type
            const RequiredInputLabel(label: "Type", isRequired: true),
            ConstantWidgets.labelSizedBox(context),
            DropDownWidget(
              selectedValue: selectedRequestType,
              dropDownItems: ConstantValues.serviceRequestTypes,
              onChanged: widget.readOnly == true
                  ? null
                  : (val) {
                      setState(() {
                        selectedRequestType = val!;
                      });
                    },
            ),
            ConstantWidgets.gapSizedBox(context),

            // Category
            const RequiredInputLabel(
              label: "Category",
              isRequired: true,
            ),
            ConstantWidgets.labelSizedBox(context),
            DropDownWidget(
              selectedValue: selectedCategory,
              dropDownItems: ConstantValues.serviceCategories,
              onChanged: widget.readOnly == true
                  ? null
                  : (val) {
                      setState(() {
                        selectedCategory = val!;
                      });
                    },
            ),
            ConstantWidgets.gapSizedBox(context),

            const RequiredInputLabel(
              label: "Priority",
              isRequired: true,
            ),
            ConstantWidgets.labelSizedBox(context),
            DropDownWidget(
              selectedValue: selectedPriority,
              dropDownItems: ConstantValues.priorities,
              onChanged: widget.readOnly == true
                  ? null
                  : (val) {
                      setState(() {
                        selectedPriority = val!;
                      });
                    },
            ),
            ConstantWidgets.gapSizedBox(context),

            // Description
            const RequiredInputLabel(label: "Description"),
            ConstantWidgets.labelSizedBox(context),
            InputWidget(
              maxLines: 3,
              controller: _descriptionController,
              readOnly: widget.readOnly,
            ),
            ConstantWidgets.gapSizedBox(context),
            const RequiredInputLabel(label: "Upload Reference Document"),
            ConstantWidgets.labelSizedBox(context),
            Visibility(
              visible: canUpload,
              child: GestureDetector(
                onTap: () {
                  showUploadFile(context);
                },
                child: Container(
                  height: context.deviceHeight * 0.06,
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 3.0,
                                  runSpacing: 3.0,
                                  children: [
                                    for (var i = 0;
                                        i < selectedFilePaths.length;
                                        i++) ...[
                                      imageCard(i),
                                      if (selectedFilePaths.length < 2)
                                        Center(
                                          child: IconButton.outlined(
                                            icon: const Icon(
                                              Icons.add,
                                            ),
                                            onPressed: () {
                                              showUploadFile(context);
                                            },
                                          ),
                                        )
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ConstantWidgets.gapSizedBox(context),
            BlocListener<ApplicationBloc, ApplicationState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is UpdateServiceRequestInit) {
                  dialog!.showAlertDialog(
                    BrandingColors.primaryColor,
                  );
                } else if (state is UpdateServiceRequestFailed) {
                  dialog!.dimissDialog();
                  ConstantWidgets.showAlert(
                    context,
                    state.errorMessage,
                    StateType.error,
                  );
                } else if (state is UpdateServiceRequestDone) {
                  dialog!.dimissDialog();

                  ConstantWidgets.showAlert(
                    context,
                    "Success",
                    StateType.success,
                  ).then((value) {
                    Navigator.popAndPushNamed(
                      context,
                      Routes.indexPage,
                      arguments: const IndexingPage(selectedIndex: 2),
                    );
                  });
                }
              },
              child: CustomTextButton(
                text: "DONE",
                isDisabled: widget.readOnly,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> requestData = {
                      "property": selectedProperty!.id.toString(),
                      "service_type": selectedRequestType,
                      "catergory": selectedCategory,
                      "priority": selectedPriority.toLowerCase(),
                      "description": _descriptionController.text.trim(),
                    };
                    final osFilePaths = selectedFilePaths
                        .where((item) => !_isImageFile(item))
                        .toList();
                    _bloc!.add(
                      UpdateServiceRequestEvent(
                        objectId: widget.data.id.toString(),
                        requestData: requestData,
                        images: osFilePaths.isNotEmpty ? osFilePaths : [],
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
                        allowMultiple: true,
                        type: FileType.image,
                      );
                      if (result != null) {
                        int allowedCount = 2 - selectedFilePaths.length;
                        if (result.count <= allowedCount) {
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
                        } else {
                          ConstantWidgets.errorShowToaster(
                            context,
                            "Max allowed files is $allowedCount",
                          );
                        }
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

  void setupPageData() {
    setState(() {
      selectedRequestType = widget.data.service_type!.titleCase;
      selectedCategory = widget.data.catergory!.titleCase;
      selectedPriority = widget.data.priority!.titleCase;
      var c =
          widget.data.files!.map((e) => "${ApiUrls.domain}${e.file}").toList();
      selectedFilePaths.addAll(c);
      canUpload = false;
      if (widget.data.description != null &&
          widget.data.description!.isNotEmpty) {
        _descriptionController.text = widget.data.description!;
      }
    });
  }

  bool _isImageFile(String filePath) {
    if (filePath.startsWith('http://') || filePath.startsWith('https://')) {
      return true;
    } else {
      return false;
    }
  }

  Widget imageCard(index) => Stack(
        children: [
          SizedBox(
            width: context.deviceWidth * 0.25,
            height: context.deviceHeight * 0.25,
            child: (getFileName(selectedFilePaths.elementAt(index)) != "pdf")
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _isImageFile(selectedFilePaths.elementAt(index))
                        ? Image.network(
                            selectedFilePaths.elementAt(index),
                            fit: BoxFit.contain,
                          )
                        : Image.file(
                            File(selectedFilePaths.elementAt(index)),
                            fit: BoxFit.contain,
                          ),
                  )
                : SvgPicture.asset(
                    AssetsPath.pdfSVGIcon,
                    height: context.deviceHeight * 0.18,
                    width: context.deviceHeight * 0.2,
                  ),
          ),
          if (widget.readOnly != true)
            Positioned(
              right: 0,
              top: 0 - 2,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedFilePaths.removeAt(index);
                    if (selectedFilePaths.isEmpty) {
                      canUpload = true;
                    }
                    removedImagesIds.add(index.toString());
                  });
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            )
        ],
      );
}

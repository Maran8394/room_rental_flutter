// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/models/response_models/uploaded_image_model.dart';
import 'package:room_rental/screens/camera_page.dart';
import 'package:room_rental/service/api_service/api_urls.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/enums/state_type.dart';
import 'package:room_rental/widgets/chips_widets.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/progress_indicator.dart';

import 'required_input_label.dart';

class RentPropertyExpansionTile extends StatefulWidget {
  final bool? isPaid;
  final String objId;
  final String propertyName;
  final String amount;
  final String? tax;
  final List<UploadedFiles> uploadedBills;
  final String billApprovalStatus;
  const RentPropertyExpansionTile({
    Key? key,
    this.isPaid,
    required this.objId,
    required this.propertyName,
    required this.amount,
    this.tax,
    required this.uploadedBills,
    required this.billApprovalStatus,
  }) : super(key: key);

  @override
  State<RentPropertyExpansionTile> createState() =>
      _RentPropertyExpansionTileState();
}

class _RentPropertyExpansionTileState extends State<RentPropertyExpansionTile>
    with TickerProviderStateMixin {
  List<String> allowedExtension = ["png", "jpeg", "jpg"];
  List<String> selectedFilePaths = [];
  bool canUpload = true;
  bool notUploaded = false;
  String? fileExtension;
  ProgressDialog? _dialog;
  bool disbleBills = false;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
    setState(() {
      if (widget.uploadedBills.isNotEmpty) {
        selectedFilePaths =
            widget.uploadedBills.map((e) => ApiUrls.domain + e.file).toList();
        canUpload = false;
        disbleBills = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tax);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: ExpansionTile(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          collapsedShape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          title: Text(
            "Property : ${widget.propertyName}",
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Amount"),
                Text("HK\$ ${widget.amount}"),
              ],
            ),
            ConstantWidgets.gapSizedBox(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tax"),
                if (widget.tax != null) ...[
                  Text("HK\$ ${widget.tax}"),
                ] else ...[
                  const Text("HK\$ 0"),
                ],
              ],
            ),
            ConstantWidgets.gapSizedBox(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const RequiredInputLabel(
                  label: "Upload Bill",
                  isRequired: true,
                ),
                ConstantWidgets.gapWidthSizedBox(context),
                StatusChip(
                  status: widget.billApprovalStatus,
                )
              ],
            ),
            ConstantWidgets.labelSizedBox(context),
            Visibility(
              visible: canUpload,
              child: GestureDetector(
                onTap: () {
                  showUploadFile(context, "refDoc");
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
                  color: (disbleBills) ? Colors.grey.shade100 : Colors.white,
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
                                      if (selectedFilePaths.length < 2 &&
                                          !disbleBills)
                                        Center(
                                          child: IconButton.outlined(
                                            icon: const Icon(
                                              Icons.add,
                                            ),
                                            onPressed: () {
                                              if (!disbleBills) {
                                                showUploadFile(
                                                    context, "refDoc");
                                              }
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
              listener: (context, state) {
                if (state is UpdateBillInitState) {
                  _dialog!.showAlertDialog(BrandingColors.primaryColor);
                }
                if (state is UpdateBillDoneState) {
                  _dialog!.dimissDialog();
                  ConstantWidgets.showAlert(
                    context,
                    "Updated",
                    StateType.success,
                  ).then((value) => Navigator.pop(context));
                }
                if (state is UpdateBillFailedState) {
                  _dialog!.dimissDialog();
                  ConstantWidgets.showAlert(
                    context,
                    state.errorMessage,
                    StateType.error,
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  text: "Submit",
                  onPressed: () {
                    context.read<ApplicationBloc>().add(
                          UpdateBillEvent(
                              objectId: widget.objId,
                              requestData: {},
                              images: selectedFilePaths),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageCard(index) {
    return Stack(
      children: [
        SizedBox(
          width: context.deviceWidth * 0.25,
          height: context.deviceHeight * 0.25,
          child: (getFileName(selectedFilePaths.elementAt(index)) != "pdf")
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: isImageFile(selectedFilePaths.elementAt(index))
                      ? Image.network(
                          selectedFilePaths.elementAt(index),
                          fit: BoxFit.contain,
                          height: context.deviceHeight * 0.2,
                          opacity: (disbleBills)
                              ? AnimationController(vsync: this, value: 0.8)
                              : null,
                        )
                      : Image.file(
                          File(selectedFilePaths.elementAt(index)),
                          fit: BoxFit.contain,
                          height: context.deviceHeight * 0.2,
                        ),
                )
              : SvgPicture.asset(
                  AssetsPath.pdfSVGIcon,
                  height: context.deviceHeight * 0.18,
                  width: context.deviceHeight * 0.2,
                ),
        ),
        if (!disbleBills)
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

  Future<void> showUploadFile(BuildContext context, String fileType) async {
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
                        type: FileType.custom,
                        allowedExtensions: allowedExtension,
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
}

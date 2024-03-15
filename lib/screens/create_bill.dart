// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:room_rental/extensions/media_query_extensions.dart';
import 'package:room_rental/screens/camera_page.dart';
import 'package:room_rental/utils/constants/assets_path.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';
import 'package:room_rental/widgets/input_widget.dart';
import 'package:room_rental/widgets/month_dropdown.dart';
import 'package:room_rental/widgets/required_input_label.dart';

class CreateBillPage extends StatefulWidget {
  final String? capturedCameraImage;

  const CreateBillPage({
    Key? key,
    this.capturedCameraImage,
  }) : super(key: key);

  @override
  State<CreateBillPage> createState() => _CreateBillPageState();
}

class _CreateBillPageState extends State<CreateBillPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final TextEditingController month = TextEditingController();
  final TextEditingController billNumber = TextEditingController();
  final TextEditingController units = TextEditingController();
  final TextEditingController remarks = TextEditingController();

  List<String> allowedExtension = ["png", "jpeg", "jpg"];
  List<String> selectedFilePaths = [];
  bool canUpload = true;
  String? fileExtension;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    String currentMonthAbbreviation = DateFormat.MMM().format(DateTime.now());
    setState(() {
      month.text = currentMonthAbbreviation;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          const RequiredInputLabel(
            label: "Bill Number",
            isRequired: true,
          ),
          const SizedBox(height: 5),
          InputWidget(controller: billNumber),
          const SizedBox(height: 10),
          const RequiredInputLabel(
            label: "Units",
            isRequired: true,
          ),
          const SizedBox(height: 5),
          InputWidget(controller: units),
          const SizedBox(height: 10),
          const RequiredInputLabel(
            label: "Remarks",
            isRequired: true,
          ),
          SizedBox(height: context.labelGap),
          InputWidget(controller: remarks),
          SizedBox(height: size.height * 0.02),
          const RequiredInputLabel(
            label: "Upload Reference Document",
            isRequired: true,
          ),
          SizedBox(height: context.labelGap),
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
                    color: BrandingColors.containerBorderColor,
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
          const SizedBox(height: 50),
          const CustomTextButton(text: "DONE"),
        ],
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

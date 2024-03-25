// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:room_rental/models/response_models/bill_model.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/utils/extensions/string_extenstions.dart';
import 'package:room_rental/widgets/property_expansion_tile.dart';
import 'package:room_rental/widgets/rent_property_tile.dart';

class BillDetailPage extends StatefulWidget {
  final String billType;
  final List<BillModel>? bills;
  const BillDetailPage({
    Key? key,
    required this.billType,
    this.bills,
  }) : super(key: key);

  @override
  State<BillDetailPage> createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> {
  List<String> allowedExtension = ["png", "jpeg", "jpg"];
  List<String> propertAllowedType = ["house_rent", "service"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "${widget.billType.titleCase.replaceAll("_", " ")} Bills",
          style: ConstantStyles.bodyTitleStyle(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: List.generate(
          widget.bills!.length,
          (index) {
            BillModel data = widget.bills!.elementAt(index);

            if (!propertAllowedType.contains(widget.billType)) {
              return PropertyExpansionTile(
                isPaid: data.bill_status == "paid",
                objId: data.id.toString(),
                billNo: data.bill_number!,
                amount: data.amount!,
                tax: data.tax!,
                propertyName:
                    data.tenant_rental_record!.property!.property_name!,
                uploadedFiles: data.uploaded_reference_doc!,
                uploadedBills: data.upload_bill!,
                billApprovalStatus: data.bill_approval_status!,
              );
            } else {
              return RentPropertyExpansionTile(
                isPaid: data.bill_status == "paid",
                objId: data.id.toString(),
                amount: data.amount!,
                tax: data.tax!,
                propertyName:
                    data.tenant_rental_record!.property!.property_name!,
                uploadedBills: data.upload_bill!,
                billApprovalStatus: data.bill_approval_status!,
              );
            }
          },
        ),
      ),
    );
  }
}

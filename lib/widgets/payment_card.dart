// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:room_rental/extensions/media_query_extensions.dart';

import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';

class PaymentCard extends StatelessWidget {
  final Function()? onTap;
  final Function()? onBtnTap;
  final bool isActive;
  final String title;
  final String amount;
  final String taxAmount;

  const PaymentCard({
    Key? key,
    this.onTap,
    this.onBtnTap,
    required this.isActive,
    required this.title,
    required this.amount,
    required this.taxAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 100,
        ),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Text(
                      "HK\$ $amount",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Icon(
                      (isActive) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              if (isActive) ...[
                ConstantWidgets.gapSizedBox(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Tax",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Text(
                        "HK\$ $taxAmount",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    ],
                  ),
                ),
                ConstantWidgets.gapSizedBox(context),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: CustomTextButton(
                    text: "DOCUMENTS",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    onPressed: onBtnTap,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

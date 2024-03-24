// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/widgets/constant_widgets.dart';
import 'package:room_rental/widgets/custom_text_button.dart';

class PaymentCard extends StatelessWidget {
  final Function()? onTap;
  final Function()? onBtnTap;
  final bool isActive;
  final bool? isDisabled;
  final bool? isAdminVerified;
  final String title;
  final double? amount;
  final double? taxAmount;
  final String? leftPropertiesCount;

  const PaymentCard({
    Key? key,
    this.onTap,
    this.onBtnTap,
    required this.isActive,
    this.isDisabled,
    this.isAdminVerified,
    required this.title,
    required this.amount,
    required this.taxAmount,
    this.leftPropertiesCount,
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
          color: (isDisabled == true) ? Colors.grey.shade100 : Colors.white,
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
                    if (isAdminVerified == true) ...[
                      Text(
                        "HK\$ $amount",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Icon(
                        (isActive)
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ] else ...[
                      if (leftPropertiesCount != "0" &&
                          leftPropertiesCount != null) ...[
                        CircleAvatar(
                          radius: 13,
                          child: Text(
                            leftPropertiesCount.toString(),
                          ),
                        )
                      ] else if (leftPropertiesCount == null)
                        ...[]
                      else ...[
                        Icon(
                          Icons.hourglass_bottom_rounded,
                          color: Colors.amberAccent.shade700,
                        )
                      ],
                    ],
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

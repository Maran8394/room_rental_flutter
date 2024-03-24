// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/utils/extensions/string_extenstions.dart';

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({
    Key? key,
    required this.status,
  }) : super(key: key);

  Color getBackgroundColor(String status) {
    switch (status) {
      case "requested":
        return Colors.blue;
      case "request_accepted":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case "request_deleted":
        return Colors.grey;
      case "on_progress":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "waiting_for_approval":
        return Colors.orange;
      case "approved":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: getBackgroundColor(status),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
      ),
      child: Text(
        status.replaceAll('_', ' ').titleCase,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

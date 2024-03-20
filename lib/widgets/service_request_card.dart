// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/extensions/string_extenstions.dart';
import 'package:room_rental/widgets/chips_widets.dart';

class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({
    Key? key,
    this.onTap,
    required this.title,
    required this.priority,
    required this.description,
    required this.requestStatus,
  }) : super(key: key);
  final Function()? onTap;
  final String title;
  final String priority;
  final String description;
  final String requestStatus;

  IconData getIconForServiceRequestType(String type) {
    switch (type) {
      case "Plumbing":
        return Icons.plumbing;
      case "Electrical":
        return Icons.electrical_services;
      case "Appliance Repair":
        return Icons.home_repair_service;
      case "Flooring Repair":
        return Icons.home_repair_service;
      case "Window Repair":
        return Icons.window;
      case "Door Repair":
        return Icons.home_repair_service;
      case "Other":
        return Icons.build;
      default:
        return Icons.help; // Default icon if type is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: BrandingColors.cardBackgroundColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: Icon(
          getIconForServiceRequestType(title),
          color: Colors.black,
        ),
        isThreeLine: (description.isNotEmpty) ? true : false,
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              priority.titleCase,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            if (description.isNotEmpty)
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusChip(status: requestStatus),
            const SizedBox(width: 8),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: onTap,
              child: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

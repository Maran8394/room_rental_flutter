import 'package:flutter/material.dart';

class ChartLabelDenotor extends StatelessWidget {
  final String label;
  final Color color;
  const ChartLabelDenotor({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      visualDensity: VisualDensity.comfortable,
      leading: Icon(
        Icons.circle,
        size: 15,
        color: color,
      ),
      title: Text(label),
    );
  }
}

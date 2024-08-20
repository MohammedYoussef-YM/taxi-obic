import 'package:flutter/material.dart';

class RowDriverDetails extends StatelessWidget {
  final String title; // Define a parameter to accept the title
  final String details; // Define a parameter to accept the title

  const RowDriverDetails({
    super.key,
    required this.title, required this.details, // Make the title parameter required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 39.4, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
            child: SizedBox(
              width: 75,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFFE6E5E3),
                ),
              ),
            ),
          ),
          // Wrap the details Text in a Flexible widget
          Flexible(
            child: Text(details,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFFE6E5E3),
              ),
              overflow: TextOverflow.ellipsis,  // This will truncate the text if it overflows
              maxLines: 1,  // Optionally, limit the text to a single line
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
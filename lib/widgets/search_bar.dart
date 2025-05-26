import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(Icons.search, color: Colors.grey[400]),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search "Punjabi Lyrics"',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
          ),
          Icon(Icons.mic, color: Colors.grey[400]),
          const SizedBox(width: 10),
          // Account icon removed
        ],
      ),
    );
  }
}

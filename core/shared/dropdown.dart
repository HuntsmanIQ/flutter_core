import 'package:flutter/material.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.data,
    required this.action,
  });

  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final List<Map<String, dynamic>> data;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 9, 9, 9), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          value: selectedValue.isEmpty ? null : selectedValue,
          hint: Text(
            "Select $action",
            style: TextStyle(color: const Color.fromARGB(255, 9, 9, 9)),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 25, 24, 23)),
          isExpanded: true,
          items:
              data.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(
                    category['name'],
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
          
        ),
      ),
    );
  }
}

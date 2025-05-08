import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Pesquisar relatórios...',
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFF9CA3AF),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF9CA3AF),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
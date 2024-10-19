import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../presentation/presentation.dart';

class LimitedDropdown extends StatefulWidget {
  const LimitedDropdown({super.key});

  @override
  LimitedDropdownState createState() => LimitedDropdownState();
}

class LimitedDropdownState extends State<LimitedDropdown> {
  int? selectedValue = 5;
  final List<int> numbers = List<int>.generate(201, (int index) => index);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<int>(
        decoration: InputDecoration(
          hintText: '5 Mils',
          hintStyle: TextStyles.body0Semibold(color: Colors.grey.withOpacity(0.8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.sm),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.sm),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.sm),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
            top: Dimensions.xxxs,
            bottom: Dimensions.xxxs,
            left: Dimensions.xxs,
          ),
        ),
        style: TextStyles.calloutRegular(color: Colors.black),
        items: numbers.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        onChanged: (int? newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
      ),
    );
  }
}

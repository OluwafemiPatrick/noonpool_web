import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> items;
  final int selectedPosition;
  final Function(int) onUpdate;
  final Widget parent;
  final Widget Function(String) childBuilder;
  const DropDownWidget({
    Key? key,
    required this.items,
    required this.selectedPosition,
    required this.onUpdate,
    required this.parent,
    required this.childBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: parent,
        items: items
            .map((item) => DropdownMenuItem<String>(value: item, child: childBuilder(item)))
            .toList(),
        value: selectedPosition < 0 ? null : items[selectedPosition],
        onChanged: (value) {
          if (value != null) {
            onUpdate(items.indexOf(value.toString()));
          }
        },
        // itemPadding: const EdgeInsets.only(left: kDefaultPadding / 2, right: kDefaultPadding / 2),
        // dropdownMaxHeight: 200,
        // dropdownWidth: 200,
        // dropdownPadding: null,
        // dropdownDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        //   color: Colors.white,
        // ),
        // dropdownElevation: 8,
        // scrollbarRadius: const Radius.circular(40),
        // scrollbarThickness: 6,
        // scrollbarAlwaysShow: true,
        // offset: const Offset(-20, 0),
      ),
    );
  }
}

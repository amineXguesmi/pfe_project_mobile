import 'package:flutter/material.dart';

class MultiSelectDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemLabel; // A function to extract a label for display

  const MultiSelectDialog({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.itemLabel,
  });

  @override
  _MultiSelectDialogState<T> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Items'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(widget.itemLabel(item)),
              value: _selectedItems.contains(item),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedItems.add(item);
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedItems);
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}

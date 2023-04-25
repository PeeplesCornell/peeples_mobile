import 'package:flutter/material.dart';

class MultiSelectInput extends StatefulWidget {
  final String? response;
  final void Function(String?) updateResponseCallback;
  final List<String> options;
  const MultiSelectInput(
      {Key? key,
      this.response,
      required this.updateResponseCallback,
      required this.options})
      : super(key: key);

  @override
  _MultiSelectInputState createState() => _MultiSelectInputState();
}

class _MultiSelectInputState extends State<MultiSelectInput> {
  final TextEditingController searchController = TextEditingController();
  String _searchText = "";
  late final List<String> _selectedOptions =
      widget.response == null ? [] : widget.response!.split(",");

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {
        _searchText = searchController.text;
      });
    });
    super.initState();
  }

  void removeOption(option) {
    _selectedOptions.remove(option);
    widget.updateResponseCallback(_selectedOptions.join(","));
  }

  void addOption(option) {
    _selectedOptions.add(option);
    widget.updateResponseCallback(_selectedOptions.join(","));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> filteredOptions = widget.options
        .where((e) => e.toLowerCase().startsWith(_searchText.toLowerCase()))
        .map(
          (e) => FilterChip(
            label: Text(e),
            showCheckmark: false,
            selected: _selectedOptions.contains(e),
            onSelected: (isSelected) {
              if (isSelected) {
                addOption(e);
              } else {
                removeOption(e);
              }
            },
          ),
        )
        .toList();
    Text selected = Text(_selectedOptions.join(", "),
        style: const TextStyle(color: Colors.grey, fontSize: 14));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        selected,
        const SizedBox(height: 10),
        SizedBox(
          // TODO: LAYOUT - Expanded widget throws error
          height: 380,
          child: SingleChildScrollView(
              child: Wrap(
                  spacing: 10,
                  direction: Axis.horizontal,
                  children: filteredOptions)),
        )
      ],
    );
  }
}

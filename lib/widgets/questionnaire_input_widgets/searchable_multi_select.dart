import 'package:flutter/material.dart';

class SearchableMultiSelect extends StatefulWidget {
  final String? response;
  final void Function(String) updateResponseCallback;
  final List<String> options;
  const SearchableMultiSelect(
      {Key? key,
      this.response,
      required this.updateResponseCallback,
      required this.options})
      : super(key: key);

  @override
  _SearchableMultiSelectState createState() => _SearchableMultiSelectState();
}

class _SearchableMultiSelectState extends State<SearchableMultiSelect> {
  final TextEditingController searchController = TextEditingController();
  late final List<String> _selectedOptions =
      widget.response == null ? [] : widget.response!.split(",");
  String _searchText = "";

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
    List<FilterChip> filtered = widget.options
        .where((e) => e.startsWith(_searchText))
        .map((e) => FilterChip(
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
            ))
        .toList();
    List<InputChip> selected = _selectedOptions
        .map((e) => InputChip(
              label: Text(e),
              onDeleted: () {
                removeOption(e);
              },
            ))
        .toList();
    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: SingleChildScrollView(
              child: Wrap(
                  spacing: 5, direction: Axis.horizontal, children: selected)),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 280,
          child: SingleChildScrollView(
              child: Wrap(
                  spacing: 10, direction: Axis.horizontal, children: filtered)),
        )
      ],
    );
  }
}

import 'package:disewainaja/app/data/models/user_model.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SelectSearch extends StatelessWidget {
  final String label;
  final List<User> data;
  final void Function(User?)? onChanged;

  const SelectSearch({
    super.key,
    required this.label,
    required this.data,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<User>(
      items: (f, cs) => data.where((e) => e.name.contains(f)).toList(),
      onChanged: onChanged,
      itemAsString: (User user) => user.name,
      compareFn: (User user1, User user2) => user1.name == user2.name,
      filterFn: (User user, String filter) => user.name.contains(filter),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Cari $label',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            filled: true,
          ),
        ),
      ),
    );
  }
}

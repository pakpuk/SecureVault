import 'package:flutter/material.dart';
import 'package:password_manager_app/theme/colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
              child: Icon(
                Icons.search,
                color: ColorsManager.ksearchgrey,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            hintText: "Search password",
            fillColor: ColorsManager.ktextfieldcolor,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(24))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bin7r4decl/core/constants/colors.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.initialSelection,
    this.width,
    this.backgroundColor,
    this.textStyle,
    this.leadingIcon,
    required this.onSelected,
    required this.dropdownMenuEntries,
  });

  final String? initialSelection;
  final double? width;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? leadingIcon;
  final void Function(String?) onSelected;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: initialSelection,
      onSelected: onSelected,
      width: width ?? MediaQuery.sizeOf(context).width / 2.25,
      textStyle: textStyle ?? Theme.of(context).textTheme.titleSmall,
      leadingIcon: leadingIcon,
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(AppColors.gray3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        constraints: const BoxConstraints(maxHeight: 48, minHeight: 48),
        filled: true,
        fillColor: backgroundColor ?? AppColors.darkGrey,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}

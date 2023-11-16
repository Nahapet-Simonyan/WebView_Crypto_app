import 'package:flutter/material.dart';
import 'package:bin7r4decl/core/constants/colors.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    this.onTap,
    required this.title,
    this.leading,
    this.isLast,
  });

  final void Function()? onTap;
  final String title;
  final Widget? leading;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 282,
        height: 48,
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) const SizedBox(width: 8.0),
                  Text(title, style: theme.textTheme.labelMedium),
                  const Expanded(child: SizedBox()),
                  Image.asset('assets/icons/arrow_right.png'),
                  const SizedBox(width: 12.0),
                ],
              ),
            ),
            if (isLast != true)
              const Divider(
                height: 1,
                color: AppColors.gray2,
                thickness: 2,
              ),
          ],
        ),
      ),
    );
  }
}

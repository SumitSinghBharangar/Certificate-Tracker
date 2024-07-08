import 'package:flutter/material.dart';
import 'package:gla_certificate/utils/colors/app_colors.dart';

class ListComponent extends StatelessWidget {
  final double? padding;
  final Widget? child;
  const ListComponent({super.key, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: shadowColor, offset: Offset(8, 6), blurRadius: 12),
            const BoxShadow(
                color: Colors.white, offset: Offset(-8, -6), blurRadius: 12),
          ],
        ),
        child: child,
      ),
    );
  }
}

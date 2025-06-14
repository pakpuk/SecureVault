import 'package:flutter/material.dart';
import 'package:password_manager_app/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarIcon extends StatelessWidget {
  final double iconsize;
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  const AppBarIcon(
      {super.key,
      this.iconsize = 30,
      required this.icon,
      this.onTap,
      this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.h,
      width: size.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: ColorsManager.kgrey.withOpacity(0.2)),
      child: Icon(icon, size: iconsize),
    );
  }
}

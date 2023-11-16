import 'package:flutter/material.dart';

class InkWellPlus extends StatelessWidget {
  const InkWellPlus({
    super.key,
    required this.onTap,
    required this.child,
    required this.color,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.border,
  });

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final BorderRadius borderRadius;
  final void Function()? onTap;
  final Widget child;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          borderRadius: borderRadius,
          onTap: onTap,
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

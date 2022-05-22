import 'package:flutter/material.dart';

/// 卡片控件
class KitCard extends StatelessWidget {
  const KitCard({
    Key? key,
    this.child,
    this.alignment,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.elevation = 4.0,
    this.shadowColor = Colors.black26,
  }) : super(key: key);

  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? shadowColor;
  final BorderRadius? borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4.0),
      constraints: constraints,
      child: Material(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: borderRadius,
        elevation: elevation,
        shadowColor: shadowColor,
        child: Container(
          alignment: alignment,
          width: width,
          height: height,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: child,
        ),
      ),
    );
  }
}

class KitAnimateCard extends StatelessWidget {
  const KitAnimateCard({
    Key? key,
    this.child,
    this.alignment,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.elevation = 4.0,
    this.shadowColor = Colors.black26,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.linear,
  }) : super(key: key);

  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? shadowColor;
  final BorderRadius? borderRadius;
  final double elevation;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4.0),
      constraints: constraints,
      duration: duration,
      curve: curve,
      child: Material(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: borderRadius,
        elevation: elevation,
        shadowColor: shadowColor,
        child: AnimatedContainer(
          alignment: alignment,
          width: width,
          height: height,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: child,
          duration: duration,
          curve: curve,
        ),
      ),
    );
  }
}

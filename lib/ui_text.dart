/*
 * @Author BangJin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 23:27:50 Tuesday
 */

import 'package:flutter/widgets.dart';

class UIText extends StatelessWidget {

  final String data;
  final double fontSize;
  final int color;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;
  final Paint paint;
  const UIText({
    Key key,
    @required this.data,
    this.fontSize,
    this.color = 0xFF333333,
    this.fontWeight,
    this.padding,
    this.textAlign,
    this.maxLines,
    this.overflow, this.paint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: this.padding ?? EdgeInsets.all(0),
      child: new Text(
        this.data ?? '',
        textAlign: this.textAlign ?? TextAlign.start,
        style: new TextStyle(
          fontSize: this.fontSize ?? 16,
          fontWeight: this.fontWeight ?? FontWeight.normal,
          color: this.paint == null ? Color(this.color ?? 0xFF333333) : null,
          foreground: this.paint,
        ),
        maxLines: this.maxLines,
        overflow: this.overflow,
      ),
    );
  }
}

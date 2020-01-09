/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 23:27:50 Tuesday
 */

import 'package:flutter/widgets.dart';

class UIText extends StatefulWidget {
  final String data;
  final double fontSize;
  final int color;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;
  const UIText({
    Key key,
    @required this.data,
    this.fontSize,
    this.color = 0xFF333333,
    this.fontWeight,
    this.padding,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);
  _UIText createState() => new _UIText();
}

class _UIText extends State<UIText> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: widget.padding ?? EdgeInsets.all(0),
      child: new Text(
        widget.data ?? '',
        textAlign: widget.textAlign ?? TextAlign.start,
        style: new TextStyle(
          fontSize: widget.fontSize ?? 16,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: Color(widget.color ?? 0xFF333333),
        ),
        maxLines: widget.maxLines ?? 1,
        overflow: widget.overflow,
      ),
    );
  }
}

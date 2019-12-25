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
  const UIText({
    Key key,
    @required this.data,
    this.fontSize = 16,
    this.color = 0xFF333333,
    this.fontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.all(0),
    this.textAlign = TextAlign.center,
  }) : super(key: key);
  _UIText createState() => new _UIText();
}

class _UIText extends State<UIText> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Padding(
      padding: widget.padding,
      child: new Text(
        widget.data ?? '',
        textAlign: widget.textAlign,
        style: new TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: Color(widget.color ?? 0xFF333333),
        ),
      ),
    );
  }
}

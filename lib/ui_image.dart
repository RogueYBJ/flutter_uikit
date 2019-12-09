/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 22:42:23 Tuesday
 */

import 'package:flutter/material.dart';

class UIImage extends StatefulWidget {
  final String imgStr;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BoxFit fit;
  final double radius;

  const UIImage({
    Key key,
    @required this.imgStr,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(0),
    this.fit,
    this.radius = 5,
  }) : super(key: key);
  _UIImage createState() => new _UIImage();
}

class _UIImage extends State<UIImage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: new Padding(
        padding: widget.padding,
        child: widget.imgStr.length == 0
            ? Icon(Icons.error)
            : (widget.imgStr.length >= 4 &&
                    widget.imgStr.substring(0, 4) == 'http')
                ? _network()
                : _asset(),
      ),
    );
  }

  Image _network() {
    return Image.network(
      widget.imgStr,
      fit: _boxFit(),
      width: _boxFit() == BoxFit.fitHeight ? null : widget.width,
      height: _boxFit() == BoxFit.fitWidth ? null : widget.height,
      frameBuilder: (_, w, i, b) {
        return i == null
            ? new Container(
                width: widget.width / 2,
                height: widget.width / 2,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              )
            : w;
      },
    );
  }

  Image _asset() {
    return Image.asset(
      widget.imgStr,
      fit: widget.fit ?? _boxFit(),
      width: widget.width,
      height: widget.height,
      color: Colors.red,
      frameBuilder: (_, w, i, b) {
        return i == null ? Icon(Icons.error) : w;
      },
    );
  }

  BoxFit _boxFit() {
    if (widget.height != null && widget.width != null) {
      return BoxFit.fill;
    } else {
      return widget.height == null ? BoxFit.fitWidth : BoxFit.fitHeight;
    }
  }
}

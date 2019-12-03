/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 18:53:45 Tuesday
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui_image.dart';
import 'package:flutter_uikit/ui_text.dart';

enum UIbuttonType { normal, left, right, top, bottom }

class UIButtonState {
  final String title;
  final UIbuttonType buttonType;
  final double fontSize;
  final int color;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final String imgStr;
  final double spacing;
  final double imageWidth;
  final double imageHeight;
final EdgeInsetsGeometry imgPadding;
  UIButtonState({
    @required this.title,
    this.buttonType = UIbuttonType.normal,
    this.fontSize = 16,
    this.color = 0xFFFFFFFF,
    this.fontWeight,
    this.padding = const EdgeInsets.all(0),
    this.imgStr = '',
    this.spacing = 5,
    this.imageWidth = 36,
    this.imageHeight,
    this.imgPadding = const EdgeInsets.all(0),
  });
}

class UIButton extends StatefulWidget {
  final UIButtonState buttonState;
  final Widget child;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final double minSize;
  final BorderRadius borderRadius;
  final int color; //设置按钮方法才能显示颜色，没有按钮方法么人为点击失效，点击失效按钮为primaryColor颜色

  const UIButton({
    Key key,
    @required this.buttonState,
    this.child,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(0),
    this.minSize = 0,
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
    this.color = 0xFF28B434,
  }) : super(key: key);

  _UIButton createState() => new _UIButton();
}

class _UIButton extends State<UIButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoButton(
      color: Color(widget.color),
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      minSize: widget.minSize,
      onPressed: widget.onPressed,
      child: widget.child ?? _buttonStateChild(),
    );
  }

  Widget _buttonStateChild() {
    return widget.buttonState.buttonType == UIbuttonType.normal
        ? _buttonText()
        : widget.buttonState.buttonType == UIbuttonType.top ||
                widget.buttonState.buttonType == UIbuttonType.bottom
            ? new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.buttonState.buttonType == UIbuttonType.top
                      ? _buttonImage()
                      : _buttonText(),
                  new Container(
                    height: widget.buttonState.spacing,
                    width: 0.0,
                  ),
                  widget.buttonState.buttonType == UIbuttonType.top
                      ? _buttonText()
                      : _buttonImage(),
                ],
              )
            : new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.buttonState.buttonType == UIbuttonType.left
                      ? _buttonImage()
                      : _buttonText(),
                  new Container(
                    width: widget.buttonState.spacing,
                    height: 0.0,
                  ),
                  widget.buttonState.buttonType == UIbuttonType.left
                      ? _buttonText()
                      : _buttonImage(),
                ],
              );
  }

  Widget _buttonImage() {
    return UIImage(
      imgStr: widget.buttonState.imgStr,
      width: widget.buttonState.imageWidth,
      height: widget.buttonState.imageHeight,
      padding: widget.buttonState.imgPadding,
    );
  }

  UIText _buttonText() {
    return UIText(
      data: widget.buttonState.title,
      fontSize: widget.buttonState.fontSize,
      fontWeight: widget.buttonState.fontWeight,
      color: widget.buttonState.color,
      padding: widget.buttonState.padding,
    );
  }
}

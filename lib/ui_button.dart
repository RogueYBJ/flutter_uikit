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
  final Widget view;
  final UIbuttonType buttonType;
  final double fontSize;
  final int color;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final String imgStr;
  final double spacing;
  final double imageWidth;
  final double imageHeight;
  final double imageRadius;
  final BoxFit fit;
  final EdgeInsetsGeometry imgPadding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  UIButtonState({
    @required this.title,
    this.fit, 
    this.view, 
    this.buttonType = UIbuttonType.normal,
    this.fontSize = 16,
    this.color = 0xFFFFFFFF,
    this.fontWeight,
    this.padding = const EdgeInsets.all(0),
    this.imgStr = '',
    this.spacing = 5,
    this.imageWidth = 36,
    this.imageHeight,
    this.imageRadius = 0,
    this.imgPadding = const EdgeInsets.all(0),
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize, 
  });
}

class UIButton extends StatefulWidget {
  final UIButtonState buttonState;
  final Widget child;
  final Widget buttonText;
  final Widget buttonImage;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final double minSize;
  final double radius;
  final int color; //设置按钮方法才能显示颜色，没有按钮方法么人为点击失效，点击失效按钮为primaryColor颜色

  const UIButton({
    Key key,
    this.buttonState,
    this.child,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(0),
    this.minSize = 0,
    this.radius = 5,
    this.color = 0xFF28B434,
    String data, this.buttonText, this.buttonImage,
  }) : super(key: key);

  _UIButton createState() => new _UIButton();
}

class _UIButton extends State<UIButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Color(widget.color),
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
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
                mainAxisAlignment: widget.buttonState.mainAxisAlignment ??
                    MainAxisAlignment.start,
                crossAxisAlignment: widget.buttonState.crossAxisAlignment ??
                    CrossAxisAlignment.center,
                mainAxisSize: widget.buttonState.mainAxisSize ?? MainAxisSize.min,
                children: <Widget>[
                  widget.buttonState.buttonType == UIbuttonType.top
                      ? widget.buttonState.view ?? _buttonImage()
                      : _buttonText(),
                  new Container(
                    height: widget.buttonState.spacing,
                    width: 0.0,
                  ),
                  widget.buttonState.buttonType == UIbuttonType.top
                      ? _buttonText()
                      : widget.buttonState.view ?? _buttonImage(),
                ],
              )
            : new Row(
                mainAxisAlignment: widget.buttonState.mainAxisAlignment ??
                    MainAxisAlignment.start,
                crossAxisAlignment: widget.buttonState.crossAxisAlignment ??
                    CrossAxisAlignment.center,
                mainAxisSize: widget.buttonState.mainAxisSize ?? MainAxisSize.min,
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
    return widget.buttonImage ?? UIImage(
      fit: widget.buttonState.fit,
      imgStr: widget.buttonState.imgStr,
      width: widget.buttonState.imageWidth,
      height: widget.buttonState.imageHeight,
      padding: widget.buttonState.imgPadding,
      radius: widget.buttonState.imageRadius,
    );
  }

  Widget _buttonText() {
    return widget.buttonText ?? UIText(
      data: widget.buttonState.title,
      fontSize: widget.buttonState.fontSize,
      fontWeight: widget.buttonState.fontWeight,
      color: widget.buttonState.color,
      padding: widget.buttonState.padding,
    );
  }
}

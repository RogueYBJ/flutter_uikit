/*
 * @Author BangJin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 18:53:45 Tuesday
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui_image.dart';
import 'package:flutter_uikit/ui_text.dart';

enum UIButtonType { normal, left, right, top, bottom }

class UIButtonState {
  final String title;
  final Widget view;
  final UIButtonType buttonType;
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
  final EdgeInsetsGeometry imgMargin;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  UIButtonState({
    @required this.title,
    this.fit, 
    this.view, 
    this.buttonType = UIButtonType.normal,
    this.fontSize = 16,
    this.color = 0xFFFFFFFF,
    this.fontWeight,
    this.padding = const EdgeInsets.all(0),
    this.imgStr = '',
    this.spacing = 5,
    this.imageWidth = 36,
    this.imageHeight,
    this.imageRadius = 0,
    this.imgMargin = const EdgeInsets.all(0),
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize, 
  });
}

class UIButton extends StatelessWidget {
  final UIButtonState buttonState;
  final Widget child;
  final double width;
  final double height;
  final Widget buttonText;
  final Widget buttonImage;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double minSize;
  final double radius;
  final int color; //设置按钮方法才能显示颜色，没有按钮方法么人为点击失效，点击失效按钮为primaryColor颜色

  const UIButton({
    Key key,
    this.buttonState,
    this.child,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.minSize = 0,
    this.radius = 5,
    this.color = 0xFFFFFFFF,
    String data, this.buttonText, this.buttonImage, this.width, this.height,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      width: this.width,
      height: this.height,
      child: CupertinoButton(
        color: Color(this.color),
        borderRadius: BorderRadius.all(Radius.circular(this.radius)),
        padding: this.padding,
        minSize: this.minSize,
        onPressed: this.onPressed,
        child: this.child ?? _buttonStateChild(),
      ),
    );
  }

  Widget _buttonStateChild() {
    return this.buttonState.buttonType == UIButtonType.normal
        ? _buttonText()
        : this.buttonState.buttonType == UIButtonType.top ||
        this.buttonState.buttonType == UIButtonType.bottom
            ? new Column(
                mainAxisAlignment: this.buttonState.mainAxisAlignment ??
                    MainAxisAlignment.start,
                crossAxisAlignment: this.buttonState.crossAxisAlignment ??
                    CrossAxisAlignment.center,
                mainAxisSize: this.buttonState.mainAxisSize ?? MainAxisSize.min,
                children: <Widget>[
                  this.buttonState.buttonType == UIButtonType.top
                      ? this.buttonState.view ?? _buttonImage()
                      : _buttonText(),
                  new Container(
                    height: this.buttonState.spacing,
                    width: 0.0,
                  ),
                  this.buttonState.buttonType == UIButtonType.top
                      ? _buttonText()
                      : this.buttonState.view ?? _buttonImage(),
                ],
              )
            : new Row(
                mainAxisAlignment: this.buttonState.mainAxisAlignment ??
                    MainAxisAlignment.start,
                crossAxisAlignment: this.buttonState.crossAxisAlignment ??
                    CrossAxisAlignment.center,
                mainAxisSize: this.buttonState.mainAxisSize ?? MainAxisSize.min,
                children: <Widget>[
                  this.buttonState.buttonType == UIButtonType.left
                      ? _buttonImage()
                      : _buttonText(),
                  new Container(
                    width: this.buttonState.spacing,
                    height: 0.0,
                  ),
                  this.buttonState.buttonType == UIButtonType.left
                      ? _buttonText()
                      : _buttonImage(),
                ],
              );
  }

  Widget _buttonImage() {
    return this.buttonImage ?? UIImage(
      fit: this.buttonState.fit,
      imgStr: this.buttonState.imgStr,
      width: this.buttonState.imageWidth,
      height: this.buttonState.imageHeight,
      margin: this.buttonState.imgMargin,
      radius: this.buttonState.imageRadius,
    );
  }

  Widget _buttonText() {
    return this.buttonText ?? UIText(
      data: this.buttonState.title,
      fontSize: this.buttonState.fontSize,
      fontWeight: this.buttonState.fontWeight,
      color: this.buttonState.color,
      padding: this.buttonState.padding,
    );
  }
}

/*
 * @Author BangJin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 22:42:23 Tuesday
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/flutter_uikit.dart';

class UIImage extends StatelessWidget {
  final String imgStr;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxFit fit;
  final double radius;
  final int imgColor;
  final double progressRadius;
  final Decoration decoration;

  const UIImage({
    Key key,
    @required this.imgStr,
    this.width,
    this.height,
    this.margin,
    this.fit,
    this.radius,
    this.imgColor,
    this.progressRadius, this.decoration, this.padding,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: this.margin ?? EdgeInsets.all(0),
      padding: this.padding ?? EdgeInsets.all(0),
      width: this.width,
      height: this.height,
      alignment: Alignment.center,
      decoration: this.decoration ?? BoxDecoration(),
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(this.radius ?? 5),
        child: (this.imgStr?.length ?? 0) == 0
            ? new Center(
          child: SizedBox(
            width: this.progressRadius ?? 10,
            height: this.progressRadius ?? 10,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        )
            : ((this.imgStr?.length ?? 0) >= 4 &&
            this.imgStr.substring(0, 4) == 'http')
            ? _network()
            : _asset(),
      ),
    );
  }

  CachedNetworkImage _network() {
    return CachedNetworkImage(
      imageUrl: this.imgStr ?? '',
      imageBuilder: (context, imageProvider) => Container(
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: this.fit ?? BoxFit.fill,
              colorFilter: UIKit.colorFilter ?? ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => new Center(
        child: SizedBox(
          width: this.progressRadius ?? 10,
          height: this.progressRadius ?? 10,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Image _asset() {
    return Image.asset(
      this.imgStr ?? '',
      fit: this.fit ?? BoxFit.fill,
      width: this.width,
      height: this.height,
      color: this.imgColor == null ? this.imgColor : Color(this.imgColor),
      frameBuilder: (_, w, i, b) {
        return i == null
            ? new Center(
                child: SizedBox(
                  width: this.progressRadius ?? 10,
                  height: this.progressRadius ?? 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : w;
      },
    );
  }
}

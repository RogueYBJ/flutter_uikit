/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-03 22:42:23 Tuesday
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/flutter_uikit.dart';

class UIImage extends StatefulWidget {
  final String imgStr;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BoxFit fit;
  final double radius;
  final int imgColor;
  final double progressRadius;

  const UIImage({
    Key key,
    @required this.imgStr,
    this.width,
    this.height,
    this.padding,
    this.fit,
    this.radius,
    this.imgColor,
    this.progressRadius,
  }) : super(key: key);

  _UIImage createState() => new _UIImage();
}

class _UIImage extends State<UIImage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: widget.padding ?? EdgeInsets.all(0),
      width: widget.width,
      height: widget.height,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? 5),
        child: (widget.imgStr?.length ?? 0) == 0
            ? new Center(
          child: SizedBox(
            width: widget.progressRadius ?? 10,
            height: widget.progressRadius ?? 10,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        )
            : ((widget.imgStr?.length ?? 0) >= 4 &&
            widget.imgStr.substring(0, 4) == 'http')
            ? _network()
            : _asset(),
      ),
    );
  }

  CachedNetworkImage _network() {
    return CachedNetworkImage(
      imageUrl: widget.imgStr ?? '',
      imageBuilder: (context, imageProvider) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: widget.fit ?? BoxFit.fill,
              colorFilter: UIKit.colorFilter ?? ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => new Center(
        child: SizedBox(
          width: widget.progressRadius ?? 10,
          height: widget.progressRadius ?? 10,
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
      widget.imgStr ?? '',
      fit: widget.fit ?? BoxFit.fill,
      width: widget.width,
      height: widget.height,
      color: widget.imgColor == null ? widget.imgColor : Color(widget.imgColor),
      frameBuilder: (_, w, i, b) {
        return i == null
            ? new Center(
                child: SizedBox(
                  width: widget.progressRadius ?? 10,
                  height: widget.progressRadius ?? 10,
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

/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-04 11:29:42 Wednesday
 */

import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutter_uikit/flutter_uikit.dart';

class ItemState {
  final int backgroundColor;
  final double top;
  final double bottom;
  final double radius;
  final double lineHeight;
  final int lineColor;

  ItemState({
    this.backgroundColor = 0xFFFFFFFF,
    this.top = 5,
    this.bottom = 5,
    this.radius = 5,
    this.lineHeight = 1,
    this.lineColor = 0xFFE5E5E5,
  });
}

class UITableView extends StatefulWidget {
  final int group;
  final Function itemsNumAction;
  final Function item;
  final Widget header;
  final Widget footer;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Function upData;
  final Function downData;
  final Function newData;
  final Widget backView;
  final String backImgStr;
  final ItemState itemState;
  final Widget groupHeader;
  final Widget groupFooter;
  const UITableView({
    Key key,
    @required this.item,
    this.group = 1,
    @required this.itemsNumAction,
    this.upData,
    this.downData,
    this.header,
    this.footer,
    this.margin,
    this.padding,
    this.backView,
    this.backImgStr,
    this.newData,
    this.itemState,
    this.groupHeader,
    this.groupFooter,
  }) : super(key: key);
  _UITableView createState() => new _UITableView();
}

class _UITableView extends State<UITableView> {
  List<int> _itemsList = [];

  int _items = 0;

  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      widget.upData();
    });
  }

  // 底部加载
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 1), () {
      widget.downData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setItemsNum();
  }

  void _setItemsNum() {
    _itemsList = [];
    _items = 0;
    for (var i = 1; i <= widget.group; i++) {
      int index = widget.itemsNumAction(i);
      _items += index;
      _itemsList.add(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getItemCount() == 0
        ? _backView()
        : (widget.upData != null || widget.downData != null)
            ? new Refresh(
                onHeaderRefresh: onHeaderRefresh,
                onFooterRefresh: onFooterRefresh,
                childBuilder: (BuildContext context,
                    {ScrollController controller, ScrollPhysics physics}) {
                  return new Container(
                    margin: widget.margin,
                    child:
                        _getListView(controller: controller, physics: physics),
                  );
                },
              )
            : _getListView();
  }

  Widget _backView() {
    return widget.backView != null
        ? widget.backView
        : new Container(
            child: new Center(
              child: new UIButton(
                onPressed: () {
                  if (widget.newData != null) {
                    widget.newData();
                  } else {
                    if (widget.upData != null) {
                      widget.upData();
                    }
                  }
                },
                color: 0x00000000,
                buttonState: UIButtonState(
                    title: '点击刷新',
                    imgStr: widget.backImgStr,
                    color: 0xFF666666),
              ),
            ),
          );
  }

  int _getItemCount() {
    return _items +
        (widget.header == null ? 0 : 1) +
        (widget.footer == null ? 0 : 1);
  }

  Widget _getListView({ScrollController controller, ScrollPhysics physics}) {
    return new ListView.builder(
        padding: widget.padding,
        controller: controller,
        physics: physics,
        itemCount: _getItemCount(),
        itemBuilder: (BuildContext context, int position) {
          if (widget.header != null && widget.footer != null) {
            if (position == 0) {
              return widget.header;
            } else if (position == _getItemCount() - 1) {
              return widget.footer;
            } else {
              return _itemView(
                  group: _group(position - 1),
                  index: _index(position - 1)); //position - 1
            }
          } else if (widget.header != null) {
            return position == 0
                ? widget.header
                : _itemView(
                    group: _group(position - 1),
                    index: _index(position - 1)); //position - 1
          } else if (widget.footer != null) {
            return position == _getItemCount() - 1
                ? widget.footer
                : _itemView(
                    group: _group(position),
                    index: _index(position)); //position
          } else {
            return _itemView(
                group: _group(position), index: _index(position)); //position
          }
        });
  }

  Widget _itemView({int group, int index}) {
    return new Container(
      margin: widget.group > 1
          ? EdgeInsets.only(
              top: index == 0 ? widget.itemState?.top ?? ItemState().top : 0,
              bottom: index == _itemsList[group - 1] - 1
                  ? widget.itemState?.top ?? ItemState().top
                  : 0,
            )
          : null,
      decoration: BoxDecoration(
        color: Color(
            widget.itemState?.backgroundColor ?? ItemState().backgroundColor),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              index == 0 ? widget.itemState?.radius ?? ItemState().radius : 0),
          bottom: Radius.circular(index == _itemsList[group - 1] - 1
              ? widget.itemState?.radius ?? ItemState().radius
              : 0),
        ),
      ),
      child: new Column(
        children: <Widget>[
          index == 0 ? widget.groupHeader ?? new Container() : new Container(),
          widget.item(group, index),
          Divider(
            color: Color(widget.itemState?.lineColor ?? ItemState().lineColor),
            height: widget.itemState?.lineHeight ?? ItemState().lineHeight,
          ),
          index == _itemsList[group - 1] - 1 ? widget.groupFooter ?? new Container() : new Container(),
        ],
      ),
    );
  }

  int _group(int position) {
    int items = 0;
    for (var i = 0; i <= _itemsList.length; i++) {
      items += _itemsList[i];
      if (items - 1 >= position) {
        return i + 1;
      }
    }
    return 1;
  }

  int _index(int position) {
    int items = 0;
    for (var i = 0; i <= _itemsList.length; i++) {
      items += _itemsList[i];
      if (items - 1 >= position) {
        return position - (items - _itemsList[i]);
      }
    }
    return 0;
  }
}

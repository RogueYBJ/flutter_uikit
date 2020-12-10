/*
 * @author: 余邦锦（RogueYBJ） 
 * @date 2020/11/18.
 * slogan: 每行代码的开始都意味着新的征程
 * E-Mail Address：15179861454@163.com
 * Work Address: 浙江省杭州市滨江区聚光中心1704
 * file Address: lib/ui_kit/ui_custom_table_view
 * description: ui_custom_table_view
 */

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_uikit/flutter_uikit.dart';
import 'package:flutter_refresh/flutter_refresh.dart';


class UICustomTableView extends StatelessWidget {
  final int group; // 组
  final int Function(int group) length; // 每组的长度
  final Widget Function(int group, int index) item; // itemView
  final Widget headerView; // 头部
  final Widget footerView; // 尾部
  final Widget Function(int group) itemList; // 每组的列表
  final Widget Function(int group) groupHeader; // 每组的头部
  final Widget Function(int group) groupFooter; // 每组的尾部
  final SliverPersistentHeader persistentHeader; // 吸顶头部
  final SliverAppBar appBar; // appbar
  final Widget sliverFill; // 底部填充

  final Function upData; // 下拉刷新
  final Function downData; // 上啦加载
  final EdgeInsetsGeometry margin; // 外边距
  final EdgeInsetsGeometry padding; // 内边距
  final Decoration decoration; // 样式
  final Axis axis; // 滑动方式
  final ScrollController controller; // 滑动控制器
  final ScrollPhysics physics; // 滑动样式
  final Color color; // 颜色 ps：样式会干掉颜色
  final bool removeTop; // 是否删除状态栏的高度

  const UICustomTableView({
    Key key,
    this.margin,
    this.padding,
    this.axis,
    this.controller,
    this.physics,
    this.itemList,
    this.headerView,
    this.footerView,
    this.groupHeader,
    this.groupFooter,
    this.group = 1,
    this.length,
    this.item,
    this.persistentHeader,
    this.appBar,
    this.sliverFill,
    this.color, this.removeTop, this.decoration, this.upData, this.downData,
  }) : super(key: key);


  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      if (this.upData != null) {
        this.upData();
      }
    });
  }

  // 底部加载
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 1), () {
      if (this.downData != null) {
        this.downData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: this.removeTop ?? true,
        context: context,
        child: new Refresh(
          physics: this.physics,
          scrollController: this.controller,
          onHeaderRefresh: this.upData != null ? onHeaderRefresh : null,
          onFooterRefresh: this.downData != null ? onFooterRefresh : null,
          childBuilder: (BuildContext context,
              {ScrollController controller, ScrollPhysics physics}) {
            return  Container(
              margin: this.margin,
              padding: this.padding,
              decoration: this.decoration ?? BoxDecoration(
                color: this.color,
              ),
              child: _getListView(controller: this.controller, physics: this.physics),
            );
          },
        ));
  }

  Widget _getListView({ScrollController controller, ScrollPhysics physics}) {
    return CustomScrollView(
      controller: controller,
      physics: physics,
      slivers: sliversList(),
    );
  }

  List<Widget> sliversList() {
    // 创建空列表 slivers
    List<Widget> slivers = [];

    if (this.appBar != null) {
      slivers.add(this.appBar);
    }

    // 添加 列表头部 headerView
    if (this.headerView != null) {
      slivers.add(SliverToBoxAdapter(
        child: this.headerView,
      ));
    }

    // 添加 列表头部 headerView
    if (this.persistentHeader != null) {
      slivers.add(this.persistentHeader);
    }

    // 遍历 每组的数据 group
    for (int i = 0; i < (this.group ?? 0); i++) {
      // 添加 每组的头部 groupHeader
      if (this.groupHeader != null) {
        slivers.add(SliverToBoxAdapter(
          child: this.groupHeader(i),
        ));
      }

      // 添加 每组的SliverList SliverList
      if(this.itemList!=null){
        slivers.add( this.itemList(i) ?? SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int position) {
              return this.item == null ? Container() :  this.item(i, position);
            },
            childCount: this.length(i) ?? 0,
          ),
        ));
      }else{
        if (this.length != null) {
          slivers.add(SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int position) {
                return this.item == null ? Container() : this.item(i, position);
              },
              childCount: this.length(i) ?? 0,
            ),
          ));
        }
      }

      // 添加 每组的尾部 groupFooter
      if (this.groupFooter != null) {
        slivers.add(SliverToBoxAdapter(
          child: this.groupFooter(i),
        ));
      }
    }

    // 添加 列表尾部 footerView
    if (this.footerView != null) {
      slivers.add(SliverToBoxAdapter(
        child: this.footerView,
      ));
    }

//    slivers.add(SliverFillRemaining(
//      child: widget.sliverFill ?? Container(child: Text('asds'),),
//    ));

    return slivers;
  }
}

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(double shrinkOffset, bool overlapsContent) buildView;
  final double min;
  final double max;

  CustomSliverHeaderDelegate({
    @required this.buildView,
    this.min,
    this.max,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.buildView(shrinkOffset,overlapsContent);
  }

  @override
  double get maxExtent => this.max ?? 100; //this.max ?? 100;

  @override
  double get minExtent => this.min ?? 100; //this.min ?? 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomVideoSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  CustomVideoSliverHeaderDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 400;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
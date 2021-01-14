/*
 * @author: 余邦锦（RogueYBJ） 
 * @date 2020/12/10.
 * slogan: 每行代码的开始都意味着新的征程
 * E-Mail Address：15179861454@163.com
 * Work Address: 浙江省杭州市滨江区聚光中心1704
 * file Address: lib//ui_overlay
 * description: ui_overlay
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum OverlayStatus {
  normal,
  successful,
  prompt,
  error,
  toast,
}

/// 创建 ui_overlay
class UIOverlay {

  static String successfulImg = '';
  static String promptImg = '';
  static String errorImg = '';

  ///计数引用
  static int _count = 0;

  static String _msg;

  static OverlayStatus _overlayStatus;

  static void show(
      String msg, {
        OverlayStatus dioStatus = OverlayStatus.normal,
        bool isShow = true,
      }) {
    if (isShow) {
      _count += 1;
      _msg = msg;
      _overlayStatus = dioStatus;
      OverlayView.addOverlayEntry(_loadingView());
    }
  }

  static void dismiss() {
    _count -= 1;
    if (_count <= 0) {
      OverlayView?.clean();
    }
  }

  /// toast
  static void toast(String msg, {int seconds = 2000}) {
    show(msg, dioStatus: OverlayStatus.toast);
    new Future.delayed(Duration(milliseconds: seconds), () => dismiss());
  }

  ///提示语
  static void prompt(String msg, {int seconds = 2000}) {
    show(msg, dioStatus: OverlayStatus.prompt);
    new Future.delayed(Duration(milliseconds: seconds), () => dismiss());
  }

  ///成功
  static void successful(String msg) {
    show(msg, dioStatus: OverlayStatus.successful);
    new Future.delayed(const Duration(milliseconds: 2000), () => dismiss());
  }

  ///失败
  static void error(String msg) {
    show(msg, dioStatus: OverlayStatus.error);
    new Future.delayed(const Duration(milliseconds: 2000), () => dismiss());
  }

  static Widget _loadingView() => Scaffold(
    backgroundColor: Color(OverlayStatus.toast == _overlayStatus ? 0xFF : 0x40000000),
    body: Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(OverlayStatus.toast == _overlayStatus ? 0xEE0000000 :  0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10)),
            child: OverlayStatus.toast == _overlayStatus ? Text(_msg,style: TextStyle(
              color: Color(OverlayStatus.toast == _overlayStatus ? 0xFFFFFFFF :  0xFF000000),
            ),) : new Column(
              children: <Widget>[
                _getCenterStatus(_overlayStatus),
                new Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: new Text(_msg,style: TextStyle(
                    color: Color(OverlayStatus.toast == _overlayStatus ? 0xFFFFFFFF :  0xFF000000),
                  ),),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );

  ///加载状态
  static Widget _getCenterStatus(OverlayStatus status) {
    Widget view = new CircularProgressIndicator(
      strokeWidth: 1,
    );
    switch (status) {
      case OverlayStatus.toast:
        view = new Container();
        break;
      case OverlayStatus.successful:
        view = new Container(
          width: 50,
          height: 50,
          child: successfulImg==''? null : Image.asset(
            successfulImg,
            frameBuilder: (_, w, i, b) {
              return i == null ? Icon(Icons.error) : w;
            },
          ),
        );
        break;
      case OverlayStatus.prompt:
        view = new Container(
          width: 50,
          height: 50,
          child: promptImg==''? null : Image.asset(
            promptImg,
            frameBuilder: (_, w, i, b) {
              return i == null ? Icon(Icons.error) : w;
            },
          ),
        );
        break;
      case OverlayStatus.error:
        view = new Container(
          width: 50,
          height: 50,
          child: errorImg==''? null :  Image.asset(
            errorImg,
            frameBuilder: (_, w, i, b) {
              return i == null ? Icon(Icons.error) : w;
            },
          ),
        );
        break;
      default:
    }
    return view;
  }


}


/// 创建 overlayEntry
class OverlayView {
  static OverlayEntry _overlayEntry;
  static Widget _overlayView;
  static void addOverlayEntry(Widget view) {
    _overlayView = view;
    if (OverlayCreate.context != null) {
      if (_overlayEntry == null) {
        _overlayEntry =
            OverlayEntry(builder: (BuildContext context) => _overlayView);
        print('OverlayView');
        OverlayCreate.createView(_overlayEntry);
      } else {
        if (_overlayEntry != null) {
          _overlayEntry?.markNeedsBuild();
        }
      }
    }else{
      throw UnsupportedError('context 不可缺少');
    }
  }

  static void clean() {
    if (_overlayEntry != null) {
      print('remove');
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static void upData(Widget view) {
    _overlayView = view;
    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
    }
  }
}


/// 添加 overlayEntry
class OverlayCreate {

  static BuildContext context;

  static void createView(OverlayEntry overlayEntry) async {
    if (OverlayCreate.context!=null) {
      OverlayState overlayState = Overlay.of(OverlayCreate.context);
      overlayState.insert(overlayEntry);
    }else{
      throw UnsupportedError('context 不可缺少');
    }
  }
}
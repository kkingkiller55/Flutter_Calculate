import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import 'package:xiaoming/src/command/cmdMethod.dart';
import 'package:xiaoming/src/data/settingData.dart';
import 'package:xiaoming/src/data/userData.dart';
import 'package:xiaoming/src/language/xiaomingLocalizations.dart';
import 'dart:async';
import 'package:xiaoming/src/view/widget/myTextComposer.dart';

class IntegralRoute extends StatefulWidget {
  @override
  _IntegralRouteState createState() => _IntegralRouteState();
}

class _IntegralRouteState extends State<IntegralRoute> {
  TextEditingController _dController;
  TextEditingController _pController;
  TextEditingController _iController;
  String result = '';
  bool isReady = true;

  @override
  void initState() {
    _dController = TextEditingController();
    _pController = TextEditingController();
    _iController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provide.value<SettingData>(context).theme == "IOS") {
      SettingData.nowPage = 1;
      SettingData.pageContext = context;
    }else {
      SettingData.nowPage = 0;
    }

    Future<String> getResult() async {
      if (_dController.text.length == 0 ||
          _pController.text.length == 0 ||
          _iController.text.length == 0) {
        return SettingData.language == "zh" ? "积分函数，积分变量，积分区间都不能为空！" : 
        "Integral function, integral variable, integral interval cannot be empty!";
      }
      if (!_iController.text.contains(',')) {
        return SettingData.language == "zh" ? "请用逗号分隔积分区间" : "Please separate the interval by comma";
      }
      UserFunction uf = UserFunction("__temp__", _pController.text.split(','),
          _dController.text.split(";"));
      int a = int.tryParse(_iController.text.split(',')[0]);
      int b = int.tryParse(_iController.text.split(',')[1]);
      if (a == null || b == null) {
        return SettingData.language == "zh" ? "积分区间必须为整数" : "The integral interval must be an integer";
      }
      num r = await CmdMethodUtil.handleCalculate(uf, a, b);
      return (SettingData.language == "zh" ? "积分结果为：  " : "The integral result is:    ") + r.toStringAsFixed(SettingData.fixedNum.round());
    }

    Widget mainView = SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQueryData.fromWindow(window).padding.top,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTextField(_dController,
                XiaomingLocalizations.of(context).integralFunction),
            MyTextField(_pController,
                XiaomingLocalizations.of(context).integralVariable),
            MyTextField(_iController,
                XiaomingLocalizations.of(context).integralRange + '  ps: 3,5'),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 20.0,
              ),
              child: CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    isReady = false;
                  });
                  getResult().then((str) {
                    setState(() {
                      result = str;
                      isReady = true;
                    });
                  });
                },
                child: Text(XiaomingLocalizations.of(context).calculate),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: isReady
                    ? GestureDetector(
                        onLongPress: () {
                          Clipboard.setData(new ClipboardData(text: result));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text(XiaomingLocalizations.of(context)
                                      .copyHint),
                                );
                              });
                        },
                        child: Text(
                          result,
                          style:
                              TextStyle(color: Colors.purple, fontSize: 20.0),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CupertinoActivityIndicator(),
                          Text(SettingData.language == "zh" ? "正在计算中" : "Under calculation"),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );

    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: '.SF UI Text',
        inherit: false,
        fontSize: 17.0,
        color: CupertinoColors.black,
      ),
      child: GestureDetector(
        //点击空白区域收起键盘
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Provide<SettingData>(
          child: mainView,
          builder: (context, child, sd) {
            return CupertinoPageScaffold(
              navigationBar: sd.theme == "IOS" ? CupertinoNavigationBar(
                middle: Text("Integral"),
                previousPageTitle: "Functions",
              ) : null,
              backgroundColor: CupertinoColors.lightBackgroundGray,
              child: child,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dController.dispose();
    _pController.dispose();
    _iController.dispose();
    super.dispose();
  }
}

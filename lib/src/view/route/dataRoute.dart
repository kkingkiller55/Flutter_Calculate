import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:xiaoming/src/command/matrix.dart';
import 'package:xiaoming/src/data/appData.dart';
import 'package:xiaoming/src/language/xiaomingLocalizations.dart';
import 'package:xiaoming/src/view/route/newMethodRoute.dart';
import 'package:xiaoming/src/view/widget/myButtons.dart';

class NewDataRoute extends StatelessWidget {

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Widget _buildDataView() {
    return Provide<UserData>(
      builder: (context, child, ud) {
        ///保存的浮点数和矩阵组成的卡片列表
        List<Widget> datas = <Widget>[];

        ///加载矩阵列表
        if (ud.matrixs.isNotEmpty) {
          ud.matrixs.forEach((name, list) => datas.add(GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                              XiaomingLocalizations.of(context).removeData),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              child: Text(
                                  XiaomingLocalizations.of(context).delete),
                              onPressed: () {
                                ud.deleteMatrix(name);
                                datas.remove(this);
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                  XiaomingLocalizations.of(context).cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Card(
                  color: Colors.cyan,
                  child: new ListTile(
                    title: new Text(name),
                    subtitle: new Text(MatrixUtil.mtoString(list: list)),
                  ),
                ),
              )));
        }

        ///加载浮点数列表
        if (ud.dbs.isNotEmpty) {
          ud.dbs.forEach((name, value) => datas.add(GestureDetector(
                key: Key(name),
                onLongPress: () {      
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                              XiaomingLocalizations.of(context).removeData),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              child: Text(
                                  XiaomingLocalizations.of(context).delete),
                              onPressed: () {
                                ud.deleteNum(name);
                                datas.remove(this);
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                  XiaomingLocalizations.of(context).cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Card(
                  color: Colors.green,
                  child: new ListTile(
                    title: new Text(name),
                    subtitle: new Text(value.toString()),
                  ),
                ),
              )));
        }

        return ListView.builder(
          key: _listKey,
          itemBuilder: (context, index) => datas[index],
          itemCount: datas.length,
        );
      },
    );
  }

  Widget _buildMethodView() {
    return Provide<UserData>(
      builder: (context, child, ud) {
        ///保存的方法列表
        final List<Widget> methods = <Widget>[];
        Locale myLocale = Localizations.localeOf(context);
        String funName;
        String funDescrip;

        ///将内置方法及已保存的方法加载进methods
        for (int index = 0; index < ud.userFunctions.length; index++) {
          var u = ud.userFunctions[index];
          methods.add(Dismissible(
            onDismissed: (item) {
              ud.deleteUF(u.funName);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text(XiaomingLocalizations.of(context).removeUF),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: Text(XiaomingLocalizations.of(context).delete),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(XiaomingLocalizations.of(context).cancel),
                          onPressed: () {
                            ud.addUF(u.funName, u.paras, u.funCmds);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            background: Container(
              color: Colors.red,
            ),
            key: Key(u.funName),
            child: Card(
              color: Colors.purple,
              child: new ListTile(
                leading: new Text(
                  u.funName,
                ),
                title: new Text(
                    '${u.funName}(${u.paras.toString().substring(1, u.paras.toString().length - 1)})'),
                subtitle: new Text(u.funCmds.toString()),
              ),
            ),
          ));
        }
        for (CmdMethod method in UserData.cmdMethods) {
          if (myLocale.countryCode == 'CH') {
            funName = method.name;
            funDescrip = method.methodDescription;
          } else {
            funName = method.ename;
            funDescrip = method.emethodDescription;
          }
          methods.add(Card(
            color: Colors.yellow,
            child: ListTile(
              title: Text(
                funName,
              ),
              subtitle: Text(funDescrip),
            ),
          ));
        }

        ///添加完分隔线的方法列表
        final List<Widget> divided2 = ListTile.divideTiles(
          context: context,
          tiles: methods,
        ).toList();
        return ListView(
          children: divided2,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ///处理清空按钮调用函数
    void _handleEmpty() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(XiaomingLocalizations.of(context).deleteAllData),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text(XiaomingLocalizations.of(context).delete),
                  onPressed: () {
                    Provide.value<UserData>(context)
                      ..deleteAllNum()
                      ..deleteAllMatrix()
                      ..deleteAllUF();
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(XiaomingLocalizations.of(context).cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicatorColor: CupertinoColors.white,
            tabs: <Widget>[
              Tab(
                text: "Data",
              ),
              Tab(
                text: "Method",
              ),
            ],
          ),
          elevation: 0.0,
          backgroundColor: CupertinoColors.activeOrange,
        ),
        body: TabBarView(
            children: <Widget>[
              _buildDataView(),
              _buildMethodView(),
            ],
          ),
        floatingActionButton: SizedBox(
          height: 150.0,
          width: 100.0,
          child: Column(
            children: <Widget>[
              RaisedButton(
                shape: const CircleBorder(),
                color: Colors.blue,
                padding: const EdgeInsets.all(0.0),
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return NewMethodRoute();
                  }));
                },
              ),
              SizedBox(
                width: 8.0,
              ),
              RaisedButton(
                  color: Colors.blue,
                  shape: const CircleBorder(),
                  child: Icon(CupertinoIcons.delete),
                  onPressed: _handleEmpty),
            ],
          ),
        ),
      ),
    );
  }
}

///保存的数据与方法界面
class DataRoute extends StatefulWidget {
  @override
  _DataRouteState createState() => _DataRouteState();
}

class _DataRouteState extends State<DataRoute> {
  int _sharedValue = 0; //当前卡片序号

  @override
  void initState() {
    UserData.nowPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///处理清空按钮调用函数
    void _handleEmpty() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(XiaomingLocalizations.of(context).deleteAllData),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text(XiaomingLocalizations.of(context).delete),
                  onPressed: () {
                    Provide.value<UserData>(context)
                      ..deleteAllNum()
                      ..deleteAllMatrix()
                      ..deleteAllUF();
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(XiaomingLocalizations.of(context).cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    Widget _buildDataView() {
      return Provide<UserData>(
        builder: (context, child, ud) {
          ///保存的浮点数和矩阵组成的卡片列表
          List<Dismissible> datas = <Dismissible>[];

          ///加载矩阵列表
          if (ud.matrixs.isNotEmpty) {
            ud.matrixs.forEach((name, list) => datas.add(Dismissible(
                  key: Key(name),
                  onDismissed: (item) {
                    ud.deleteMatrix(name);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text(
                                XiaomingLocalizations.of(context).removeData),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                child: Text(
                                    XiaomingLocalizations.of(context).delete),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text(
                                    XiaomingLocalizations.of(context).cancel),
                                onPressed: () {
                                  ud.addMatrix(name, list);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: Card(
                    color: Colors.cyan,
                    child: new ListTile(
                      title: new Text(name),
                      subtitle: new Text(MatrixUtil.mtoString(list: list)),
                    ),
                  ),
                )));
          }

          ///加载浮点数列表
          if (ud.dbs.isNotEmpty) {
            ud.dbs.forEach((name, value) => datas.add(Dismissible(
                  key: Key(name),
                  onDismissed: (item) {
                    ud.deleteNum(name);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text(
                                XiaomingLocalizations.of(context).removeData),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                child: Text(
                                    XiaomingLocalizations.of(context).delete),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text(
                                    XiaomingLocalizations.of(context).cancel),
                                onPressed: () {
                                  ud.addNum(name, value);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: Card(
                    color: Colors.green,
                    child: new ListTile(
                      title: new Text(name),
                      subtitle: new Text(value.toString()),
                    ),
                  ),
                )));
          }

          ///添加完分割线的数据列表
          final List<Widget> divided1 = ListTile.divideTiles(
            context: context,
            tiles: datas.reversed, //将后存入的数据显示在上方
          ).toList();

          return ListView(
            children: divided1,
          );
        },
      );
    }

    Widget _buildMethodView() {
      return Provide<UserData>(
        builder: (context, child, ud) {
          ///保存的方法列表
          final List<Widget> methods = <Widget>[];
          Locale myLocale = Localizations.localeOf(context);
          String funName;
          String funDescrip;

          ///将内置方法及已保存的方法加载进methods
          for (int index = 0; index < ud.userFunctions.length; index++) {
            var u = ud.userFunctions[index];
            methods.add(Dismissible(
              onDismissed: (item) {
                ud.deleteUF(u.funName);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text(XiaomingLocalizations.of(context).removeUF),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child:
                                Text(XiaomingLocalizations.of(context).delete),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child:
                                Text(XiaomingLocalizations.of(context).cancel),
                            onPressed: () {
                              ud.addUF(u.funName, u.paras, u.funCmds);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              background: Container(
                color: Colors.red,
              ),
              key: Key(u.funName),
              child: Card(
                color: Colors.purple,
                child: new ListTile(
                  leading: new Text(
                    u.funName,
                  ),
                  title: new Text(
                      '${u.funName}(${u.paras.toString().substring(1, u.paras.toString().length - 1)})'),
                  subtitle: new Text(u.funCmds.toString()),
                ),
              ),
            ));
          }
          for (CmdMethod method in UserData.cmdMethods) {
            if (myLocale.countryCode == 'CH') {
              funName = method.name;
              funDescrip = method.methodDescription;
            } else {
              funName = method.ename;
              funDescrip = method.emethodDescription;
            }
            methods.add(Card(
              color: Colors.yellow,
              child: ListTile(
                title: Text(
                  funName,
                ),
                subtitle: Text(funDescrip),
              ),
            ));
          }

          ///添加完分隔线的方法列表
          final List<Widget> divided2 = ListTile.divideTiles(
            context: context,
            tiles: methods,
          ).toList();
          return ListView(
            children: divided2,
          );
        },
      );
    }

    ///标题栏
    final Map<int, Widget> titles = const <int, Widget>{
      0: Text("Data"),
      1: Text("Method"),
    };

    ///内容栏
    Map<int, Widget> lists = <int, Widget>{
      0: CupertinoScrollbar(
        child: _buildDataView(),
      ),
      1: CupertinoScrollbar(
        child: _buildMethodView(),
      )
    };

    ///保存的数据界面布局
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      navigationBar: CupertinoNavigationBar(
        trailing: buildTrailingBar(<Widget>[
          CupertinoButton(
            padding: const EdgeInsets.all(0.0),
            child: Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return NewMethodRoute();
              }));
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          DeleteButton(_handleEmpty),
        ]),
        middle: Text("Saved"),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 90.0,
          ),
          SizedBox(
            width: 500.0,
            child: CupertinoSegmentedControl<int>(
              children: titles,
              onValueChanged: (int newValue) {
                setState(() {
                  _sharedValue = newValue;
                });
              },
              groupValue: _sharedValue,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 450.0,
            width: 350.0,
            child: lists[_sharedValue],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:xiaoming/src/data/appData.dart';
import 'package:xiaoming/src/data/settingData.dart';
import 'package:xiaoming/src/language/xiaomingLocalizations.dart';

//从底部弹出的设置界面
class SettingSheet extends StatefulWidget {
  SettingSheet(this.onPressed);
  final VoidCallback onPressed;
  @override
  _SettingSheetState createState() => _SettingSheetState(onPressed);
}

class _SettingSheetState extends State<SettingSheet> {
  _SettingSheetState(this.onPressed);
  final VoidCallback onPressed;

  Widget _buildSettingCard(Widget child) {
    return SizedBox(
      height: 80.0,
      width: 300.0,
      child: child,
    );
  }

  Widget _buildAndSheet(UserData ud) {
    return SizedBox(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSettingCard(
              Column(
                children: <Widget>[
                  Text(XiaomingLocalizations.of(context).decimalDigits,
                      style: TextStyle(
                        fontFamily: '.SF UI Text',
                        inherit: false,
                        fontSize: 17.0,
                        color: CupertinoColors.black,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Slider(
                        activeColor: Colors.yellow,
                        divisions: 8,
                        max: 9.0,
                        min: 1.0,
                        value: SettingData.fixedNum,
                        onChanged: (double d) {
                          setState(() {
                            SettingData.fixedNum = d;
                          });
                          SettingData.writeSettingData();
                        },
                      ),
                      Text(SettingData.fixedNum.toString()),
                    ],
                  ),
                ],
              ),
            ),
            _buildSettingCard(
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  onPressed();
                },
                child: const Text(
                  "Delete All Message",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildSettingCard(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Theme:  isIOS Theme",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: ud.theme == "IOS",
                    onChanged: (isIOS) {
                      if (isIOS)
                        ud.changeTheme("IOS");
                      else
                        ud.changeTheme("Android");
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //构造ios主题的设置界面
  Widget _buildIOSSheet(UserData ud) {
    return CupertinoActionSheet(
      title: Column(
        children: <Widget>[
          Text(XiaomingLocalizations.of(context).decimalDigits,
              style: TextStyle(
                fontFamily: '.SF UI Text',
                inherit: false,
                fontSize: 17.0,
                color: CupertinoColors.black,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoSlider(
                divisions: 8,
                max: 9.0,
                min: 1.0,
                value: SettingData.fixedNum,
                onChanged: (double d) {
                  setState(() {
                    SettingData.fixedNum = d;
                  });
                  SettingData.writeSettingData();
                },
              ),
              Text(SettingData.fixedNum.toString()),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            onPressed();
          },
          child: const Text("Delete All Message"),
        ),
        CupertinoActionSheetAction(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Theme:  isIOS Theme",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoSwitch(
                value: ud.theme == "IOS",
                onChanged: (isIOS) {
                  if (isIOS)
                    ud.changeTheme("IOS");
                  else
                    ud.changeTheme("Android");
                },
              ),
            ],
          ),
          onPressed: () {},
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<UserData>(builder: (context, child, ud) {
      return ud.theme == "IOS" ? _buildIOSSheet(ud) : _buildAndSheet(ud);
    });
  }
}

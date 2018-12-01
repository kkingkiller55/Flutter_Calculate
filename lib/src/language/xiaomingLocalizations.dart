import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class XiaomingLocalizations {
  final Locale locale;

  XiaomingLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'AppName': 'Computing assistant',
      'Built-in function': 'Built-in function',
      'Setting': 'Setting',
      'Saved function': 'Saved function',
      'Saved Data': 'Saved Data',
      'Solve equation' : 'Solve equation',
      'Solve calculus' : 'Solve calculus',
      'empty' : 'empty',
      'calculate' : 'calculate',
      'InputHint': 'Input command',
      'decimal digits': 'decimal digits',
      'CopyHint': 'The content has been copied to the clipboard',
      'HelpTab1': 'Matrix assignment',
      'HelpTab2': 'function call',
      'HelpTab3': 'self-defining function',
      'HelpTab4': 'Set the decimal number',
      'HelpTabData1':
          'The format of the matrix assignment statement is: a=[1,2,3;4,5,6;7,8,9], the name can consist of letters and numbers, but must start with a letter.'
          'Multiple values for each line are separated by commas, separated by semicolons. Above the input box is a comma and semicolon button for easy entry. The matrix and real numbers are automatically saved to the file, and the data with the same name will be replaced (enter a=2 will also replace the original a=[1,2,3;4,5,6]',
      'HelpTabData2': "The function can be called by entering the function name and its parameters. Example: b=inv(a). Functions can be nested,Example: c=tran(inv(a). The built-in function can also be called in the custom function. There is a button column at the top of the input box to facilitate the input of the function nameClick the button in the upper left corner of the main interface to open the drawer. Click the saved function button in the drawer to open the function introduction interface, which has built-in functions.Details, as well as the user's custom function",
      'HelpTabData3': "Example: Fun test(a,b,c):d=a*b/(b+c);r=factorial(d) A custom function can consist of multiple command statements or a single command statement, multiple command statements Separated by semicolons, the last command is the result of the function. The custom function will be saved in the file for the next time, and the custom function with the same name will only retain the newly defined function. The custom function name cannot be the name of a built-in function. Pass in the argument when calling the custom function, for example: test(3,2,-1). Note: The factorial function used in the example automatically rounds the fractional part to an integer and then multiplies the factorial.",
      'HelpTabData4': 'Click the Settings button in the drawer interface to jump to the settings interface, and slide the slider to select the number of decimals to the decimal point.',
    },
    'zh': {
      'AppName': '计算小助手',
      'Built-in function': '内置的函数',
      'Setting': '设置',
      'Saved function': '保存的函数',
      'Saved Data': '保存的数据',
      'Solve equation' : '解方程',
      'Solve calculus' : '解微积分',
      'empty' : '清空',
      'calculate' : '计算',
      'InputHint': '输入命令',
      'decimal digits': '小数保留位数',
      'CopyHint': '内容已复制到剪切板',
      'HelpTab1': '矩阵赋值',
      'HelpTab2': '函数调用',
      'HelpTab3': '自定义函数',
      'HelpTab4': '设置小数位数',
      'HelpTabData1': '矩阵赋值的语句格式为：a=[1,2,3;4,5,6;7,8,9],'
          ' 名称可以由字母和数字组成,但必须以字母开头。'
          '每一行的多个值用逗号分隔开，行之间用分号分隔开。输入框的上方有方便输入的'
          '逗号和分号按钮。矩阵和实数会自动保存到文件，同名的数据会被替换（输入a=2也会替换'
          '原有的a=[1,2,3;4,5,6])',
      'HelpTabData2': '输入函数名及其参数即可调用函数。例：b=inv(a).函数可以嵌套调用，'
          '例：c=tran(inv(a)。在自定义函数中也可以调用内置函数，输入框的上方有方便输入函数名的按钮列'
          '点击主界面左上角的按钮可以打开抽屉，点击抽屉中的保存的函数按钮可以打开函数介绍界面，里面有内置函数的'
          '详细介绍，还有用户的自定义函数',
      'HelpTabData3':
          '示例： Fun test(a,b,c):d=a*b/(b+c);r=factorial(d)自定义函数可以由多个命令语句或单个命令语句组成，多个命令语句之间用'
          '分号分隔开，最后一条命令为函数的返回结果。自定义函数会保存在文件中，方便下次使用，同名的自定义函数只会保留最新定义的'
          '那个函数。自定义函数名不能为内置函数的名称。在调用自定义函数时传入参数， 例：test(3,2,-1)。注：示例中使用到的阶乘函数'
          '会自动将小数部分四舍五入成整数再求阶乘。',
      'HelpTabData4': '在抽屉界面中点击设置按钮可以跳转到设置界面，滑动滑块选择保留小数到小数点后第几位',
    }
  };

  get AppName {
    return _localizedValues[locale.languageCode]['AppName'];
  }

  get Built_in_function {
    return _localizedValues[locale.languageCode]['Built-in function'];
  }

  get Setting {
    return _localizedValues[locale.languageCode]['Setting'];
  }

  get Saved_function {
    return _localizedValues[locale.languageCode]['Saved function'];
  }

  get Saved_Data {
    return _localizedValues[locale.languageCode]['Saved Data'];
  }

  get Solve_equation {
    return _localizedValues[locale.languageCode]['Solve equation'];
  }

  get Solve_calculus {
    return _localizedValues[locale.languageCode]['Solve calculus'];
  }

  get empty {
    return _localizedValues[locale.languageCode]['empty'];
  }

  get calculate {
    return _localizedValues[locale.languageCode]['calculate'];
  }

  get InputHint {
    return _localizedValues[locale.languageCode]['InputHint'];
  }

  get decimal_digits {
    return _localizedValues[locale.languageCode]['decimal digits'];
  }

  get CopyHint {
    return _localizedValues[locale.languageCode]['CopyHint'];
  }

  get HelpTab1 {
    return _localizedValues[locale.languageCode]['HelpTab1'];
  }
  get HelpTab2 {
    return _localizedValues[locale.languageCode]['HelpTab2'];
  }
  get HelpTab3 {
    return _localizedValues[locale.languageCode]['HelpTab3'];
  }
  get HelpTab4 {
    return _localizedValues[locale.languageCode]['HelpTab4'];
  }
  get HelpTabData1 {
    return _localizedValues[locale.languageCode]['HelpTabData1'];
  }
  get HelpTabData2 {
    return _localizedValues[locale.languageCode]['HelpTabData2'];
  }
  get HelpTabData3 {
    return _localizedValues[locale.languageCode]['HelpTabData3'];
  }
  get HelpTabData4 {
    return _localizedValues[locale.languageCode]['HelpTabData4'];
  }

  static XiaomingLocalizations of(BuildContext context) {
    return Localizations.of(context, XiaomingLocalizations);
  }
}

class XiaomingLocalizationsDelegate
    extends LocalizationsDelegate<XiaomingLocalizations> {
  const XiaomingLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<XiaomingLocalizations> load(Locale locale) {
    // TODO: implement load
    return new SynchronousFuture<XiaomingLocalizations>(
        new XiaomingLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<XiaomingLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

  static XiaomingLocalizationsDelegate delegate =
      const XiaomingLocalizationsDelegate();
}
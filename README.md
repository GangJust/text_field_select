# text_field_select

- 基本使用:

```dart
/// final selectList = ["西瓜", "苹果", "香蕉", "桃子", "火龙果", "榴莲", "荔枝", "梨"];

TextFieldSelect(
    inputDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "请选择一项",
    ),
    onSelected: (controller, index) {
        controller.text = selectList[index];
        controller.selection = TextSelection(
            baseOffset: controller.text.length,
            extentOffset: controller.text.length,
        );
    },
    onShowing: (text) {
        List<int> indexes = [];
        var index = 0;
        for (var value in selectList) {
            if (value.contains(text)) indexes.add(index);
            index++;
        }
        return indexes;
    },
    itemCount: selectList.length,
    itemBuilder: (ctx, index) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(selectList[index]),
        );
    },
)
```

- 方法说明：

```dart
/// 选择回调，参数分别为：
/// TextEditingController, index
/// 文本框： controller, 选中列表项： index
void onSelected:(controller, index){
    ...
}

/// 预备展示的选项下标集合，默认为所有选项[itemCount]。
/// 以上例做说明，若返回的下标集合为：[0,1,3]
/// 则只展示：["西瓜", "苹果", "桃子"]
List<int> onShowing: (text) {
    ...
}
```

- 具体示例：

```dart
import 'package:flutter/material.dart';
import 'package:text_field_select/text_field_select.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectList = ["西瓜", "苹果", "香蕉", "桃子", "火龙果", "榴莲", "荔枝", "梨"];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: Theme.of(context).textTheme.titleMedium,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "文本框",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldSelect(
                inputDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "请选择一项",
                ),
                onSelected: (controller, index) {
                  controller.text = selectList[index];
                  controller.selection = TextSelection(
                    baseOffset: controller.text.length,
                    extentOffset: controller.text.length,
                  );
                },
                onShowing: (text) {
                  List<int> indexes = [];
                  var index = 0;
                  for (var value in selectList) {
                    if (value.contains(text)) indexes.add(index);
                    index++;
                  }
                  return indexes;
                },
                itemCount: selectList.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(selectList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```


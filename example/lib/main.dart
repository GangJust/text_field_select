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

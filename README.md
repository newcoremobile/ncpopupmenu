# ncpopupmenu

> Flutter 弹出菜单

### 效果:

### ![popupmenu](README.assets/popupmenu.gif)

### 使用：

```dart
FlatButton(
              key: _actionMoreKey,
              child: Icon(Icons.more_horiz),
              onPressed: () {
                //弹出菜单
                ncShowPopupMenu(context, anchorViewKey: _actionMoreKey,
                    onMenuItemTap: (value) {
                  print("Select menu item value: $value");
                }, menuItems: [
                  NCMenuItem.textWithIcon(
                    value: "menu1",
                    icon: Icon(Icons.edit),
                    text: Text(
                      '编辑',
                    ),
                  ),
                  NCMenuItem.textWithIcon(
                    value: "menu2",
                    icon: Icon(Icons.delete),
                    text: Text('删除日志'),
                  ),
                ]);
              },
            )
```

# License

```
Licensed under the MIT License

Copyright (c) 2019 YoungChan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

```
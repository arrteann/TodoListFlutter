import 'package:flutter/material.dart';

void main() => runApp(new myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: new todoList(items: <Products>[
        Products(name: 'Create App'),
        Products(name: 'Uploads File'),
        Products(name: 'Record Tutorial')
      ]),
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(color: Color.fromRGBO(38, 50, 56, 1)),
      ),
    );
  }
}

// Products Method
class Products {
  final String name;
  Products({this.name});
}

class todoList extends StatefulWidget {
  final List<Products> items;
  todoList({this.items});
  @override
  State<StatefulWidget> createState() => todoListState();
}

// typedef void ChangeType(Products items,bool inTask);

class todoListState extends State<todoList> {
  List<Products> todoWork = List<Products>();
  // Methods For Check Tasks
  void handleCheck(Products items, bool inTask) {
    setState(() {
      if (inTask) {
        todoWork.remove(items);
      } else {
        todoWork.add(items);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: new ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
        children: widget.items.map((Products items) {
          return todoListItems(
            items: items,
            inTask: todoWork.contains(items),
            onChangeTask: handleCheck,
          );
        }).toList(),
      ),
    );
  }
}

class todoListItems extends StatelessWidget {
  final Products items;
  final bool inTask;
  final onChangeTask;
  todoListItems({this.items, this.inTask, this.onChangeTask});
  // Change color
  Color getColor(BuildContext context) {
    return inTask ? Colors.black54 : Theme.of(context).primaryColorLight;
  }

  // Change Line Text
  TextStyle getStyle(BuildContext context) {
    if (inTask) {
      return TextStyle(
          decoration: TextDecoration.lineThrough, color: Colors.black54);
    } else {
      return null;
    }
  }
  // Hide Avatar
  CircleAvatar hideAvatar(BuildContext context){
    return inTask ? null : CircleAvatar(backgroundColor: getColor(context),child: new Text(items.name[0]),);
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(
        items.name,
        style: getStyle(context),
      ),
      leading:hideAvatar(context),
      onTap: () {
        print(inTask);
        onChangeTask(items, inTask);

      },
    );
  }
}

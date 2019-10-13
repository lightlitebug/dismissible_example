import 'package:dismissible_ex/saved_items.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dissmissible Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = List.generate(30, (i) => 'Item ${i + 1}');
  final List<String> savedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismissible Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return SavedItems(savedItems);
              }));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                print('DELETED');
                setState(() {
                  items.removeAt(index);
                });
              }
              if (direction == DismissDirection.startToEnd) {
                print('SAVED');
                setState(() {
                  savedItems.add(items[index]);
                  items.removeAt(index);
                });
              }
            },
            confirmDismiss: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Now I am deleting ${items[index]}'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('CANCEL'),
                            onPressed: () {
                              return Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('DELETE'),
                            onPressed: () {
                              return Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    });
              } else if (direction == DismissDirection.startToEnd) {
                return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Now saving ${items[index]}'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('CANCEL'),
                            onPressed: () {
                              return Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('SAVE'),
                            onPressed: () {
                              return Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    });
              }
              return Future.value(false);
            },
            background: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.green,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.save,
                size: 36,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                size: 36,
                color: Colors.white,
              ),
            ),
            child: Card(
              margin: EdgeInsets.all(8),
              elevation: 8,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${items[index].split(' ')[1]}'),
                ),
                title: Text(
                  items[index],
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text('${items[index]} draggable'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          );
        },
      ),
    );
  }
}

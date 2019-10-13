import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  final List<String> savedItems;

  SavedItems(this.savedItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${savedItems.length} items saved'),
      ),
      body: savedItems.length == 0
          ? Center(
              child: Text(
                'No items saved',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 8,
                  child: ListTile(
                    title: Text(savedItems[index]),
                  ),
                );
              },
            ),
    );
  }
}

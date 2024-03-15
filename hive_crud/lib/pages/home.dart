import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

  // reference for box
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // load data when app restarts
  }

  void _refreshItems() {
    final data = _myBox.keys.map((key) {
      final item = _myBox.get(key);
      return {
        'key': key,
        'name': item['name'],
        'quantity': item['quantity'],
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList(); // reverse to get the latest ones
    });
  }

  // create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _myBox.add(newItem); // automatic key 0, 1, 2, 3, ...
    _refreshItems();
  }

  // update the item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _myBox.put(itemKey, item);
    _refreshItems(); // update UI
  }

  // delete an item
  Future<void> _deleteItem(int itemKey) async {
    // ask user if they are sure to delete
    final isSure = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Do you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (isSure == true) {
      await _myBox.delete(itemKey);
      _refreshItems(); // update UI
    }
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    // if itemKey is not null, then it's an edit
    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _quantityController.text = existingItem['quantity'].toString();
    }

    showModalBottomSheet(
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // if item key is null, put data to hive
                if (itemKey == null) {
                  _createItem({
                    'name': _nameController.text,
                    'quantity': int.parse(_quantityController.text),
                  });
                }

                // if item key is not null, then it's an edit
                if (itemKey != null) {
                  _updateItem(itemKey, {
                    'name': _nameController.text,
                    'quantity': int.parse(_quantityController.text),
                  });
                }

                // clear the text fields
                _nameController.clear();
                _quantityController.clear();

                Navigator.of(context).pop(); // close the bottom sheet
              },
              child: Text(itemKey == null ? 'Create New' : 'Update'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hive'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) {
            final currentItem = _items[index];
            return Card(
              color: Theme.of(context).colorScheme.background,
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                title: Text(currentItem['name']),
                subtitle: Text('Quantity: ${currentItem['quantity']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // edit button
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(context, currentItem['key']),
                    ),

                    // delete button
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteItem(currentItem['key']),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showForm(context, null),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

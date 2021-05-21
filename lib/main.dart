import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Bar',
      home: SearchBar(),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Bar')),
      body: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<String> item;
  List<String> data = List.generate(50, (index) => 'item ${index + 1}');

  @override
  void initState() {
    item = data;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          onchanged: (query) {
            setState(() {
              item = data.where((element) {
                final String lower = element.toLowerCase();
                final String upper = element.toUpperCase();

                return lower.contains(query) || upper.contains(query);
              }).toList();
            });
          },
        ),
        Expanded(
          child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) => ListTile(
                    title: Center(child: Text('${item[index]}')),
                  )),
        ),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final ValueSetter onchanged;
  const MyTextField({
    @required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onchanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search',
          hintText: 'Enter an item name',
        ),
      ),
    );
  }
}

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

class MyTextField extends StatefulWidget {
  final ValueSetter onchanged;
  const MyTextField({
    @required this.onchanged,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        onChanged: widget.onchanged,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      controller.clear();
                      widget.onchanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                ),
          border: OutlineInputBorder(),
          labelText: 'Search',
          hintText: 'Enter an item name',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  List<String> names = [];
  getNameData() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      names = pref.getStringList('names') ?? [];
    });
  }

  setNameData(String nameAdd) async {
    var pref = await SharedPreferences.getInstance();
    names.add(nameAdd);
    await pref.setStringList('names', names);
    getNameData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNameData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter some-text'),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: names.isEmpty
                ? const Center(
                    child: Text('Data is empty....'),
                  )
                : ListView.builder(
                    itemCount: names.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 0,
                      child: ListTile(
                        title: Text(names[index]),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (nameController.text.isNotEmpty) {
            await setNameData(nameController.text);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please input data...'),
            ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

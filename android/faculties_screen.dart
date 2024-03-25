import 'dart:convert';

import 'package:flutter/material.dart';
import 'groups_screen.dart'; // Импортируем файл с экраном групп
import 'package:http/http.dart' as http;

class FacultiesScreen extends StatefulWidget {
  @override
  _FacultiesScreenState createState() => _FacultiesScreenState();
}

Future<List<String>> fetchFaculties() async {
  var url = Uri.parse('http://C:/xampp/123/htdocs/api.php');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<String> faculties = jsonDecode(response.body);
    return faculties;
  } else {
    throw Exception('Failed to fetch faculties');
  }
}

class _FacultiesScreenState extends State<FacultiesScreen> {

  List<String> faculties = ['Faculty 1', 'Faculty 2'];

  @override
  void initState() {
  super.initState();
  fetchData(); // Вызов функции для загрузки данных о факультетах
  }

  void fetchData() async {
  try {
  List<String> fetchedFaculties = await fetchFaculties();
  setState(() {
  faculties = fetchedFaculties;
  });
  } catch (e) {
  print('Error fetching faculties: $e');
  }
  }

  void addFaculty(String facultyName) {
  setState(() {
  faculties.add(facultyName);
  });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: Text('Faculties')),
  body: ListView.builder(
  itemCount: faculties.length,
  itemBuilder: (context, index) {
  return ListTile(
  title: Text(faculties[index]),
  onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context) => GroupsScreen()));
  },
  );
  },
  ),
  floatingActionButton: FloatingActionButton(
  onPressed: () {
  showDialog(
  context: context,
  builder: (context) {
  String facultyName = '';
  return AlertDialog(
  title: Text('Add Faculty'),
  content: TextField(
  onChanged: (value) {
  facultyName = value;
  },
  ),
  actions: <Widget>[
  TextButton(
  onPressed: () {
  Navigator.pop(context);
  },
  child: Text('Cancel'),
  ),
  ElevatedButton(
  onPressed: () {
  if (facultyName.isNotEmpty) {
  addFaculty(facultyName);
  Navigator.pop(context);
  }
  },
  child: Text('Add'),
  ),
  ],
  );
  },
  );
  },
  child: Icon(Icons.add),
  ),
  );
  }
  }

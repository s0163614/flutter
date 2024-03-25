import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {

  List<Student> students = [
  Student(name: 'John Doe', email: 'john.doe@example.com', phoneNumber: '1234567890', age: 25),
  Student(name: 'Jane Smith', email: 'jane.smith@example.com', phoneNumber: '9876543210', age: 22),
  ];

  void addStudent(String name, String email, String phoneNumber, int age) {
  setState(() {
  students.add(Student(name: name, email: email, phoneNumber: phoneNumber, age: age));
  });
  }

  void viewStudentDetails(Student student) {
  showDialog(
  context: context,
  builder: (context) {
  return AlertDialog(
  title: Text('Student Details'),
  content: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
  Text('Name: ${student.name}'),
  Text('Email: ${student.email}'),
  Text('Phone Number: ${student.phoneNumber}'),
  Text('Age: ${student.age}'),
  ],
  ),
  );
  },
  );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: Text('Students')),
  body: ListView.builder(
  itemCount: students.length,
  itemBuilder: (context, index) {
  return ListTile(
  title: Text(students[index].name),
  onLongPress: () {
  viewStudentDetails(students[index]);
  },
  );
  },
  ),
  floatingActionButton: FloatingActionButton(
  onPressed: () {
  showDialog(
  context: context,
  builder: (context) {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String age = '';
  return AlertDialog(
  title: Text('Add Student'),
  content: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
  TextField(
  decoration: InputDecoration(labelText: 'Name'),
  onChanged: (value) {
  name = value;
  },
  ),
  TextField(
  decoration: InputDecoration(labelText: 'Email'),
  onChanged: (value) {
  email = value;
  },
  ),
  TextField(
  decoration: InputDecoration(labelText: 'Phone Number'),
  onChanged: (value) {
  phoneNumber = value;
  },
  ),
  TextField(
  decoration: InputDecoration(labelText: 'Age'),
  onChanged: (value) {
  age = value;
  },
  ),
  ],
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
  if (name.isNotEmpty && email.isNotEmpty && phoneNumber.isNotEmpty && age.isNotEmpty) {
  addStudent(name, email, phoneNumber, int.parse(age));
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


class Student {
  String name;
  String email;
  String phoneNumber;
  int age;

  Student({required this.name, required this.email, required this.phoneNumber, required this.age});
}
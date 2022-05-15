import 'package:flutter/material.dart';
import 'package:nav_app/NestedPages/AssignHolder.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  int? selectedId;
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 164, 219),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        title: Text(
          "Enter Info & Press the Eye",
          style: TextStyle(color: Color.fromARGB(255, 68, 3, 80)),
        ),
        leading: Icon(Icons.home, color: Color.fromARGB(255, 68, 3, 80)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 81, 6, 94),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_label), label: "Multimedia"),
          BottomNavigationBarItem(
              icon: Icon(Icons.data_object), label: "States Database")
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/videos');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/about');
          }
        },
        currentIndex: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/463.jpg'), fit: BoxFit.fill)),
        child: Stack(
          children: [
            Inputfields(),
            Positioned(right: 9, bottom: 10, child: Assignments()),
            Positioned(
              right: 57,
              top: 50,
              child: FloatingActionButton.small(
                onPressed: () {
                  setState(() {
                    DatabaseHelper.instance.add(Queries(
                        name: title.text, detail: subtitle.text, isDone: 0));
                    title.clear();
                    subtitle.clear();
                  });
                },
                child: Text(""),
                backgroundColor: Color.fromARGB(0, 119, 5, 172),
              ),
            )
          ],
        ),
      ));

  Widget Inputfields() => Row(
        children: [
          Flexible(
            flex: 4,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.purple),
                  textInputAction: TextInputAction.done,
                  controller: title,
                  decoration: const InputDecoration(
                      hintText: "Enter Title...",
                      hintStyle: TextStyle(color: Colors.purple),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 3)),
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.purple),
                  textInputAction: TextInputAction.done,
                  controller: subtitle,
                  decoration: const InputDecoration(
                      hintText: "Enter Detail...",
                      hintStyle: TextStyle(color: Colors.purple),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 3)),
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              )
            ]),
          ),
          Flexible(flex: 2, child: SizedBox())
        ],
      );
}

class Assignments extends StatefulWidget {
  const Assignments({Key? key}) : super(key: key);

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  TextStyle listStyle = TextStyle(
      color: Color.fromARGB(255, 198, 96, 216), fontWeight: FontWeight.bold);
  TextStyle selectedStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      height: MediaQuery.of(context).size.height / 1.7,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(106, 155, 39, 176),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            color: Color.fromARGB(155, 0, 0, 0),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(children: const [
              Icon(
                Icons.task,
                size: 40,
                color: Color.fromARGB(255, 120, 1, 175),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Assignments",
                style: TextStyle(
                    color: Color.fromARGB(255, 120, 1, 175),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              )
            ]),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(
              color: Color.fromARGB(255, 120, 1, 175),
              width: 2,
            )),
            child: FutureBuilder<List<Queries>>(
              future: DatabaseHelper.instance.getQueries(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Queries>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ));
                }
                return snapshot.data!.isEmpty
                    ? Center(
                        child: Text("No Queries",
                            style: TextStyle(
                                color: Color.fromARGB(255, 163, 76, 179))),
                      )
                    : ListView(
                        children: snapshot.data!.map((query) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (DismissDirection direction) {
                                DatabaseHelper.instance.remove(query.id!);
                              },
                              child: ListTile(
                                onLongPress: () {
                                  setState(() {
                                    DatabaseHelper.instance.update(Queries(
                                        id: query.id,
                                        name: query.name,
                                        detail: query.detail,
                                        isDone: query.isDone == 0 ? 1 : 0));
                                  });
                                },
                                title: Text(
                                  query.name,
                                  style: query.isDone == 0
                                      ? listStyle
                                      : selectedStyle,
                                ),
                                subtitle: Text(query.detail,
                                    style: query.isDone == 0
                                        ? listStyle
                                        : selectedStyle),
                                trailing: query.isDone == 0
                                    ? Icon(
                                        Icons.check_box_outline_blank,
                                        color:
                                            Color.fromARGB(255, 198, 96, 216),
                                      )
                                    : Icon(
                                        Icons.check_box,
                                        color: Colors.white,
                                      ),
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Icon(
                                    Icons.donut_small,
                                    color: query.isDone == 0
                                        ? Color.fromARGB(255, 198, 96, 216)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Queries {
  final int? id;
  final String name;
  final String detail;
  final int isDone;

  Queries(
      {this.id,
      required this.name,
      required this.detail,
      required this.isDone});

  factory Queries.fromMap(Map<String, dynamic> json) => Queries(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      isDone: json['isDone']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'detail': detail, 'isDone': isDone};
  }
}

class DatabaseHelper {
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  static Database? database;
  Future<Database> get mydatabase async => database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'queryTable.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE queryTable(
        id INTEGER PRIMARY KEY,
        name TEXT,
        detail TEXT,
        isDone INTEGER
       )''');
  }

  Future<List<Queries>> getQueries() async {
    Database db = await instance.mydatabase;
    var queries = await db.query('queryTable', orderBy: 'name');
    List<Queries> queryList = queries.isNotEmpty
        ? queries.map((c) => Queries.fromMap(c)).toList()
        : [];
    return queryList;
  }

  Future<int> add(Queries queries) async {
    Database db = await instance.mydatabase;
    return await db.insert('queryTable', queries.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.mydatabase;
    return await db.delete('queryTable', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(Queries queries) async {
    Database db = await instance.mydatabase;
    return await db.update('queryTable', queries.toMap(),
        where: 'id==?', whereArgs: [queries.id]);
  }

  Future deletedb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'queryTable.db');
    await deleteDatabase(path);
  }

  Future dropTable() async {
    Database db = await instance.mydatabase;
    await db
        .transaction((txn) => txn.execute('DROP TABLE IF EXISTS queryTable'));
  }
}

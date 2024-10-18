import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'digimon_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Digimon> digimons = [];

  Future<void> fetchDigimons() async {
    final response =
    await http.get(Uri.parse('https://digimon-api.vercel.app/api/digimon'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        digimons = data.map((json) => Digimon.fromJson(json)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDigimons();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digimon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'DIGIMONS',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView.builder(
          itemCount: digimons.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {
                  final snackBar = SnackBar(
                    content: Text(digimons[index].name),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          digimons[index].image,
                          height: 80,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              digimons[index].name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              digimons[index].level,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

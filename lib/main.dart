import 'dart:convert';

import 'package:api_try_get_data/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<PostModel> listModel = [];

  Future<List<PostModel>> getDataFromServer() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    //response.body brings the whole json data
    //jsonDecode brings the key value pair format
    // Json decode =  covert json to  Map  // Json encode = covert  Map to Json

    var data = jsonDecode(response.body.toString());

    for (Map i in data) {
      listModel.add(PostModel.fromJson(i));
    }

    return listModel;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('appbarTitle'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // without expanded layout can't fixing the size of the screen  thus  title is not showing
                Expanded(
                  child: FutureBuilder(
                      future: getDataFromServer(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Center(
                          child: ListView.builder(
                              itemCount: listModel.length,
                              itemBuilder: (context, index) {
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    listModel[index].title.toString(),
                                    style: const TextStyle(
                                        color: Colors.deepOrange, fontSize: 20),
                                  ),
                                ));
                              }),
                        );
                      }),
                )
              ],
            ),
          )),
    );
  }
}

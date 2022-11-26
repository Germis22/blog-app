// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_test/router/app_routes.dart';
// import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List? data;
  List? postsData;
  List? commentsData;
  var newPost;
  List nuevosPosts = [
    {
      "userId": 1,
      "id": 101,
      "title": "Titulo 101",
      "body": "Cuerpo 101",
    },
    {
      "userId": 1,
      "id": 102,
      "title": "Titulo 102",
      "body": "Cuerpo 102",
    },
    {
      "userId": 2,
      "id": 103,
      "title": "Titulo 103",
      "body": "Cuerpo 103",
    },
    {
      "userId": 2,
      "id": 104,
      "title": "Titulo 104",
      "body": "Cuerpo 104",
    },
    {
      "userId": 3,
      "id": 105,
      "title": "Titulo 105",
      "body": "Cuerpo 105",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchData();
    fetchPosts();
    fetchComments();
  }

  // Future fetchData() async {
  //   var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     data = json.decode(response.body);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     print('error');
  //   }
  // }

  Future fetchPosts() async {
    Response response;
    var dio = Dio();
    var url = 'https://jsonplaceholder.typicode.com/posts';
    response = await dio.get(url);
    if (response.statusCode == 200) {
      postsData = response.data;
      setState(() {
        isLoading = false;
      });
      print(postsData);
    } else {
      print('error');
    }
  }

  Future fetchComments() async {
    Response response;
    var dio = Dio();
    var url = 'https://jsonplaceholder.typicode.com/comments';
    response = await dio.get(url);
    if (response.statusCode == 200) {
      commentsData = response.data;
      setState(() {
        isLoading = false;
      });
      print(commentsData);
    } else {
      print('error');
    }
  }

  addPost() async {
    Response response;
    var dio = Dio();
    var url = 'https://jsonplaceholder.typicode.com/posts';
    response = await dio.post(url, data: {
      "userId": newPost['userId'],
      "title": newPost['title'].toString(),
      "body": newPost['description'].toString(),
    });
    if (response.statusCode == 201) {
      postsData = [...?postsData, response.data];
      setState(() {});
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // List totalData = [...?data, ...nuevosPosts];
    // List totalPosts = [...?postsData, ...nuevosPosts];
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
        title: Text('Blog'.toUpperCase()),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: postsData == null ? 0 : postsData?.length,
              // itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.blue[300],
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric( vertical: 15),
                    child: SizedBox(
                      width: 200,
                      height: 180,
                      child: ListTile(
                        leading: Card(
                          color: Colors.amber[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Text(postsData![index]['userId'].toString(),
                                style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                        ),
                        title: Text(postsData![index]['title'],
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text(postsData![index]['body']),
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.comments,
                              arguments: postsData![index]['id']);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[800],
        onPressed: () async {
          final newPostValues = await Navigator.pushNamed(
              context, AppRoutes.newPost,
              arguments: addPost);
          setState((){
            newPost = newPostValues;
          });
          if (newPost != null) {
            addPost();
          }
          print(newPost);
        },
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }
}

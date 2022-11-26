import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_test/models/comments.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool isLoading = true;
  List? commentsData;
  late final postId = ModalRoute.of(context)!.settings.arguments as int;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchComments();
  }

  Future fetchComments() async {
    Response response;
    var dio = Dio();
    var url = 'https://jsonplaceholder.typicode.com/comments';
    response = await dio.get(url);
    if (response.statusCode == 200) {
      commentsData = response.data.where((element) => element['postId'] == postId).toList();
      setState(() {
        isLoading = false;
      });
      print(commentsData);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
        title: Text('Comments: Post $postId'.toUpperCase()),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: commentsData!.isEmpty ? 1 : commentsData?.length,
              // itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                if (commentsData!.isEmpty) {
                  return const Center(child: Text('No comments to show', style: TextStyle(fontSize: 20)));
                } else {
                  return Card(
                    color: Colors.amber[600],
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        child: ListTile(
                          title: Text(commentsData![index]['name'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Text(commentsData![index]['body']),
                        ),
                      ),
                    ),
                  );
                }             
              },
            ),
    );
  }
}

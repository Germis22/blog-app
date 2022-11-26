import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
   
  const NewPostScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController userIdController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
        title: Text('New Post'.toUpperCase()),
      ),
      body: Center(
         child: Form(key: _formKey,child: FormField(builder: (state) {
           return Column(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        hintText: 'Post title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !RegExp(r'[a-z A-Z]+$').hasMatch(value)) {
                          return 'Use only letters';
                          
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description of the post',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a description';
                          
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: userIdController,
                      decoration: const InputDecoration(
                        labelText: 'User ID',
                        hintText: 'User ID',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !RegExp(r'[1-9]+$').hasMatch(value)) {
                          return 'Use only numbers';
                          
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
               ),
               ElevatedButton(
                 onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop({
                        'title': titleController.text, 
                        'description': descriptionController.text, 
                        'userId':userIdController.text
                      });
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post submitted successfully')),
                      );
                    }
                 },
                 child: const Text('Save'),
                 style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue[800]),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40)
                  ),
                ),
               ),
             ],
           );
         })),
      ),
    );
  }
}
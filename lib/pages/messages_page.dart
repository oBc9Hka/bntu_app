import 'package:bntu_app/models/error_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color.fromARGB(255, 0, 138, 94);
    ErrorMessage _errorMessage = ErrorMessage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Сообщения об ошибках'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('errorMessages')
                .orderBy('added', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
                );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    QueryDocumentSnapshot<Object?> item =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        key: Key(item.id),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color:
                                  item.get('viewed') ? Colors.grey : mainColor),
                        ),
                        onTap: () {
                          _errorMessage.changeViewedState(item.id);
                          Fluttertoast.showToast(msg: 'Прочитано');
                        },
                        title: Text(item.get('message')),
                        trailing: IconButton(
                          onPressed: () {
                            _errorMessage.removeErrorMessage(item.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

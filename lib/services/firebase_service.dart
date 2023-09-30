import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxController{
  
  FirebaseService(){
    getDB();
  }

  List docsList = [];
  
  void getDB() async{
    QuerySnapshot snap = await 
    FirebaseFirestore.instance.collection('Tasks').get();
    for (var document in snap.docs) {
          docsList.add(document.id);
        }
  }

  void addNew(String collection,String data) async{
    await FirebaseFirestore.instance.collection(collection).add(
      {
        'content': data,
        'time': "00:00:00"
      }
    );
  }


}
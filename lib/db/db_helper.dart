import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const String collectionAdmin = 'Admins';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    // document id get korse
    // collection er upor get method call korle pabo querysnapshot
    // documeent er upor get method call korle pabo document snapshot
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();

// documentId jodi thake thaole return koro true
    return snapshot.exists;
  }
}

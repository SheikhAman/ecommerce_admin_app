import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_day_42/models/category_model.dart';

class DBHelper {
  static const String collectionAdmin = 'Admins';

  static const String collectionCategories = 'Categories';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    // document id get korse
    // collection er upor get method call korle pabo querysnapshot
    // documeent er upor get method call korle pabo document snapshot
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();

// documentId jodi thake thaole return koro true
    return snapshot.exists;
  }

// category collection e notun collection add korar query
  static Future<void> addNewCategory(CategoryModel categoryModel) {
    final doc = _db.collection(collectionCategories).doc();
    categoryModel.catId = doc.id;
    return doc.set(categoryModel.toMap());
  }

// category collection e notun collection get korar query
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategory() =>
      _db.collection(collectionCategories).snapshots();
}

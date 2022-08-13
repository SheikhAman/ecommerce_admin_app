import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_day_42/models/category_model.dart';
import 'package:ecom_day_42/models/product_model.dart';
import 'package:ecom_day_42/models/purchase_model.dart';

class DBHelper {
  static const String collectionAdmin = 'Admins';
  static const String collectionCategories = 'Categories';
  static const String collectionProduct = 'Products';
  static const String collectionPurchase = 'Purchase';
  static const String collectionUser = 'User';
  static const String collectionOrder = 'Order';
  static const String collectionDetails = 'OrderDetails';
  static const String collectionSettings = 'Settings';
  static const String documentConstant = 'orderConstant';

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

// notun akta document e productModel dhukbe -> insert
// notun areak document e purchaseModel dhukbe -> insert
// catId je document ache tar vitore  je count namer field ache seta update hobe -> update
// kokhono jodi amun hoi akta table e data dhuklo arek table ba data dhuklo na tai amra batch  operation kori
// batch operation  -> amake insure korte hobe 3ta  query jate execute hoi jodi  kono akta fail hoi tahole baki 2ta o fail korbe
// prothom e writebatch er object create korbo example wb
// commit method call korle se tar kaj kora suru kore dei. query gulo step by step kora suru kore
  static Future<void> addProduct(ProductModel productModel,
      PurchaseModel purchaseModel, String catId, num count) {
    final wd = _db.batch(); // batch operation er object create korsi
    final proDoc =
        _db.collection(collectionProduct).doc(); // document create korlam
    final purDoc =
        _db.collection(collectionPurchase).doc(); // document create korlam
    final catDoc = _db
        .collection(collectionCategories)
        .doc(catId); // ai doc e update query chalabo

    productModel.id = proDoc.id; // model er field e docment id set koralam
    purchaseModel.id = purDoc.id; // model er field e docment id set koralam
    purchaseModel.productID =
        proDoc.id; // model er field e docment id set koralam

// wb.set mane se future e data save korbe databaase e
    wd.set(
        proDoc, productModel.toMap()); // document e map akare data save korlam
    wd.set(purDoc, purchaseModel.toMap());
    wd.update(catDoc, {
      'productCount': count
    }); // batch operation e ami document id ar je value update kormu map seta disi

    return wd.commit();
  }

// category collection e notun collection get korar query
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategory() =>
      _db.collection(collectionCategories).snapshots();

// collection product  er  notun collection get korar query
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

// getting productInfo from id using  this query
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(
          String id) =>
      _db.collection(collectionProduct).doc(id).snapshots();

// product er id diye purchase er collection get kora
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPurchaseByProductId(
          String pid) =>
      // sob productId er shate match korle purchaseId snapshot pathabe
      // onkegulo where method ak shate use korte pari
      // purchase er collection pabo akta specific product er
      // product er id jodi collectionPurchase er id er equal hoi tahole sob gulo docId pabo
      _db
          .collection(collectionPurchase)
          .where(productId, isEqualTo: pid)
          .snapshots();

  // common update method for product Details page
  static Future<void> updateProduct(String id, Map<String, dynamic> map) {
    return _db.collection(collectionProduct).doc(id).update(map);
  }
}

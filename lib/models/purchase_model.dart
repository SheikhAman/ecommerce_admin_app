import 'package:ecom_day_42/models/date_model.dart';

const String purchaseId = "id";
const String purchaseProductId = "productId";
const String purchaseDateModel = "dateModel";
const String purchasePrice = "price";
const String purchaseQuantity = "quantity";

class PurchaseModel {
  String? id;
  String? productID;
  DateModel dateModel;
  num purchaseprice;
  num quantity;

  PurchaseModel({
    this.id,
    this.productID,
    required this.dateModel,
    required this.purchaseprice,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      purchaseId: id,
      purchaseProductId: productID,
      //database e object ke  map a convert kore rakhlam
      purchaseDateModel: dateModel.toMap(),
      purchasePrice: purchaseprice,
      purchaseQuantity: quantity,
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
      // field : map[key]
      id: map[purchaseId],
      productID: map[purchaseProductId],
      // dateModel Object : dateModel er map ke object e convert korte hobe
      dateModel: DateModel.fromMap(map[purchaseDateModel]),
      purchaseprice: map[purchasePrice],
      quantity: map[purchaseQuantity]);

  @override
  String toString() {
    // TODO: implement toString
    return 'PurchaseModel{purchaseprice: $purchasePrice,dateModel: $dateModel, quantity: $quantity, id:$id,purchaseId: $purchaseId}';
  }
}

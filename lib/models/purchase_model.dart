const String purchaseId = "id";
const String purchaseProductId = "productId";
const String purchaseDate = "date";
const String purchasePrice = "price";
const String purchaseQuantity = "quantity";

class PurchaseModel {
  String? id;
  String? productID;
  String? purchasedate;
  num purchaseprice;
  num quantity;

  PurchaseModel({
    this.id,
    this.productID,
    this.purchasedate,
    required this.purchaseprice,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      purchaseId: id,
      purchaseProductId: productID,
      purchaseDate: purchasedate,
      purchasePrice: purchaseprice,
      purchaseQuantity: quantity,
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
      id: map[purchaseId],
      productID: map[purchaseProductId],
      purchasedate: map[purchaseDate],
      purchaseprice: map[purchasePrice],
      quantity: map[purchaseQuantity]);
}

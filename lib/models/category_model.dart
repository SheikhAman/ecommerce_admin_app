const String categoryId = 'id';
const String categoryName = 'name';
const String categoryAvailable = 'available';
const String categoryProductCount = 'productCount';

class CategoryModel {
  String? catId, catName;
  num productCount;
  bool available;

  CategoryModel(
      {this.catName, this.catId, this.available = true, this.productCount = 0});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      categoryId: catId,
      categoryName: catName,
      categoryAvailable: available,
      categoryProductCount: productCount,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      catId: map[categoryId],
      catName: map[categoryName],
      available: map[categoryAvailable],
      productCount: map[categoryProductCount],
    );
  }
}

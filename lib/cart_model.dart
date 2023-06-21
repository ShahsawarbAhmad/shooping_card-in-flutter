class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initalPrice;
  final int? productPrice;
  final int? qunatitiy;
  final String? unitStage;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initalPrice,
    required this.productPrice,
    required this.qunatitiy,
    required this.unitStage,
    required this.image,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        initalPrice = res['initalPrice'],
        productPrice = res['productPrice'],
        qunatitiy = res['qunatitiy'],
        unitStage = res['unitStage'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initalPrice': initalPrice,
      'productPrice': productPrice,
      'qunatitiy': qunatitiy,
      'unitStage': unitStage,
      'image': image,
    };
  }
}

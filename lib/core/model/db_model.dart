class DbProductModel {
  int? id;
  String? title;
  String? content;
  String? thumbnail;
  double? price;
  int? quantity;
  double? total;


  DbProductModel(
      {this.id,
        this.title,
        this.content,
        this.thumbnail,
        this.price,
        this.quantity,
        this.total});

  DbProductModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    return data;
  }
}
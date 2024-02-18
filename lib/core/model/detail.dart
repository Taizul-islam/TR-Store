class ProductDetail {
  int? id;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  String? status;
  String? category;
  String? publishedAt;
  String? updatedAt;
  int? userId;

  ProductDetail(
      {this.id,
        this.slug,
        this.url,
        this.title,
        this.content,
        this.image,
        this.thumbnail,
        this.status,
        this.category,
        this.publishedAt,
        this.updatedAt,
        this.userId});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    url = json['url'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    category = json['category'];
    publishedAt = json['publishedAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['url'] = url;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['status'] = status;
    data['category'] = category;
    data['publishedAt'] = publishedAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}
class Listing {
  final String? bhk;
  final String? type;
  final String? property;
  final String? price;
  final String? title;
  final String? description;
  final String? area;
  final String? user;
  final List<String>? images;

  Listing(
      {required this.bhk,
      required this.type,
      required this.property,
      required this.price,
      required this.title,
      required this.description,
      required this.area,
      required this.user,
      required this.images});
}

class MobileModel {
  static List<Mobiles> mobiles = [];

  Mobiles getById(int id) =>
      mobiles.firstWhere((element) => element.id == id, orElse: null);

  Mobiles getByPos(int pos) => mobiles[pos];
}

class Mobiles {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String color;
  final String image;

  Mobiles(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.color,
      required this.image});

  //To get class from map

  factory Mobiles.fromMap(Map<String, dynamic> map) {
    return Mobiles(
      id: map["id"],
      name: map["name"],
      desc: map["desc"],
      price: map["price"],
      color: map["color"],
      image: map["image"],
    );
  }

//To get map from class

// toMap() => {
//       "id": id,
//       "name": name,
//       "desc": desc,
//       "price": price,
//       "color": color,
//       "image": image,
//     };

}

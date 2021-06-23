import 'Product.dart';

class Favorite {
  final String link;
  bool check;
  List<int> listId;

  Favorite({
    required this.link,
    required this.check,
    required this.listId,
  });
}

void resetID() {
  for (int i = 0; i < favorites.length; i++) {
    favorites[i].listId = [];
  }
}

void addID() {
  for (int i = 0; i < favorites.length; i++) {
    if (favorites[i].check) {
      for (int j = 0; j < products.length; j++) {
        if (products[j].source == favorites[i].link) favorites[i].listId.add(j);
      }
    }
  }
}

List<Favorite> favorites = [
  Favorite(
    link: "assets/images/TheThao247.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/TienPhong.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/TTNews.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/VietNamNet.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/VnExPress.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/XaHoi.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/TTNews.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/BaoMoi.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/GDvaTD.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/KTvaDT.png",
    check: false,
    listId: [],
  ),
  Favorite(
    link: "assets/images/ZingNews.png",
    check: false,
    listId: [],
  ),
];

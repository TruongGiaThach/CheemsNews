List<String> titles = [
  "Xã hội",
  "Kinh tế",
  "Thể thao",
  "Giáo dục",
  "Pháp luật",
  "Du lịch",
  "Khoa học"
];
class TypeNews {
  String name;
 TypeNews(this.name);
  factory TypeNews.fromJson(Map<String, dynamic> result) {
    return TypeNews(
      result['name'],
      
    );
  }
}
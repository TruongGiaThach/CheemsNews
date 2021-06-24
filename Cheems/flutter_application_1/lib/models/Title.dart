
class TypeNews {
  String name;
 TypeNews(this.name);
  factory TypeNews.fromJson(Map<String, dynamic> result) {
    return TypeNews(
      result['name'],
      
    );
  }
}
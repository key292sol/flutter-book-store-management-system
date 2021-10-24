class Book {
  int id;
  String name;
  String author;
  int price;
  int count;

  Book(this.id, this.name, this.author, this.price, this.count);

  List<String> getAsList() {
    return [
      this.id.toString(),
      this.name,
      this.author,
      this.price.toString(),
      this.count.toString()
    ];
  }

  Map<String, String> getAsMap() {
    return {
      "id": this.id.toString(),
      "name": this.name,
      "author": this.author,
      "price": this.price.toString(),
      "count": this.count.toString()
    };
  }

  static List<String> getColumnNames() {
    return ["ID", "NAME", "AUTHOR", "PRICE", "COUNT"];
  }

}

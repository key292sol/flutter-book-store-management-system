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

  /* 
   * To use when a function needs empty values to display
   */
  static Map<String, String> getEmptyMap() {
    return {
      "id": "",
      "name": "",
      "author": "",
      "price": "",
      "count": ""
    };
  }

  static List<String> getColumnNames() {
    return ["ID", "NAME", "AUTHOR", "PRICE", "COUNT"];
  }

}

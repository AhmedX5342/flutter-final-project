class BookModel {
  String? id ='';
  String? name;
  // String? author ='';
  String? description ='';
  String? image ='';

  BookModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['volumeInfo']['title'];
    // author = json['volumeInfo']['authors'][0];
    description = json['volumeInfo']['description'];
    image  = json['volumeInfo']['imageLinks']['thumbnail'];
  }
}

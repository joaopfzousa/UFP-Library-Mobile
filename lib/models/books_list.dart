import 'package:ufp_library_mobile/models/books.dart';

class BooksList {
  final List<Books> booksList;

  BooksList({
    this.booksList
  });

  factory BooksList.fromJson(List<dynamic> parsedJson) {
    List<Books> books = new List<Books>();
    books = parsedJson.map((i) => Books.fromJson(i)).toList();
    
    return new BooksList(
      booksList: books
    );
  }

  int booksListLength() {
    return this.booksList.length;
  }
}
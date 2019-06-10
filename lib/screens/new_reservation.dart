import 'package:flutter/material.dart';
import 'package:ufp_library_mobile/models/books.dart';
import 'package:ufp_library_mobile/models/books_list.dart';
import 'package:ufp_library_mobile/screens/home.dart';
import 'package:ufp_library_mobile/services/api.dart';
import '../models/user.dart';

class NewReservationScreen extends StatefulWidget {
  final User authenticatedUser;

  NewReservationScreen({Key key, @required this.authenticatedUser}) : super(key: key);

  @override
  _NewReservationScreenState createState() => _NewReservationScreenState(this.authenticatedUser);
}

class _NewReservationScreenState extends State<NewReservationScreen> {
  final User authenticatedUser;
  var reservationsList = new BooksList();
  var _currentBook;

  _NewReservationScreenState(this.authenticatedUser);

  Future<BooksList> _getBooks() async {
    return await getLibraryBooks();
  }

  initState() {
    super.initState();
    _getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('UFP Library')),
        body: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Builder(
                  builder: (context) => Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FutureBuilder<BooksList>(
                          future: _getBooks(),
                          builder: (BuildContext context,
                            AsyncSnapshot<BooksList> snapshot) {
                              if (!snapshot.hasData) return CircularProgressIndicator();
                              
                              return DropdownButton<Books>(
                                items: snapshot.data.booksList
                                .map((bookDetail) => DropdownMenuItem<Books>(
                                  child: Text(bookDetail.title),
                                  value: bookDetail,
                                ))
                                .toList(),
                                onChanged: (Books book) {
                                  setState(() {
                                    _currentBook = book;
                                  });
                                },
                                isExpanded: false,
                                //value: _currentBook,
                                hint: Text('Escolha um livro'),
                              );
                            }),
                          _currentBook != null
                          ? Image.network(
                              _currentBook.cover,
                            )
                          : Icon(
                              Icons.book,
                              size: 80.0,
                            ),
                          SizedBox(height: 20.0),
                            _currentBook != null
                            ? Text("Título: " +
                            _currentBook.title +
                            "\n Autor: " +
                            _currentBook.author +
                            "\n ISBN: " +
                            _currentBook.isbn)
                            : Text("Nenhum livro escolhido"),
                            Form(
                              child:RaisedButton(
                                onPressed: () async {
                                  if(_currentBook != null) {
                                    _showDialog(context, 'Logging in...');
                                    DateTime now = new DateTime.now();
                                    try {
                                      var reservation = new Map<String, dynamic>();
                                      reservation["token"] = authenticatedUser.token.toString();
                                      reservation["user_id"] = authenticatedUser.id.toString();
                                      reservation["book_id"] = _currentBook.id.toString();
                                      reservation["reservation_date"] = new DateTime(now.year, now.month, now.day).toString();
                                      await placeReservation(body: reservation);
                                      Navigator.pop(context);
                                    } on Exception catch(e) {
                                      _hideDialog(context);
                                      _showDialog(context, 'Error! Please try again...');
                                    }
                                  }
                                },
                                child: Text('Reservar'))
                              )
                    ],
                  ),
                ),
            )
          )
        )
      );
  }

  _showDialog(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  _hideDialog(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ufp_library_mobile/models/books_list.dart';
import 'package:ufp_library_mobile/models/reservations_list.dart';
import 'package:ufp_library_mobile/models/user.dart';

const url = 'https://ufp-library.herokuapp.com/api/v1/';

Future<User> loginUser({Map body}) async {
  return http.post(url + 'login', body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return User.fromJson(json.decode(response.body));
  });
}

Future<ReservationsList> getActiveReservations({String number}) async {
  return http.get(url + 'users/' + number + '/active-reservations').then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return ReservationsList.fromJson(json.decode(response.body));
  });
}

Future<BooksList> getLibraryBooks() async {
  return http.get(url + 'books/').then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return BooksList.fromJson(json.decode(response.body));
  });
}

import 'package:flutter/material.dart';
import 'package:ufp_library_mobile/models/reservations_list.dart';
import 'package:ufp_library_mobile/models/user.dart';
import 'package:ufp_library_mobile/screens/new_reservation.dart';
import 'package:ufp_library_mobile/services/api.dart';

class HomeScreen extends StatefulWidget {
  final User authenticatedUser;

  HomeScreen({Key key, @required this.authenticatedUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(this.authenticatedUser);
}

class _HomeScreenState extends State<HomeScreen> {
  final User authenticatedUser;
  var reservationsList = new ReservationsList();

  _HomeScreenState(this.authenticatedUser);

  Future<ReservationsList> _getReservations() async {
    return await getActiveReservations(number: this.authenticatedUser.number);
  }

  initState() {
    super.initState();
    _getReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UFP Library'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewReservationScreen(authenticatedUser: this.authenticatedUser),
                  ),
                );
              },
          )
        ]
        ),
      body: FutureBuilder<ReservationsList>(
        future: _getReservations(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data.reservationsList.map((reservationDetails) => ListTile(
                  leading: Icon(Icons.book),
                  title: Text(reservationDetails.bookTitle.toString()),
                  subtitle: Text('Data de reserva: ' + reservationDetails.reservationDate.day.toString() + '/' + reservationDetails.reservationDate.month.toString() + '/' + reservationDetails.reservationDate.year.toString())
                ))
            .toList(),
          );
        },
      )
    );
  }
}
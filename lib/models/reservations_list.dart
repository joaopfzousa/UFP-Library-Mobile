import 'package:ufp_library_mobile/models/reservations.dart';

class ReservationsList {
  final List<Reservations> reservationsList;

  ReservationsList({
    this.reservationsList
  });

  factory ReservationsList.fromJson(List<dynamic> parsedJson) {
    List<Reservations> reservations = new List<Reservations>();
    reservations = parsedJson.map((i) => Reservations.fromJson(i)).toList();
    
    return new ReservationsList(
      reservationsList: reservations
    );
  }

  int reservationsListLength() {
    return this.reservationsList.length;
  }
}
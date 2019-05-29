class Reservations {
    int id;
    int userId;
    int bookId;
    String bookTitle;
    DateTime reservationDate;
    int status;
    int renovation;
    DateTime createdAt;
    DateTime updatedAt;

    Reservations({
        this.id,
        this.userId,
        this.bookId,
        this.bookTitle,
        this.reservationDate,
        this.status,
        this.renovation,
        this.createdAt,
        this.updatedAt,
    });

    factory Reservations.fromJson(Map<String, dynamic> json) => new Reservations(
        id: json["id"],
        userId: json["user_id"],
        bookId: json["book_id"],
        bookTitle: json["book_title"],
        reservationDate: DateTime.parse(json["reservation_date"]),
        status: json["status"],
        renovation: json["renovation"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "book_id": bookId,
        "book_title": bookTitle,
        "reservation_date": reservationDate.toIso8601String(),
        "status": status,
        "renovation": renovation,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
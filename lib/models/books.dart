class Books {
    int id;
    String isbn;
    String title;
    String author;
    String edition;
    String publisher;
    String location;
    String cover;
    DateTime createdAt;
    DateTime updatedAt;

    Books({
        this.id,
        this.isbn,
        this.title,
        this.author,
        this.edition,
        this.publisher,
        this.location,
        this.cover,
        this.createdAt,
        this.updatedAt,
    });

    factory Books.fromJson(Map<String, dynamic> json) => new Books(
        id: json["id"],
        isbn: json["isbn"],
        title: json["title"],
        author: json["author"],
        edition: json["edition"],
        publisher: json["publisher"],
        location: json["location"],
        cover: json["cover"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isbn": isbn,
        "title": title,
        "author": author,
        "edition": edition,
        "publisher": publisher,
        "location": location,
        "cover": cover,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
class Faculty {
  String? id;
  String? name;
  String? shortName;
  String? about;
  String? hotLineNumber;
  String? hotLineMail;
  String? forInquiriesNumber;
  String? forHostelNumber;
  String? imagePath;

  Faculty(
      {this.id,
      this.name,
      this.shortName,
      this.about,
      this.hotLineNumber,
      this.hotLineMail,
      this.forInquiriesNumber,
      this.forHostelNumber,
      this.imagePath});

  Faculty.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          name: data['name'],
          shortName: data['shortName'],
          about: data['about'],
          hotLineNumber: data['hotLineNumber'],
          hotLineMail: data['hotLineMail'],
          forInquiriesNumber: data['forInquiriesNumber'],
          forHostelNumber: data['forHostelNumber'],
          imagePath: data['imagePath'],
        );
}

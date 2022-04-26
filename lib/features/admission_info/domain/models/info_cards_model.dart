class InfoCard {
  String? title;
  String? subtitle;
  int? orderId;
  String? docId;

  InfoCard({this.title, this.subtitle, this.orderId, this.docId});

  InfoCard.fromMap(Map<String, dynamic> data, String id):this(
    title: data['title'],
    subtitle: data['subtitle'],
    orderId: data['orderId'],
    docId: id,
  );

}

class Coeff {
  String key;
  int weight;

  Coeff({required this.key, required this.weight});

  Coeff.fromMap(Map<String, dynamic> data)
      : this(
          key: data['text'],
          weight: data['weight'],
        );
}

class Amount {
  final String solde;

  const Amount({
    required this.solde,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      solde: json["Votre solde est de "],
    );
  }
}

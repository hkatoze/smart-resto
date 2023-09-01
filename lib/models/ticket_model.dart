class Ticket {
  final int nbr_ticket;
  final int employeeId;

  const Ticket({
    required this.nbr_ticket,
    required this.employeeId,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      nbr_ticket: json["le nombre de tickets est de "],
      employeeId: json["employeeId"]
    );
  }
}

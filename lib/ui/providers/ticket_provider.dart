import 'package:flutter/material.dart';
import '/data/models/ticket_model.dart';
import '/data/services/ticket_services.dart';

class TicketProvider with ChangeNotifier {
  Ticket? _ticket = Ticket(uid: "", count: "");
  List<Ticket>? _tickets = [];

  Ticket get getTicket => _ticket!;
  List<Ticket> get getTickets => _tickets!;
  TicketServices ticketServices = TicketServices();

  Future addTicket(String productId, String uid, Ticket ticket) async {
    await ticketServices.postTicket(productId, uid, ticket);
    notifyListeners();
  }

  Future getTicketsF(String productId) async {
    _tickets = await ticketServices.getTickets(productId);
    notifyListeners();
  }
}

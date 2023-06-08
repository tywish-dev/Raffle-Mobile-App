import 'dart:convert';
import '/data/models/ticket_model.dart';
import '/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class TicketServices {
  Uri getUrl(String endpoint) => Uri.parse("$baseUrl$endpoint.json");

  Future<Ticket?> postTicket(
      String productId, String uid, Ticket ticket) async {
    http.Response response = await http.put(
      getUrl("tickets/$productId/$uid"),
      body: ticket.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ticket;
    }
    return null;
  }

  Future<List<Ticket>?> getTickets(String productId) async {
    http.Response response = await http.get(getUrl("tickets/$productId/"));
    List<String> keys = [];
    List<Ticket> tickets = [];
    var data = jsonDecode(response.body);

    if (data != null) {
      keys.addAll(data.keys);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        for (var i = 0; i < data.length; i++) {
          Ticket ticket = Ticket.fromMap(data[keys[i]]);
          tickets.add(ticket);
        }
      }
    }
    return tickets;
  }

  Future<bool?> postWinnerTicket(String uid, Product product, String id) async {
    http.Response response = await http.put(
      getUrl("users/$uid/winner/$id"),
      body: product.toJson(),
      headers: {'Content-Type': "application/json"},
    );

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<List<Product>?> getWinnerTickets(String uid) async {
    http.Response response = await http.get(getUrl("users/$uid/winner/"));

    List<String> keys = [];
    List<Product> products = [];
    var data = jsonDecode(response.body);

    if (data != null) {
      keys.addAll(data.keys);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        for (var i = 0; i < data.length; i++) {
          Product product = Product.fromMap(data[keys[i]]);
          products.add(product);
        }
      }
    }

    return products;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

final baseUrl = "http://localhost:3000";

void main() async {
  await login();
}

Future<void> login() async {
  print("===== Login =====");
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();

  if (username == null || password == null) {
    print("Incomplete input");
    return;
  }

  final url = Uri.parse('$baseUrl/login');
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"username": username, "password": password}),
  );

  if (response.statusCode == 200) {
    print(response.body);
    await Choose(username);
  } else {
    print("Error: ${response.body}");
  }
}

Future<void> Choose(String name) async {
  while (true) {
    print("============ Expense Tracking App ============");
    print("Welcome $name");
    print(
      " 1. All expenses \n 2. Today's expense \n 3. Search expense \n 4. Add new expense \n 5. Delete an expense \n 6. Exit",
    );

    stdout.write("Choose .. ");
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? "");

    if (choice == 1) {
      await ShowallExpense();
    } else if (choice == 2) {
      await ShowExpenseToday();
    } else if (choice == 3) {
      await SearchExpense();
    } else if (choice == 4) {
      await AddNewExpense();
    } else if (choice == 5) {
      await DeleteAnExpense();
    } else if (choice == 6) {
      print("--- bye ---");
      break;
    } else {
      print("Invalid choice");
    }
  }
}

Future<void> ShowallExpense() async {
  final res = await http.get(Uri.parse("$baseUrl/Expense"));
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print("===== All Expenses =====");
    for (var e in data) {
      print("${e['id']}. ${e['item']} - ${e['paid']} THB [${e['date']}]");
    }
  } else {
    print("Error: ${res.body}");
  }
}

Future<void> ShowExpenseToday() async {
  final res = await http.get(Uri.parse("$baseUrl/ExpenseToday"));
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print("===== Today's Expenses =====");
    for (var e in data) {
      print("${e['id']}. ${e['item']} - ${e['paid']} THB [${e['date']}]");
    }
  } else {
    print("Error: ${res.body}");
  }
}

Future<void> SearchExpense() async {
  stdout.write("Enter keyword: ");
  final kw = stdin.readLineSync();
  final res = await http.get(Uri.parse("$baseUrl/SearchExpense?q=$kw"));
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print("===== Search Results =====");
    for (var e in data) {
      print("${e['id']}. ${e['item']} - ${e['paid']} THB [${e['date']}]");
    }
  } else {
    print("Error: ${res.body}");
  }
}

Future<void> AddNewExpense() async {
  stdout.write("Item: ");
  final item = stdin.readLineSync();
  stdout.write("Paid: ");
  final paid = stdin.readLineSync();
  final date = DateTime.now().toIso8601String().split('T')[0];

  final res = await http.post(
    Uri.parse("$baseUrl/AddnewExpense"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"item": item, "paid": paid, "date": date}),
  );
  print(res.body);
}

Future<void> DeleteAnExpense() async {
  stdout.write("Enter expense ID to delete: ");
  final id = stdin.readLineSync();
  final res = await http.delete(Uri.parse("$baseUrl/DeleteAnExpense/$id"));
  print(res.body);
}
import 'dart:convert';
import 'package:http/http.dart' as http;
// for stdin
import 'dart:io';

void main() async {
  await login();
}

Future<void> login() async {
  print("===== Login =====");
  // Get username and password
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();
  if (username == null || password == null) {
    print("Incomplete input");
    return;
  }

  final body = {"username": username, "password": password};
  final url = Uri.parse('http://localhost:3000/login');
  final response = await http.post(url, body: body);
  // note: if body is Map, it is encoded by "application/x-www-form-urlencoded" not JSON
  if (response.statusCode == 200) {
    // the response.body is String
    final result = response.body;
    Choose(username);
    // เข้า Function Here
  } else if (response.statusCode == 401 || response.statusCode == 500) {
    final result = response.body;
    print(result);
  } else {
    print("Unknown error");
  }
}

Future<void> Choose(name) async {
  while (true) {
    print("============ Expense Tracking App ============");
    print("WElcome $name");
    print(
      " 1. All expenses \n 2. Today's expense \n 3. Search expense \n 4. Add new expense \n 5. Delete an expense \n 6. Exit",
    );

    stdout.write("Choose .. ");
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? "");

    if (choice == 1) {
      ShowallEXpense();
    } else if (choice == 2) {
      ShowallEXpenseToday();
    } else if (choice == 3) {
      SearchExpense();
    } else if (choice == 4) {
      AddNewExpense();
    } else if (choice == 5) {
      DeleteAnExpense();
    } else {
      print("--- bye ---");
    }
  }
}
final baseUrl = "http://localhost:3000/";
Future<void> ShowallEXpense() async {
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
Future<void> ShowallEXpenseToday() async {
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

}
Future<void> AddNewExpense() async {

}
Future<void> DeleteAnExpense() async {
  
}

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';


void main() async {
  print("===Login===");


  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  if (username == null || username.isEmpty) {
    print("please put your name");
    return;
  }


  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();
  if (password == null || password.isEmpty) {
    print("please put your password");
    return;
  }


  // ===== LOGIN =====
  var loginRes = await http.post(
    Uri.parse('http://localhost:3000/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({'username': username, 'password': password}),
  );


  print("Insert done");


  var loginData = jsonDecode(loginRes.body);


  int userId = loginData['user_id'];


  // ===== MENU =====
  while (true) {
    print("\n===Expenses Tracking App===");
    print(
      "1. Show All Expenses"
      "\n2. Today's Expenses"
      "\n3. Search Expenses"
      "\n4. Add new Expenses"
      "\n5. Delete an Expenses"
      "\n6. Exit",
    );


    stdout.write("Choose... ");
    String? choice = stdin.readLineSync()?.trim();
    if (choice == null || choice.isEmpty) {
      print("please choose a number");
      return;
    }

    //===Choice 1===
 
    
    //===Choice 2===

    
    
    ////===Choice 3=== Search Expenses ====
   
   

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



   //===Choice 4=== Add new Expenses ====
    
  
      
    
    





  





  
    //===Choice 5=== Delete an Expenses ====
    








 





    //===Choice 6===
    else if (choice == "6") {
      print("Good Bye");
      break;
    }
  }
}
import 'package:basic_banking_app/Models/transection_details.dart';
import 'package:basic_banking_app/Models/user_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;

class DatabaseHelper {

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,"bankingsystem.db");
    var mydb=await openDatabase(path,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE userdetails(id INTEGER PRIMARY KEY, userName TEXT,cardNumber VARCHAR,cardExpiry TEXT,totalAmount DOUBLE)");

        await db.execute(
            "CREATE TABLE transectionsData(id INTEGER PRIMARY KEY,transectionId INTEGER,userName TEXT,senderName TEXT,transectionAmount DOUBLE)");
      },
      version: 1,
    );
    return mydb;
  }

  Future<void> insertUserDetails(UserData userdata) async {
    Database? _db = await db;
    await _db!.insert('userdetails', userdata.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTransectionHistroy(
      TransectionDetails transectionDetails) async {
    Database _db = await initialDB();
    await _db.insert('transectionsData', transectionDetails.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTotalAmount(int id, double totalAmount) async {
    Database? _db = await db;
    await _db!.rawUpdate(
        "UPDATE userDetails SET totalAmount = '$totalAmount' WHERE id = '$id'");
  }

  Future<List<UserData>> getUserDetails() async {
    Database? _db = await db;
    final List<Map<String, dynamic>> userMap = await _db!.query('userdetails');
    List<UserData>list=[];
    for(var i in userMap){
      UserData model = UserData(
        id: i['id'],
        userName: i['userName'],
        cardNumber: i['cardNumber'],
        cardExpiry: i['cardExpiry'],
        totalAmount: i['totalAmount'],
      );
      list.add(model);
    }
    return list;
  }

  Future<List<UserData>> getUserDetailsList(int userId) async {
    Database? _db = await db;
    List<Map<String, dynamic>> userMap =
    await _db!.rawQuery("SELECT * FROM userDetails WHERE id != $userId");
    return List.generate(userMap.length, (index) {
      return UserData(
        id: userMap[index]['id'],
        userName: userMap[index]['userName'],
        cardNumber: userMap[index]['cardNumber'],
        cardExpiry: userMap[index]['cardExpiry'],
        totalAmount: userMap[index]['totalAmount'],
      );
    });
  }

  Future<List<TransectionDetails>> getTransectionDetatils() async {
    Database? _db = await db;
    final List<Map<String, dynamic>> trasectionMap =
    await _db!.rawQuery("SELECT * FROM transectionsData");
    return List.generate(trasectionMap.length, (index) {
      return TransectionDetails(
        id: trasectionMap[index]['id'],
        userName: trasectionMap[index]['userName'],
        senderName: trasectionMap[index]['senderName'],
        transectionId: trasectionMap[index]['transectionId'],
        transectionAmount: trasectionMap[index]["transectionAmount"],
      );
    });
  }

  Future<void> updateTransectionIsDone(int id, int transectionDone) async {
    Database? _db = await db;
    await _db!.rawUpdate(
        "UPDATE transections SET transectionDone = '$transectionDone' WHERE id = '$id'");
  }
}

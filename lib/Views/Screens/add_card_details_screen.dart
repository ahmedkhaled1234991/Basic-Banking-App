import 'package:basic_banking_app/Helper/database_helper.dart';
import 'package:basic_banking_app/Models/user_data.dart';
import 'package:basic_banking_app/Views/Screens/home_screen.dart';
import 'package:basic_banking_app/Views/Widgets/custom_dialog.dart';
import 'package:basic_banking_app/Views/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants.dart';

class AddCardDetails extends StatefulWidget {
  @override
  _AddCardDetailsState createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? cardHolderName;
  String? cardNumber;
  String? cardExpiry;
  double? currentBalance;

  DatabaseHelper _dbhelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mgBgColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF3E8E7E),
        title: Text("Add Account Details"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Card(
                  color: Color(0xFFFABB51),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            hintName: "Enter card holder name",
                            keyboardTypeNumber: false,
                            onSaved: (value) {
                              cardHolderName = value;
                            },
                            validator: (value){
                              if (value.isEmpty) {
                                return "Please Enter Name";
                              } else {
                                if (value.length < 3) {
                                  return "Must be more than 2 character";
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
                          CustomTextField(
                            hintName: "Enter card number",
                            keyboardTypeNumber: false,
                            onSaved: (value) {
                              cardNumber = value;
                            },
                            validator: (value){
                              if (value.isEmpty) {
                                return "Please Enter Card Number";
                              } else {
                                if (value.length < 6) {
                                  return "Must be more than 6 number";
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
                          CustomTextField(
                            hintName: "Enter card expiry date",
                            keyboardTypeNumber: false,
                            onSaved: (value) {
                              cardExpiry = value;
                            },
                            validator: (value){
                              if (value.isEmpty) {
                                return "Please Enter Card Expiry Date";
                              } else {
                                if (value.length < 3) {
                                  return "Must be more than 2 character";
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
                          CustomTextField(
                            hintName: "Enter current amount",
                            keyboardTypeNumber: true,
                            onSaved: (value) {
                              currentBalance = double.parse(value);
                            },
                            validator: (value){
                              if (value.isEmpty) {
                                return "Please Enter Current Amount";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async{
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  UserData _userData = UserData(
                                    userName: cardHolderName,
                                    cardNumber: cardNumber,
                                    cardExpiry: cardExpiry,
                                    totalAmount: currentBalance,
                                  );

                                  await _dbhelper.insertUserDetails(_userData);

                                  CustomDialog(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()))
                                            .then((value) => {});
                                      },
                                      title: "Success",
                                      isSuccess: true,
                                      description:
                                      "Thanking for adding your details",
                                      buttonText: "Ok",
                                      addIcon: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ).showdialog(context);
                                } else {
                                  print("Fail to insert");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF3E8E7E),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:basic_banking_app/Helper/database_helper.dart';
import 'package:basic_banking_app/Views/Screens/transfer_money_screen.dart';
import 'package:basic_banking_app/Views/Widgets/atm_card.dart';
import 'package:basic_banking_app/Views/Widgets/transaction_histroy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../card_data.dart';
import '../../constants.dart';
import 'add_card_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseHelper _dbhelper = new DatabaseHelper();
  late List<CardData> _list;

  @override
  void initState() {
    _list = CardData.cardDataList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mgBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: mgDefaultPadding),
          child: Icon(
            Icons.menu,
            color: mgMenuColor,
            size: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 199,
              child: FutureBuilder(
                initialData: [],
                future: _dbhelper.getUserDetails(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding:
                    const EdgeInsets.only(left: mgDefaultPadding, right: 6),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                         Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TransferMoney(
                                currentBalance:
                                snapshot.data[index].totalAmount,
                                currentCustomerId: snapshot.data[index].id,
                                currentUserCardNumebr:
                                snapshot.data[index].cardNumber,
                                senderName: snapshot.data[index].userName,
                              ),
                            ),
                          );
                        },
                        child: UserATMCard(
                          cardNumber: snapshot.data[index].cardNumber,
                          cardExpiryDate: snapshot.data[index].cardExpiry,
                          totalAmount: snapshot.data[index].totalAmount,
                          gradientColor: _list[index].mgPrimaryGradient,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: mgDefaultPadding,
                  bottom: 13,
                  top: 29,
                  right: mgDefaultPadding),
              child: Text(
                "Transaction Histories",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),

            Container(
              child: FutureBuilder(
                initialData: [],
                future: _dbhelper.getTransectionDetatils(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: mgDefaultPadding),
                    itemBuilder: (context, index) {
                      return TransactionHistroy(
                        isTransfer: true,
                        customerName: snapshot.data[index].userName,
                        transferAmount: snapshot.data[index].transectionAmount,
                        senderName: snapshot.data[index].senderName,
                        avatar: snapshot.data[index].userName[0],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: mgYellowColor,
        elevation: 15,
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mgGreenColor,

        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 100),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.easeInOutCubic);
                    return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.bottomCenter,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AddCardDetails();
                  }));
        },
        child: Icon(Icons.add,size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

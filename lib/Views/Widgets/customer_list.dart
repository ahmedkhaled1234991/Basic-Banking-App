import 'package:flutter/material.dart';

class CustomerList extends StatefulWidget {
  final String customerName;
  final String avatar;
  final String? transactionDate;
  final double currentBalance;
  CustomerList({
    required this.customerName,
    required this.currentBalance,
    required this.avatar,
    this.transactionDate,
  });
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(left: 24, top: 12, bottom: 12, right: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(8, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(),
                child: CircleAvatar(
                  backgroundColor: Colors.blue.shade200,
                  child: Text(widget.avatar,
                    style: TextStyle(
                      fontSize: 22,
                    ),),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.customerName}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                ' \$ ${widget.currentBalance}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.green, fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

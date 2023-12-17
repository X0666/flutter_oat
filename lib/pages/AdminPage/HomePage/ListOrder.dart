import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/services/transaction_service.dart';

class ListOrder extends StatelessWidget {
  const ListOrder({Key? key});

  get getTransactions => getTransactions;

  get setTransactionPaid => setTransactionPaid;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'List Order',
        ),
      );
    }

    Widget orderlist() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: backgroundColor3,
        ),
      );
    }

    Widget orderListData() {
      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Payment',
              style: GoogleFonts.poppins(
                color: whiteText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '\$${setTransactionPaid}',
                  style: GoogleFonts.poppins(
                    color: whiteText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Column(
      children: [
        header(),
        orderlist(),
        orderListData(),
      ],
    );
  }

  void getTransaction(e) {}
}

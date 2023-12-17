import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/services/transaction_service.dart';

class ListOrder extends StatefulWidget {
  ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  // get getTransactions => getTransactions;

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
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
          child: Consumer<ProductProvider>(
            builder: (context, myData, child) {
              return Container(
                margin: const EdgeInsets.only(top: 20),
                height: (MediaQuery.of(context).size.height / 1.33),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: myData.productsTransactions.length,
                  itemBuilder: (context, index) {
                    final parent = myData.productsTransactions[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i in parent.items!)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${i.product?.name}",
                                      style: GoogleFonts.poppins(
                                          color: blackColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${i.quantity} ${i.quantity! >= 1 ? 'item' : 'items'}",
                                      style: GoogleFonts.poppins(
                                          color: blackColor),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Price",
                                    style:
                                        GoogleFonts.poppins(color: blackColor),
                                  ),
                                  Text(
                                    "Paid From",
                                    style:
                                        GoogleFonts.poppins(color: blackColor),
                                  ),
                                  Text(
                                    "Status",
                                    style:
                                        GoogleFonts.poppins(color: blackColor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${parent.totalPrice}",
                                    style: GoogleFonts.poppins(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${parent.payment}",
                                    style: GoogleFonts.poppins(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${parent.status}",
                                    style: GoogleFonts.poppins(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundColor1,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            orderlist(),
          ],
        ),
      ),
    );
  }

  void getTransaction(e) {}
}

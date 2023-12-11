import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/pages/checkout_payment_waiting.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/transaction_provider.dart';
import 'package:shamo/theme.dart';

class PaymentMethod extends StatefulWidget {
  final int? id;
  const PaymentMethod({this.id, super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    userModel user = authProvider.user;

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Checkout Details',
        ),
      );
    }

    setPaymentMethod(CategoryModel paymentModel) async {
      await Provider.of<TransactionProvider>(context, listen: false).setPaid(
        user.token!,
        widget.id!,
        paymentModel.id!,
      );

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutWaitingPage(
            paymentMethod: paymentModel,
          ),
        ),
      );
    }

    Widget totalPrice() {
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
                  '\$${cartProvider.totalPrice()}',
                  style: GoogleFonts.poppins(
                    color: whiteText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${cartProvider.totalItems()} Items',
                  style: GoogleFonts.poppins(
                    color: whiteText,
                    fontSize: 14,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget paymentList() {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Column(
          children: cartProvider.paymentMethods.map((e) {
            return InkWell(
              onTap: () {
                setPaymentMethod(e);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 77,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteText,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${e.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Norek: ${e.accountNumber}"),
                    const Text("A/N: Farid"),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            totalPrice(),
            paymentList(),
          ],
        ),
      ),
    );
  }
}

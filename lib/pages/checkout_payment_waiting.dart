import 'package:flutter/material.dart';
import 'package:shamo/models/category_model.dart';
import 'package:shamo/theme.dart';

class CheckoutWaitingPage extends StatefulWidget {
  final CategoryModel? paymentMethod;

  CheckoutWaitingPage({this.paymentMethod, super.key});

  @override
  State<CheckoutWaitingPage> createState() => _CheckoutWaitingPageState();
}

class _CheckoutWaitingPageState extends State<CheckoutWaitingPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        return Navigator.pushNamedAndRemoveUntil(
          context,
          '/checkout-success',
          (route) => false,
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: const Text(
          'Waiting Payment',
        ),
        elevation: 0,
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 77,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
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
                    "${widget.paymentMethod?.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Norek: ${widget.paymentMethod?.accountNumber}"),
                  const Text("A/N: Farid"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text("Waiting for transaction payment ..."),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: backgroundColor1,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}

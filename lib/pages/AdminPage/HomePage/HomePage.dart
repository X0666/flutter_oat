import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';

import '../../../providers/auth_provider.dart';
import '../../../widgets/product_tile.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    userModel user = authProvider.user;

    Future<void> _refreshData() async {
      await Future.delayed(const Duration(seconds: 2));

      setState(() async {
        // Update your data here
        await Provider.of<ProductProvider>(context, listen: false)
            .getProducts();
        productProvider.products =
            await Provider.of<ProductProvider>(context, listen: false).products;
      });
    }

    Widget header() {
      return Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello, ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Admin ${user.name}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/sign-in', (route) => false);
              },
              child: Image.asset(
                'assets/button_exit.png',
                width: 20,
              ),
            )
          ],
        ),
      );
    }

    Widget productFunctionality() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Product List",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/admin-edit');
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text(
                    '+ Add',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget listProduct() {
      return RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            Consumer<ProductProvider>(
              builder: (context, myData, child) {
                return Container(
                  height: (MediaQuery.of(context).size.height / 1.33),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: myData.products.length,
                    itemBuilder: (context, index) {
                      return ProductTile(myData.products[index], true);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            productFunctionality(),
            listProduct(),
          ],
        )),
      ),
    );
  }
}

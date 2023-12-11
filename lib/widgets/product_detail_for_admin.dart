import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/pages/AdminPage/EditItem/EditItem.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/services/product_service.dart';
import 'package:shamo/theme.dart';

class ProductPageAdmin extends StatefulWidget {
  final ProductModel product;
  ProductPageAdmin(this.product);

  @override
  State<ProductPageAdmin> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPageAdmin> {
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    userModel user = authProvider.user;

    deleteItem() async {
      var resp = await Provider.of<ProductProvider>(context, listen: false)
          .deleteProducts(
        user.token!,
        '${widget.product.id}',
      );

      await Future.delayed(const Duration(seconds: 1));
      await Provider.of<ProductProvider>(context, listen: false).getProducts();

      productProvider.products =
          await Provider.of<ProductProvider>(context, listen: false).products;

      if (resp == true) {
        Navigator.pop(context);
      } else {
        final snackBar = SnackBar(
          content: const Text('Delete Failed!'),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    Widget indicator(index) {
      return Container(
        width: currenIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currenIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 10, left: defaultMargin, right: defaultMargin, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: widget.product.galleries
                ?.map(
                  (image) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Image.network(
                      // ignore: unnecessary_null_comparison
                      image != null
                          ? image.url!
                          : 'https://i0.wp.com/fisip.umrah.ac.id/wp-content/uploads/2022/12/placeholder-2.png?fit=1200%2C800&ssl=1',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currenIndex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries!.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget content() {
      int index = -1;
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            //NOTE HEADER
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          widget.product.category?.name ?? '',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NOTE : DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description ?? '',
                    style: SubtitleTextStyle.copyWith(
                      fontWeight: Light,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget functionalButton() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 64,
              width: MediaQuery.of(context).size.width / 2.3,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItem(product: widget.product),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: backgroundColor3,
                ),
                child: Text(
                  'Update',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                    color: whiteText,
                  ),
                ),
              ),
            ),
            Container(
              height: 64,
              width: MediaQuery.of(context).size.width / 2.3,
              child: TextButton(
                onPressed: () {
                  deleteItem();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Color.fromARGB(187, 233, 90, 80),
                ),
                child: Text(
                  'Delete',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                    color: whiteText,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  header(),
                  content(),
                ],
              ),
            ),
            functionalButton(),
          ],
        ),
      ),
    );
  }
}

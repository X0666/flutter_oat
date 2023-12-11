import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widgets/product_card.dart';
import 'package:shamo/widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    userModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
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
                    'Hallo ${user.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: SubtitleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image_profile.png',
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    // Widget categories() {
    //   return Container(
    //     margin: EdgeInsets.only(
    //       top: defaultMargin,
    //     ),
    //     child: SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: defaultMargin,
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10,
    //             ),
    //             margin: EdgeInsets.only(
    //               right: 16,
    //             ),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               color: primaryColor,
    //             ),
    //             child: Text(
    //               'All Clothes',
    //               style: primaryTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10,
    //             ),
    //             margin: EdgeInsets.only(
    //               right: 16,
    //             ),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: SubtitleColor,
    //               ),
    //               color: transparentColor,
    //             ),
    //             child: Text(
    //               'Clothes Custome',
    //               style: SubtitleTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10,
    //             ),
    //             margin: EdgeInsets.only(
    //               right: 16,
    //             ),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: SubtitleColor,
    //               ),
    //               color: transparentColor,
    //             ),
    //             child: Text(
    //               'Clothes Animals',
    //               style: SubtitleTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10,
    //             ),
    //             margin: EdgeInsets.only(
    //               right: 16,
    //             ),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: SubtitleColor,
    //               ),
    //               color: transparentColor,
    //             ),
    //             child: Text(
    //               'Clothes Little Girl',
    //               style: SubtitleTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 12,
    //               vertical: 10,
    //             ),
    //             margin: EdgeInsets.only(
    //               right: 16,
    //             ),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 color: SubtitleColor,
    //               ),
    //               color: transparentColor,
    //             ),
    //             child: Text(
    //               'Clothes Little Boy',
    //               style: SubtitleTextStyle.copyWith(
    //                 fontSize: 13,
    //                 fontWeight: medium,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: productProvider.products
                    .map(
                      (product) => ProductCard(product),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget newArrivalTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'New Arrivals',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProductTile(product, false),
              )
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        // categories(),
        popularProductsTitle(),
        popularProducts(),
        newArrivalTitle(),
        newArrivals(),
      ],
    );
  }
}

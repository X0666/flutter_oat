import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/theme.dart';

class CartCard extends StatelessWidget {
  final CartModel cart;
  CartCard(this.cart);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      cart.product!.galleries!.isNotEmpty
                          ? cart.product!.galleries![0].url!
                          : 'https://i0.wp.com/fisip.umrah.ac.id/wp-content/uploads/2022/12/placeholder-2.png?fit=1200%2C800&ssl=1',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product?.name ?? '',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '\$${cart.product?.price}',
                      style: priceTextStyle,
                    )
                  ],
                ),
              ),
              Column(
                  // children: [
                  //   GestureDetector(
                  //     onTap: () {
                  //       cartProvider.addQuantity(cart.id ?? 0);
                  //     },
                  //     child: Image.asset(
                  //       'assets/button_add.png',
                  //       width: 16,
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     height: 2,
                  //   ),
                  //   Text(
                  //     cart.quantity.toString(),
                  //     style: whiteTextStyle.copyWith(
                  //       fontWeight: medium,
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     height: 2,
                  //   ),
                  //   GestureDetector(
                  //     onTap: () {
                  //       cartProvider.reduceQuantity(cart.id ?? 0);
                  //     },
                  //     child: Image.asset(
                  //       'assets/button_min.png',
                  //       width: 16,
                  //     ),
                  //   ),
                  // ],
                  )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              cartProvider.removeCart(cart.id ?? 0);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icon_remove.png',
                  width: 12,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Delete',
                  style: alertTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: Light,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

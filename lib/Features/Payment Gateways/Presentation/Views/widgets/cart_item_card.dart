import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Presentation/Views/widgets/quantity_control_button.dart';

class CartItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final int price;
  final int quantity;
  final  void Function() onDeleteProduct;
  final  void Function() onIncreaseQuantity;
  final  void Function() onDecreaseQuantity;
final bool isEndProduct;
  const CartItemCard(
      {super.key,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.onDeleteProduct,
      required this.onIncreaseQuantity,
      required this.onDecreaseQuantity, required   this.isEndProduct});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return  Column(
      children: [
        SizedBox(
          height:deviceHeight*0.14,
          width: double.infinity,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      bottomLeft: Radius.circular(18.r),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                      width: deviceWidth * 0.28,
                      height: double.infinity,
                    )),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: deviceWidth * 0.6,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: GoogleFonts.raleway(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                                overflow: TextOverflow
                                    .ellipsis, // لمنع الانفجار
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: QuantityControlButton(
                                onPressed: onDeleteProduct,
                                icon: FontAwesomeIcons.xmark,
                                isDeleteButton: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 235.w,
                        child: Text(
                          description,
                          style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 235.w,
                        child: Row(
                          children: [
                            Text(
                              '$price EGP',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  // color: const Color(0xffA9B5DF),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: Colors.grey.shade400)),
                              child: Row(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  QuantityControlButton(
                                    onPressed: onDecreaseQuantity,
                                    icon: FontAwesomeIcons.minus,
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  QuantityControlButton(
                                    onPressed: onIncreaseQuantity,
                                    icon: FontAwesomeIcons.plus,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
          SizedBox(height:isEndProduct?0: 13,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // color: Color(0XFFFFFF),
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0XFFFFFFFF),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Successful.png'),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Sad.png'),
                              fit: BoxFit.cover)),
                    ),
                  )
                ]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'No orders yet',
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Orders asigned to you will be displayed here',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

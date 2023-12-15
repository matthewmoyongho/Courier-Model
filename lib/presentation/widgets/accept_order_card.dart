import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcceptOrderCard extends StatefulWidget {
  const AcceptOrderCard({Key? key}) : super(key: key);

  @override
  State<AcceptOrderCard> createState() => _AcceptOrderCardState();
}

class _AcceptOrderCardState extends State<AcceptOrderCard> {
  bool orderAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: orderAccepted ? Color(0XFF181819) : Color(0XFFFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                orderAccepted
                    ? Text(
                        '20min . 23km',
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: orderAccepted
                                ? Color(0XFFFFFFFF)
                                : Color(0XFF181819)),
                      )
                    : Text(
                        '25min . 23km',
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: Color(0XFF181819)),
                      ),
                Expanded(
                  child: SizedBox(),
                ),
                Visibility(
                  visible: !orderAccepted,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        orderAccepted = !orderAccepted;
                      });
                    },
                    child: Text('Accept order'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF4CAF50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                orderAccepted
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            orderAccepted = !orderAccepted;
                          });
                        },
                        child: Text('View'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side:
                              BorderSide(color: Color(0XFFFFFFFF), width: 1.5),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.close),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
              ],
            ),
          ),
          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0XFFF0F1F2),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ntachi-Osa',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF38383A)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '#256 Lane, Milano calipponie, grand emperim street, Enugu',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF696A6B)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Deliver to',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF38383A)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Thinkers Corner, Enugu',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF696A6B)),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

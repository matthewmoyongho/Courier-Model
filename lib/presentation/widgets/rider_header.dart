import 'package:flutter/material.dart';

class RiderHeader extends StatelessWidget {
  const RiderHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.34,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0XFFE6E7E9),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 6.4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1)),
            child: Icon(
              Icons.support_agent_sharp,
              color: Colors.black,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 5,
            color: Color(0XFFFFCA28),
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              height: 35,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.car_crash),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Go offline',
                      style: TextStyle(fontSize: 14),
                    ),
                    //TODO: try Icon button
                  ],
                ),
              ),
            ),
          ),
          Stack(children: [
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1)),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                height: 10,
                width: 10,
              ),
            ),
          ])
        ],
      ),
    );
  }
}

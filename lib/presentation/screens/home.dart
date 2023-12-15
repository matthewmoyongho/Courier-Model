import 'package:courier_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/accept_order_card.dart';
import '../widgets/order_card.dart';
import '../widgets/rider_header.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final pointA = LatLng(37.4223, -122.0848);
  //
  // final pointB = LatLng(37.3346, -122.0090);
  bool orderAvailable = false;

  final pointA = LatLng(37.783333, -122.416667);
  final pointB = LatLng(37.784042, -122.415208);

  Map<PolylineId, Polyline> polylines = {};

  // (37.4223,-1220848)
  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints points = PolylinePoints();
    PolylineResult result = await points.getRouteBetweenCoordinates(
        GOOGLE_MAP_API_KEY,
        PointLatLng(pointA.latitude, pointB.longitude),
        PointLatLng(pointB.latitude, pointB.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    } else {
      print(result.errorMessage);
    }
    return polyLineCoordinates;
  }

  void generatePolylinesFromPoints(List<LatLng> lineCoordinate) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.black, points: lineCoordinate, width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  void initState() {
    super.initState();
    getPolyLinePoints()
        .then((coordinates) => generatePolylinesFromPoints(coordinates));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                    target: pointA,
                    zoom: 16,
                  ),
                  zoomGesturesEnabled: true,
                  markers: {
                    Marker(
                        markerId: MarkerId('CurrentLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: pointA),
                    Marker(
                      markerId: MarkerId('DestinationLocation'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: pointB,
                    ),
                  },
                ),
              ),
              RiderHeader(),
              Positioned(
                bottom: 85,
                left: 0,
                right: 0,
                // child: OrderCard(),
                child: GestureDetector(
                  onTap: () => setState(() {
                    orderAvailable = true;
                  }),
                  child: orderAvailable ? AcceptOrderCard() : OrderCard(),
                ),
              ),
              // Icon(Icons.supp)
            ],
          ),
        ),
      ),

      // backgroundColor: Colors.blue,
    );
  }
}

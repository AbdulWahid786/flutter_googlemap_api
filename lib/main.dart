import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

var api_key = "AIzaSyDMRC3GFBA9uzvFG89BYvk4ip5WmLitd_4";

void main() {
  MapView.setApiKey(api_key);
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MapPage(),
  ));
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = new StaticMapProvider(api_key);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    new Marker("1", "Adil Mart", 33.297687, 73.477510, color: Colors.amber),
    new Marker("2", "Italian Pizza Hut", 33.294628, 73.477936,
        color: Colors.purple),
  ];

  showMap() {
    mapView.show(MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition:
            new CameraPosition(new Location(33.295692, 73.476781), 15.0),
        showUserLocation: true,
        title: "Recent Location"));
    mapView.setMarkers(markers);
    mapView.onMapTapped.listen((_) {
      setState(() {
        mapView.setMarkers(markers);
        mapView.zoomToFit(padding: 100);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraPosition =
        new CameraPosition(new Location(33.295692, 73.476781), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(
        new Location(33.295692, 73.476781), 12,
        height: 400, width: 900, mapType: StaticMapViewType.roadmap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Google Maps"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 300.0,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Show Map Here.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  child: Center(
                    child: Image.network(staticMapUri.toString()),
                  ),
                  onTap: showMap,
                )
              ],
            ),
          ),
          Container(
            padding: new EdgeInsets.only(top: 10.0),
            child: new Text(
              "Tap the map to interact",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: new EdgeInsets.only(top: 25.0),
            child: new Text(
                "Camera Position: \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}"),
          ),
        ],
      ),
    );
  }
}

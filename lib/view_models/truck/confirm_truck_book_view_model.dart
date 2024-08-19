import 'package:taxi_obic/utils/import.dart';

class ConfirmTruckBookViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> controllerMap = Completer<GoogleMapController>();
  // Variable to track which field is active
  bool isSelectingStartingPoint = true;
  String cost = "15000.0 YER";

  // Define TextEditingControllers for starting and arrival points
  TextEditingController startingPointController = TextEditingController();
  TextEditingController arrivalPointController = TextEditingController();

  // Example initial camera position
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(15.371921, 44.195652),
    zoom: 14.4746,
  );

  // Method to update the active TextField based on map selection
  void updateLocation(LatLng position) {
    final String location = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
    if (isSelectingStartingPoint) {
      startingPointController.text = location;
    } else {
      arrivalPointController.text = location;
    }
    notifyListeners();
  }

  void goToDoneBook(context) {
    Navigator.pushReplacementNamed(context, '/doneBook',arguments: {
      "start":startingPointController.text,"arrive":arrivalPointController.text,"cost":cost,"type":"Truck"});
  }

  @override
  void dispose() {
    startingPointController.dispose();
    arrivalPointController.dispose();
    super.dispose();
  }
}

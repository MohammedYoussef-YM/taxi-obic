import 'package:taxi_obic/utils/import.dart';

class TruckViewModel extends ChangeNotifier {

  void goToTruckDetails(context) {
    Navigator.pushReplacementNamed(context, '/truckDriverDetails');
  }

}

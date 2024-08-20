import 'package:taxi_obic/utils/import.dart';

class TaxiViewModel extends ChangeNotifier {
  void goToTaxiDetails(context) {
    Navigator.pushReplacementNamed(context, '/taxiDriverDetails');
  }
}

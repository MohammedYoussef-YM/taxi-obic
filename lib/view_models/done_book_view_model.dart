import 'package:taxi_obic/utils/import.dart';

class DoneBookViewModel extends ChangeNotifier {
  String? startingPoint="1";
  String? arrivalPoint="2";
  String? cost="3";
  String? type="Taxi";

  // دالة للتحقق من وجود بيانات في `arguments`
  void checkArguments(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (arguments != null) {
       startingPoint = arguments["start"];
       arrivalPoint = arguments["arrive"];
       cost = arguments["cost"];
       type = arguments["type"];
      print('Starting Point: $startingPoint');
      print('Arrival Point: $arrivalPoint');
      print('type : $type');
      notifyListeners();
    } else {
      print('No arguments found');
    }
  }

  void goToFinalDoneBook(context) {
    Navigator.pushReplacementNamed(context, '/finalDoneBook',arguments: {
      "cost":cost
    });
  }

}
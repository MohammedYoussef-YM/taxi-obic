import 'package:taxi_obic/utils/import.dart';

class ValidationProvider extends ChangeNotifier {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? validInput(String val, int min, int max, String type, {int? maxVal = 0}) {
    _errorMessage = null;  // Reset the error message before validation

    if (maxVal != 0) {
      if (int.parse(val) > maxVal!) {
        _errorMessage = 'يجب ان يكون اصغر من $maxVal';
        notifyListeners();
        return _errorMessage;
      }
    }

    if (type == "username") {
      if (!_isUsername(val)) {
        _errorMessage = "اسم المستخدم غير صالح";
        notifyListeners();
        return _errorMessage;
      }
    }

    if (type == "phone") {
      if (!_isPhoneNumber(val)) {
        print(val);
        _errorMessage = "رقم الهاتف غير صحيح";
        notifyListeners();
        return _errorMessage;
      }
    }

    if (val.isEmpty) {
      _errorMessage = "لا يمكن ان يكون فارغ";
      notifyListeners();
      return _errorMessage;
    }

    if (val.length < min) {
      _errorMessage = "لا يمكن ان يكون اقل من $min";
      notifyListeners();
      return _errorMessage;
    }

    if (val.length > max) {
      _errorMessage = "لا يمكن ان يكون اكثر من $max";
      notifyListeners();
      return _errorMessage;
    }

    return null;
  }

  // دوال مساعدة للتحقق من صحة اسم المستخدم ورقم الهاتف
  bool _isUsername(String val) {
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    return usernameRegExp.hasMatch(val);
  }

  bool _isPhoneNumber(String val) {
    final phoneRegExp = RegExp(r'^[0-9]{9}$'); // مثال على تحقق بسيط
    return phoneRegExp.hasMatch(val);
  }
}

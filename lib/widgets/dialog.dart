import 'package:taxi_obic/utils/import.dart';

void showTaxiInfoDialog(Taxi taxi,context) {
  showDialog(
    context: context, // Make sure you have access to BuildContext
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Driver Information'),
        content: Text('Driver: ${taxi.driverName}\nType: ${taxi.type}'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle button press
              Navigator.pop(context); // Close the dialog
              // Add any additional logic here
            },
            child: const Text('Custom Button'),
          ),
        ],
      );
    },
  );
}
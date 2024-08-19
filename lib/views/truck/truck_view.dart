import 'package:taxi_obic/utils/import.dart';

class TruckView extends StatelessWidget {
  const TruckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const GoogleMap(
            myLocationEnabled: true,
            trafficEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(15.371921, 44.195652), // Default location
              zoom: 14.4746,
            ),
          ),
          appBarSimple(context,"Back"),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ChangeNotifierProvider(
              create: (_) =>  TruckViewModel(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(70, 44, 70, 32),
                child: Consumer<TruckViewModel>(
                    builder: (context,controller,child) {
                      return CustomButtonGeneral(title: 'Details', isRegisterButton: false, onPressed: () {
                        controller.goToTruckDetails(context);
                      },);
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
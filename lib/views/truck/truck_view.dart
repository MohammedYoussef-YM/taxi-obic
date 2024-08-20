import 'package:taxi_obic/utils/import.dart';

class TruckView extends StatelessWidget {
  const TruckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => TruckViewModel(ApiService(SharedPreferencesService()),SharedPreferencesService())..fetchTrucks(context),
        child: Consumer<TruckViewModel>(
            builder: (context, viewModel, child){
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 66),
                    child: GoogleMap(
                      myLocationEnabled: true,
                      trafficEnabled: true,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(15.371921, 44.195652), // Default location
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        viewModel.mapController.complete(controller);
                        viewModel.controller = controller;
                        viewModel.getCurrentLocation(context);
                      },
                      markers: viewModel.truckMarkers, // Display taxi markers
                    ),
                  ),
                  appBarSimple(context,"Back"),
                ],
              );
            }

        ),
      )
    );
  }
}
import 'package:taxi_obic/utils/import.dart';

class TaxiView extends StatelessWidget {

  const TaxiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => HomeViewModel(ApiService(SharedPreferencesService()),SharedPreferencesService())..fetchTaxis(context),
        child: Consumer<HomeViewModel>(
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
                  markers: viewModel.markers, // Display taxi markers
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
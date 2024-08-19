import 'package:taxi_obic/utils/import.dart';

class ConfirmTaxiBookView extends StatelessWidget {
  const ConfirmTaxiBookView({super.key});

  @override
  Widget build(BuildContext context) {
    final Taxi taxi = ModalRoute.of(context)!.settings.arguments as Taxi;

    return ChangeNotifierProvider(
      create: (_) => ConfirmTaxiBookViewModel(context.read<ApiService>(),context.read<SharedPreferencesService>())..getTaxiData(taxi) ,
      child: Scaffold(
        body: Consumer<ConfirmTaxiBookViewModel>(
          builder: (context, controllers, child) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: controllers.kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    controllers.controllerMap.complete(controller);
                  },
                  onCameraMove: (CameraPosition position) {
                    controllers.updateLocationFromMap(position);
                  },
                  polylines: controllers.polylines,
                ),
                // Fixed marker at the center of the screen
                const Center(
                  child: Icon(Icons.location_on, size: 40, color: Colors.red),
                ),
                appBarSimple(context, "Back"),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF252424),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(33),
                        topRight: Radius.circular(33),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(37, 21, 37, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          CustomTextFieldArrive(
                            hint: 'Starting point',
                            controller: controllers.startingPointController,
                            onPressed: () {
                              controllers.isSelectingStartingPoint = true;
                            },
                            icon: Icons.location_on,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldArrive(
                            hint: 'Arriving point',
                            controller: controllers.arrivalPointController,
                            onPressed: () {
                              controllers.isSelectingStartingPoint = false;
                            },
                            icon: Icons.flag,
                          ),
                          const SizedBox(height: 10),
                          if (controllers.startingPointController.text.isNotEmpty &&
                              controllers.arrivalPointController.text.isNotEmpty)
                            CustomRow(
                              name: 'Cost: ',
                              title: '${controllers.cost}',
                              mainAxisAlignment: MainAxisAlignment.start,
                              fontSize: 24,
                            ),
                          const SizedBox(height: 10),
                          ButtonBook(
                            title: 'Confirm Book',
                            onPressed: () {
                              controllers.goToDoneBook(context,);
                            },
                            isDone: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

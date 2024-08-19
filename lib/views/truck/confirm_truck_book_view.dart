import 'package:taxi_obic/utils/import.dart';

class ConfirmTruckBookView extends StatelessWidget {
  const ConfirmTruckBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmTruckBookViewModel(),
      child: Scaffold(
        body: Consumer<ConfirmTruckBookViewModel>(
            builder: (context, controllers, child) {
          return Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: controllers.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  controllers.controllerMap.complete(controller);
                },
                onTap: (LatLng position) {
                  controllers.updateLocation(position);
                },
              ),
              appBarWithInfo(context,"Truck delivery address","5th Street,26","Truck car #26"),
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
                    padding: const EdgeInsets.fromLTRB(37, 25, 37, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          CustomRow(name: 'cost: ', title: controllers.cost, mainAxisAlignment: MainAxisAlignment.start, fontSize: 22,),
                         ButtonBook(
                            title: 'Confirm Book',
                            onPressed: () {
                              print("Starting Point: ${controllers.startingPointController.text}");
                              print("Arrival Point: ${controllers.arrivalPointController.text}");
                              controllers.goToDoneBook(context);
                            }, isDone: false,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
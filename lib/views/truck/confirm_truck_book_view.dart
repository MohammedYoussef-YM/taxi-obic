import 'package:taxi_obic/utils/import.dart';

class ConfirmTruckBookView extends StatelessWidget {
  const ConfirmTruckBookView({super.key});

  @override
  Widget build(BuildContext context) {
    final Truck truck = ModalRoute.of(context)!.settings.arguments as Truck;

    return ChangeNotifierProvider(
      create: (_) => ConfirmTruckBookViewModel(context.read<ApiService>(),context.read<SharedPreferencesService>())..gettruckData(truck),
      child: Scaffold(
        body: Consumer<ConfirmTruckBookViewModel>(
            builder: (context, viewModel, child) {
          return Stack(
            children: <Widget>[
              // buildGoogleMap(viewModel),
              // appBarWithInfo(context,"Truck delivery address","5th Street,26","Truck car #26"),
              // buildBottomSheet(viewModel, context),
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: viewModel.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  viewModel.controllerMap.complete(controller);
                },
                onCameraMove: (CameraPosition position) {
                  viewModel.updateLocationFromMap(position);
                },
                polylines: viewModel.polylines,
              ),

              appBarWithInfo(context,"Truck delivery address","5th Street,26","Truck car #26"),
              const Center(
                child: Icon(Icons.location_on, size: 40, color: Colors.red),
              ),
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
                          controller: viewModel.startingPointController,
                          onPressed: () {
                            viewModel.isSelectingStartingPoint = true;
                          },
                          icon: Icons.location_on,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldArrive(
                          hint: 'Arriving point',
                          controller: viewModel.arrivalPointController,
                          onPressed: () {
                            viewModel.isSelectingStartingPoint = false;
                          },
                          icon: Icons.flag,
                        ),
                        const SizedBox(height: 10),
                        if (viewModel.startingPointController.text.isNotEmpty &&
                            viewModel.arrivalPointController.text.isNotEmpty)
                          CustomRow(name: 'cost: ', title: '${viewModel.cost}', mainAxisAlignment: MainAxisAlignment.start, fontSize: 22,),
                         ButtonBook(
                            title: 'Confirm Book',
                            onPressed: () {
                              print("Starting Point: ${viewModel.startingPointController.text}");
                              print("Arrival Point: ${viewModel.arrivalPointController.text}");
                              viewModel.goToDoneBook(context);
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

  Positioned buildBottomSheet(ConfirmTruckBookViewModel viewModel, BuildContext context) {
    return Positioned(
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
                        controller: viewModel.startingPointController,
                        onPressed: () {
                          viewModel.isSelectingStartingPoint = true;
                        },
                        icon: Icons.location_on,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFieldArrive(
                        hint: 'Arriving point',
                        controller: viewModel.arrivalPointController,
                        onPressed: () {
                          viewModel.isSelectingStartingPoint = false;
                        },
                        icon: Icons.flag,
                      ),
                      const SizedBox(height: 10),
                      if (viewModel.startingPointController.text.isNotEmpty &&
                          viewModel.arrivalPointController.text.isNotEmpty)
                        CustomRow(name: 'cost: ', title: '${viewModel.cost}', mainAxisAlignment: MainAxisAlignment.start, fontSize: 22,),
                       ButtonBook(
                          title: 'Confirm Book',
                          onPressed: () {
                            print("Starting Point: ${viewModel.startingPointController.text}");
                            print("Arrival Point: ${viewModel.arrivalPointController.text}");
                            viewModel.goToDoneBook(context);
                          }, isDone: false,
                        )
                    ],
                  ),
                ),
              ),
            );
  }

}
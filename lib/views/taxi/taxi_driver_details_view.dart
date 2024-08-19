import 'dart:ui';
import 'package:taxi_obic/utils/import.dart';

class TaxiDriverDetailsView extends StatelessWidget {
  const TaxiDriverDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Taxi taxi = ModalRoute.of(context)!.settings.arguments as Taxi;

    return ChangeNotifierProvider(
      create: (_) => TaxiDriverDetailsViewModel()..specificMarkers(context, taxi),
      child: Scaffold(
        body: Consumer<TaxiDriverDetailsViewModel>(
            builder: (context, viewModel, child) {
          return Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(taxi.latitude, taxi.longitude),
                  // Default location
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  viewModel.mapController.complete(controller);
                  viewModel.controller = controller;
                },
                markers: viewModel.taxiMarkers, // Display taxi markers
              ),
              appBarWithInfo(context,"Taxi delivery address","5th Street,25","Taxi car #12"),
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
                    padding: const EdgeInsets.fromLTRB(37, 11, 37, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(71.5, 0, 0, 2),
                          child: Text(
                            taxi.driverName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Color(0xFFE6E5E3),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 11),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 245,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        0, 0, 6.5, 17),
                                    child: const SizedBox(
                                      width: 60,
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                          color: Color(0xFF90908F),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 7, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 8.7, 0),
                                          child: const Text(
                                            '1,2',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 19,
                                              color: Color(0xFFF3A205),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 7, 0, 5),
                                          child: SizedBox(
                                            width: 107,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  List.generate(5, (index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 3),
                                                  width: 11,
                                                  height: 11,
                                                  decoration:
                                                      const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x40000000),
                                                        offset: Offset(0, 4),
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Icon(Icons.star,
                                                      color: Colors.amber,
                                                      size: 14),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        RowDriverDetails(title: 'car', details: '${taxi.name}'),
                        RowDriverDetails(
                            title: 'color', details: '${taxi.color}'),
                        RowDriverDetails(
                            title: 'type', details: '${taxi.type}'),
                        RowDriverDetails(
                            title: 'model', details: '${taxi.model}'),
                        RowDriverDetails(
                            title: 'capacity', details: '${taxi.capacity}'),
                        ButtonBook(
                          title: 'Book',
                          onPressed: () {
                            viewModel.goToConfirmTaxiBook(context,taxi);
                          }, isDone: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                bottom: 228,
                child: SizedBox(
                  width: 67,
                  height: 66,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 6,
                        bottom: 5,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 0,
                              sigmaY: 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27.5),
                                color: const Color(0xFF252424),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Container(
                                width: 55,
                                height: 55,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImageAsset.man),
                            ),
                          ),
                          child: Container(
                            width: 50,
                            height: 66,
                          ),
                        ),
                      ),
                    ],
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

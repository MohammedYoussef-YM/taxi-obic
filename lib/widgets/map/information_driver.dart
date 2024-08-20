import 'package:taxi_obic/utils/import.dart';

class InformationDriver extends StatelessWidget {
  const InformationDriver({
    super.key,
    required this.taxi,
    required this.isTaxi,
    required this.viewModel,
  });

  final dynamic taxi;
  final bool isTaxi;
  final dynamic viewModel;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.fromLTRB(37, 11, 37, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(65.5, 0, 0, 2),
                child: Text(
                  taxi.driverName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
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
              RowDriverDetails(title:  'car', details: '${taxi.name}'),
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
                  isTaxi? viewModel.goToConfirmTaxiBook(context,taxi):viewModel.goToConfirmTruckBook(context,taxi);
                }, isDone: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
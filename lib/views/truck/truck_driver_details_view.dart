import 'package:taxi_obic/utils/import.dart';
import 'dart:ui';

class TruckDriverDetailsView extends StatelessWidget {
  const TruckDriverDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Truck truck = ModalRoute.of(context)!.settings.arguments as Truck;

    return ChangeNotifierProvider(
      create: (_) => TruckDriverDetailsViewModel()..specificMarkers(context, truck),
      child: Scaffold(
        body: Consumer<TruckDriverDetailsViewModel>(
            builder: (context, viewModel, child) {
          return Stack(
            children: <Widget>[
              ShowDetailsMap(taxi: truck,viewModel:viewModel),
              appBarWithInfo(context,"Truck delivery address","5th Street,25","Truck car #26"),
              InformationDriver(taxi: truck,isTaxi: false,viewModel:viewModel),
              const DriverImage(),
            ],
          );
        }),
      ),
    );
  }
}


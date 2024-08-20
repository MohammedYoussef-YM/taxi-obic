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
              ShowDetailsMap(taxi: taxi,viewModel:viewModel),
              appBarWithInfo(context,"Taxi delivery address","5th Street,25","Taxi car #12"),
              InformationDriver(taxi: taxi,isTaxi: true,viewModel:viewModel),
              const DriverImage(),
            ],
          );
        }),
      ),
    );
  }
}
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
              ShowConfirmMap(viewModel: viewModel),
              appBarWithInfo(context,"Truck delivery address","5th Street,26","Truck car #26"),
              // Fixed marker at the center of the screen
              const Center(
                child: Icon(Icons.location_on, size: 40, color: Colors.red),
              ),
              BottomSheetConfirmBook(viewModel: viewModel)
            ],
          );
        }),
      ),
    );
  }
}
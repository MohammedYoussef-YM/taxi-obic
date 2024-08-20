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
          builder: (context, viewModel, child) {
            return Stack(
              children: <Widget>[
                ShowConfirmMap(viewModel: viewModel),
                // Fixed marker at the center of the screen
                const Center(
                  child: Icon(Icons.location_on, size: 40, color: Colors.red),
                ),
                appBarSimple(context, "Back",false),
                BottomSheetConfirmBook(viewModel: viewModel)
              ],
            );
          },
        ),
      ),
    );
  }
}
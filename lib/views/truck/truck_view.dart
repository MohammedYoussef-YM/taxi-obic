import 'package:taxi_obic/utils/import.dart';

class TruckView extends StatelessWidget {
  const TruckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => TruckViewModel(ApiService(SharedPreferencesService()),SharedPreferencesService())..fetchTrucks(context),
        child: Consumer<TruckViewModel>(
            builder: (context, viewModel, child){
              return Stack(
                children: <Widget>[
                  ShowMap(viewModel: viewModel),
                  appBarSimple(context,"Back",false),
                ],
              );
            }
        ),
      )
    );
  }
}
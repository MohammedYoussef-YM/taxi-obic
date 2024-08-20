import 'package:taxi_obic/utils/import.dart';

class TaxiView extends StatelessWidget {
  const TaxiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          ApiService(SharedPreferencesService()), SharedPreferencesService())
        ..fetchTaxis(context),
      child: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        return Stack(
          children: <Widget>[
            ShowMap(viewModel: viewModel),
            appBarSimple(context, "Back",false),
          ],
        );
      }),
    ));
  }
}

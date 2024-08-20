import 'package:taxi_obic/utils/import.dart';

class TruckView extends StatelessWidget {
  const TruckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const ShowMap(),
          appBarSimple(context,"Back"),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ChangeNotifierProvider(
              create: (_) =>  TruckViewModel(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(70, 44, 70, 32),
                child: Consumer<TruckViewModel>(
                    builder: (context,viewModel,child) {
                      return CustomButtonGeneral(title: 'Details', isRegisterButton: false, onPressed: () {
                        viewModel.goToTruckDetails(context);
                      },);
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
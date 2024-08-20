import 'package:taxi_obic/utils/import.dart';

class TaxiView extends StatelessWidget {

  const TaxiView({super.key});

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
              create: (_) =>  TaxiViewModel(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(70, 44, 70, 32),
                child: Consumer<TaxiViewModel>(
                    builder: (context,viewModel,child) {
                      return CustomButtonGeneral(title: 'Details', isRegisterButton: false, onPressed: () {
                        viewModel.goToTaxiDetails(context);
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
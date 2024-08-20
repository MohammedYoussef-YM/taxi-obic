import 'package:taxi_obic/utils/import.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(ApiService(SharedPreferencesService()),SharedPreferencesService())..fetchTaxis(context),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                buildShowMap(),
                appBarSimple(context,"Taxi delivery address",true),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomContainer(viewModel,context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildShowMap() {
    return const Padding(
                padding: EdgeInsets.only(top: 66),
                child: GoogleMap(
                  myLocationEnabled: true,
                  trafficEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(15.371921, 44.195652), // Default location
                    zoom: 14.4746,
                  ),
                ),
              );
  }
}

Widget _buildBottomContainer(HomeViewModel viewModel,context) {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFF252424),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(33),
        topRight: Radius.circular(33),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.fromLTRB(30, 44, 30, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildVehicleSelection(context),
        ],
      ),
    ),
  );
}

Widget _buildVehicleSelection(context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildVehicleImage(context,AppImageAsset.taxiRectangle, 'TAXI','/taxi'),
          _buildVehicleImage(context,AppImageAsset.truckRectangle, 'Truck','/truck'),
        ],
      ),
    ],
  );
}

Widget _buildVehicleImage(BuildContext context,String asset, String label,screen) {
  return Column(
    children: [
      InkWell(
        onTap: (){
          Navigator.pushNamed(context, screen);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 11),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEEAF34)),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(asset),
            ),
            boxShadow: const [
              BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 2),
            ],
          ),
          child: const SizedBox(width: 110, height: 100),
        ),
      ),
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Color(0xFFE6E5E3),
        ),
      ),
    ],
  );
}

import 'package:lottie/lottie.dart';
import 'package:taxi_obic/utils/import.dart';

class DoneBookView extends StatelessWidget {
  const DoneBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoneBookViewModel()..checkArguments(context),
      child: Builder(builder: (context) {
        // هنا يتم التأكد من استدعاء checkArguments بعد إنشاء DoneBookViewModel
        Future.microtask(() {
          final doneBookViewModel = Provider.of<DoneBookViewModel>(context, listen: false);
          doneBookViewModel.checkArguments(context);
        });
        return Scaffold(
          body: SafeArea(
            child: Consumer<DoneBookViewModel>(
                builder: (context, viewModel, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppBarDoneBook(type: viewModel.type,driverName:viewModel.driverName ,),
                        const Line(height: 4),
                        buildContentOfPage(viewModel, context),
                      ],
                    ),
                  );
                }),
          ),
        );
      }),
    );
  }

  Padding buildContentOfPage(DoneBookViewModel viewModel, BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text("Starting point",style: TextStyle(color: Colors.grey),),
                            CustomColumnForDoneBook(title: viewModel.startingPoint, icon: Icons.location_on),
                            const Text("Arriving point",style: TextStyle(color: Colors.grey),),
                            CustomColumnForDoneBook(title: viewModel.arrivalPoint, icon: Icons.flag),
                            const CustomColumnForDoneBook(title: "It takes 18 minutes to reach you.", icon: Icons.access_time),
                            const CustomColumnForDoneBook(title: "Please wait at the arrival point", icon: Icons.accessibility),
                            // Center(child: Image.asset(AppImageAsset.taxiRound,width: MediaQuery.of(context).size.height * .34)),
                            Center(child: Lottie.asset(AppImageAsset.loading)),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .65,
                                child:  ButtonBook(
                                        title: 'Done',
                                        onPressed: () {
                                          // viewModel.goToFinalDoneBook(context);
                                          print("done");
                                        }, isDone: true,
                                      )
                              ),
                            ),
                          ],
                        ),
                      );
  }
}

class AppBarDoneBook extends StatelessWidget {
  final String? type;
  final String? driverName;
  const AppBarDoneBook({
    super.key, this.type, this.driverName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap: (){Navigator.pop(context);},
              child: const Icon(Icons.arrow_circle_left_outlined,color: AppColor.primaryColor,size: 40,)),
          Transform(
            transform: Matrix4.translationValues(-12.0, 0.0, 0.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppImageAsset.circle,height: 80),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type!,style: const TextStyle(color: Colors.grey),),
                        const Line(height: 1),
                         Text("${driverName}"),
                      ],),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  final double height;
  const Line({
    super.key, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      width: MediaQuery.of(context).size.width ,
      height: height,
      decoration: const BoxDecoration(
        color: Color(0x70898080),
      ),
    );
  }
}

class CustomColumnForDoneBook extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const CustomColumnForDoneBook({
    super.key,required this.title,required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 5),
              Expanded(
                child: SingleChildScrollView(scrollDirection :Axis.vertical,
                    child: Text( title ?? "Loading...", overflow: TextOverflow.ellipsis, // لضمان قطع النص في حال كان طويلًا جدًا),
                ),
              ),
              )
            ],
          ),
          const SizedBox(width: 10),
          const Line(height: 1)
        ],
      ),
    );
  }
}

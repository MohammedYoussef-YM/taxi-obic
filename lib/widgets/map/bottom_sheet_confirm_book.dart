import 'package:taxi_obic/utils/import.dart';

class BottomSheetConfirmBook extends StatelessWidget {
  const BottomSheetConfirmBook({
    super.key,
    required this.viewModel,
  });

  final dynamic viewModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF252424),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(33),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(37, 21, 37, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              CustomTextFieldArrive(
                hint: 'Starting point',
                controller: viewModel.startingPointController,
                onPressed: () {
                  viewModel.isSelectingStartingPoint = true;
                },
                icon: Icons.location_on,
              ),
              const SizedBox(height: 10),
              CustomTextFieldArrive(
                hint: 'Arriving point',
                controller: viewModel.arrivalPointController,
                onPressed: () {
                  viewModel.isSelectingStartingPoint = false;
                },
                icon: Icons.flag,
              ),
              const SizedBox(height: 10),
              if (viewModel.startingPointController.text.isNotEmpty &&
                  viewModel.arrivalPointController.text.isNotEmpty)
                CustomRow(
                  name: 'Cost: ',
                  title: '${viewModel.cost}',
                  mainAxisAlignment: MainAxisAlignment.start,
                  fontSize: 24,
                ),
              const SizedBox(height: 10),
              ButtonBook(
                title: 'Confirm Book',
                onPressed: () {
                  viewModel.goToDoneBook(context,);
                },
                isDone: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
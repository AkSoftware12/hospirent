
import 'package:hospirent/View/Demo/const/app_colors.dart';
import 'package:hospirent/View/Demo/widgets/text/text_builder.dart';

import '../imports.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBuilder(text: 'Hos', color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        TextBuilder(text: 'Pirent', color:  Colors.white, fontSize: 30,fontWeight: FontWeight.w700),
      ],
    );
  }
}

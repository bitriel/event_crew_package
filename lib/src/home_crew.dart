import 'package:event_crew/src/components/home/bottom_c.dart';
import 'package:event_crew/src/components/text_c.dart';
import 'package:event_crew/src/tool/app_utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PageController controller = PageController();
  
  int? active = 0; 

  @override
  void initState() {

    controller.addListener(() {
      setState(() {
        
        active = controller.page!.toInt();
      });
    });
    super.initState();
  }

  Color? color = Colors.green.withOpacity(0.3);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppUtil.convertHexaColor("#F2F2F2"),
      body: SafeArea(
        child: PageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              active = controller.page!.toInt();

              if (controller.page!.toInt() == 0){
                color = Colors.blue.withOpacity(0.3);
              } else if ((controller.page!.toInt() == 1)){
                color = Colors.red.withOpacity(0.3);
              }
            });
          },
          children: const [
            MyText(text: "Admission",),
            MyText(text: "CheckOut",)
            // Check(tabType: 'Check',),
            // Admission(tabType: 'Admission'),
            // const CheckOut(),
          ],
        ),
      ),
      bottomNavigationBar: bottomAppBarNoCheck(context: context, controller: controller, active: active)
    );
  }
}
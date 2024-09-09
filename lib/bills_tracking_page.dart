import 'package:flutter/material.dart';
import 'scaffold_drawer.dart';
import 'scaffold_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BillsTrackingPage extends StatefulWidget {
  const BillsTrackingPage({super.key});

  @override
  State<BillsTrackingPage> createState() => _BillsTrackingPageState();
}

class _BillsTrackingPageState extends State<BillsTrackingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<double> bills = [101.99, 1030.7225, 250, 620.55, 1030.72, 250, 620.55];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, screenHeight * 0.065),
        child: const AppBarForMainScaffold()
      ),
      drawer: const DrawerForMainScaffold(),
      body: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.025, bottom: screenHeight * 0.025),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), 
                color: Colors.white, 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2)
                  )
                ]
              ),
              child: Center(
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        const Text("Payment Circle", textScaler: TextScaler.linear(1.5), style: TextStyle(fontWeight: FontWeight.bold,),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: createCircularWidgets(),
                            ),
                          ]
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
            SizedBox(height: screenHeight * 0.038,),
            DefaultTabController(
              length: 3,
              initialIndex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2)
                    )
                  ]
                ),
                child: const TabBar(
                  textScaler: TextScaler.linear(1.2),
                  dividerHeight: 0,
                  indicatorColor: Color.fromARGB(255, 86, 134, 32),
                  labelColor: Color.fromARGB(255, 86, 134, 32),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5,
                  tabs: [
                    Tab(text: "Week",),
                    Tab(text: "Month",),
                    Tab(text: "Year",),
                  ]
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.0175,),
            Container(
              height: screenHeight * 0.383,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), 
                color: Colors.white, 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2)
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListView.builder(
                  itemCount: bills.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Container(
                        height: screenHeight * 0.0925,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25), 
                          color: Colors.white, 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, 1)
                            )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 15),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(10), ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.home_filled, size: 40, color: Colors.white,)
                              ),
                              SizedBox(width: screenWidth * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenWidth * 0.015,),
                                  const Text("Water Bill", textScaler: TextScaler.linear(1.35),),
                                  //const Text("Monthly", textScaler: TextScaler.linear(0.9),),
                                ],
                              ),
                              Expanded(child: SizedBox(child: SizedBox(child: Text("£${bills[index]}", textScaler: const TextScaler.linear(1.35), textAlign: TextAlign.right,)))),
                              SizedBox(width: screenWidth * 0.01,),
                              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded))
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class CircularPercentIndicatorSection extends StatelessWidget {
  final double circleSize;
  final Color color;
  const CircularPercentIndicatorSection({super.key, required this.circleSize, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1250,
      radius: 120.0,
      lineWidth: 24.0,
      percent: circleSize,
      progressColor: color,
      backgroundColor: Colors.transparent,
      circularStrokeCap: CircularStrokeCap.butt,
    );
  }
}

List<double> getCircleSizes(List<double> paymentAmounts){
  List<double> circleSizeAmounts = [];
  double total = 0;
  double onePercentCircle = 0;
  paymentAmounts.sort();

  for (double number in paymentAmounts){
    total += number;
  }

  onePercentCircle = 1 / total;

  double circleRemaining = 1.0;
  for (double number in paymentAmounts){
    circleSizeAmounts.add(circleRemaining);
    circleRemaining -= number * onePercentCircle;
  }
  return circleSizeAmounts;
}

Widget createCircularWidgets() {
  List<double> circleSizes = getCircleSizes([100, 32, 72, 55, 20]);
  List<Color> colorsForSegments = [Colors.green, const Color.fromARGB(255, 44, 133, 90), Colors.lightGreen, const Color.fromARGB(255, 100, 141, 52), const Color.fromARGB(255, 45, 116, 47),Colors.purple];
  List<Widget> percentCircleWidgets = [];

  int index = 0;
  for (double section in circleSizes){
    percentCircleWidgets.add(CircularPercentIndicatorSection(circleSize: section, color: colorsForSegments[index],));
    index += 1;
  }

  return Stack(
    alignment: Alignment.center, 
    children: [
      const CircleAvatar(
        backgroundColor: Colors.white, 
        radius: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("July Payments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            Text("Remaining:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            Text("£1,250", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),),
            Text(""),//Used to push the text up slightly
          ],
        ),
      ),
      
      Stack(children: percentCircleWidgets,)
    ]
  );
}
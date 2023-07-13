import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatemodel.dart';
import '../Services/utilities/state_services.dart';
import 'countries_list.dart';

class WorldStatScreen extends StatefulWidget {
  const WorldStatScreen({super.key});

  @override
  State<WorldStatScreen> createState() => _WorldStatScreenState();
}

class _WorldStatScreenState extends State<WorldStatScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = // animation
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices(); // call stateservices class

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              FutureBuilder(
                future: stateServices.fatchWorldStateRecords(),
                builder: (context, AsyncSnapshot<WorldstateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFoldingCube(
                          // for circular rotation
                          color: Colors.white,
                          size: 60.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartRadius: 150,
                          legendOptions: const LegendOptions(
                              legendPosition:
                                  LegendPosition.left), // for position of chart
                          animationDuration: const Duration(
                              milliseconds: 2000), // time of animation
                          chartType: ChartType.ring, // type of chart ring/disc
                          colorList: const [
                            Color(0xff4285F4),
                            Color.fromRGBO(40, 242, 18, 1),
                            Color.fromARGB(255, 255, 0, 0),
                          ],
                          chartValuesOptions: const ChartValuesOptions(
                              // show chart value in percent
                              showChartValuesInPercentage: true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .02),
                          child: Expanded(
                            child: SingleChildScrollView(
                              child: Card(
                                child: Column(children: [
                                  ReuseableRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Today Cases',
                                    value: snapshot.data!.todayCases.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString(),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountriesList(),
                                )); // calling countries list here
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(40, 242, 18, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

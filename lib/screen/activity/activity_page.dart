import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impact_pratama/bloc/activities_bloc.dart';
import 'package:impact_pratama/screen/activity/activity_form.dart';
import 'package:impact_pratama/utils/routes.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Map> list = [
    {
      "time": "2020-06-16T10:31:12.000Z",
      "message":
          "P2 BGM-01 HV buiten materieel (Gas lekkage) Franckstraat Arnhem 073631"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "message": "A1 Brahmslaan 3862TD Nijkerk 73278"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "message": "A2 NS Station Rheden Dr. Langemijerweg 6991EV Rheden 73286"
    },
    {
      "time": "2020-06-15T09:41:18.000Z",
      "message": "A2 VWS Utrechtseweg 6871DR Renkum 74636"
    },
    {
      "time": "2020-06-14T09:40:58.000Z",
      "message":
          "B2 5623EJ : Michelangelolaan Eindhoven Obj: ziekenhuizen 8610 Ca CATH route 522 PAAZ Rit: 66570"
    }
  ];

  ActivitiesBloc activitiesBloc = ActivitiesBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 170,
                  child: TextButton(
                      child: Text("Open".toUpperCase(),
                          style: TextStyle(fontSize: 12, color: Colors.blue)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: () => null),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 170,
                  child: TextButton(
                      child: Text("Complete".toUpperCase(),
                          style: TextStyle(fontSize: 12)),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: () => null),
                ),
              ]),
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (_) => activitiesBloc..add(GetActivities()),
              child: BlocBuilder<ActivitiesBloc, ActivitiesState>(
                builder: (context, state) {
                  if (state is ActivitiesGetAll) {
                    return ListView.builder(
                        itemCount: state.activitiesModel.activities?.length,
                        itemBuilder: (_, index) {
                          final String? activityType = state
                              .activitiesModel.activities?[index].activityType;
                          final String? institution = state
                              .activitiesModel.activities?[index].institution;
                          bool isSameDate = true;
                          final String? dateString =
                              state.activitiesModel.activities?[index].when;
                          final DateTime date = DateTime.parse(dateString!);
                          final item = state.activitiesModel.activities?[index];
                          if (index == 0) {
                            isSameDate = false;
                          } else {
                            final String? prevDateString = state
                                .activitiesModel.activities?[index - 1].when;
                            final DateTime prevDate =
                                DateTime.parse(prevDateString!);
                            isSameDate = date.isSameDate(prevDate);
                          }
                          if (index == 0 || !(isSameDate)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      date.formatDate(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, activityFormRoute,
                                                  arguments: ActivityFormArgs(
                                                      activitiesId: 123456));
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        date.formatTime())),
                                                Expanded(
                                                  flex: 8,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors
                                                                .lightBlueAccent[
                                                            400]),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        activityType
                                                                .toString() +
                                                            ' with ' +
                                                            institution
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                            );
                          } else {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, activityFormRoute,
                                              arguments: ActivityFormArgs(
                                                  activitiesId: 123456));
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(date.formatTime())),
                                            Expanded(
                                              flex: 8,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors
                                                        .lightBlueAccent[400]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    list[index]['message'],
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ));
                          }
                        });
                  } else {
                    return SizedBox();
                  }
                },
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, activityFormRoute,
              arguments: ActivityFormArgs(activitiesId: null));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

const String dateFormatter = 'EEEE, dd MMMM y';
const String timeFormatter = 'HH:mm';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  String formatTime() {
    final formatter = DateFormat(timeFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

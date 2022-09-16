import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impact_pratama/bloc/activities_bloc.dart';
import 'package:impact_pratama/screen/activity/widget/label_form.dart';
import 'package:intl/intl.dart';

class ActivityFormArgs {
  final int? activitiesId;

  ActivityFormArgs({this.activitiesId});
}

List<DropdownMenuItem<String>> get actTypeItems {
  List<DropdownMenuItem<String>> actType = [
    DropdownMenuItem(child: Text("Meeting"), value: "meeting"),
    DropdownMenuItem(child: Text("Phone Call"), value: "call"),
  ];
  return actType;
}

List<DropdownMenuItem<String>> get objectiveItems {
  List<DropdownMenuItem<String>> objectItems = [
    DropdownMenuItem(child: Text("New Order"), value: "New Order"),
    DropdownMenuItem(child: Text("Invoice"), value: "Invoice"),
  ];
  return objectItems;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class ActivityFormPage extends StatefulWidget {
  const ActivityFormPage({Key? key, required this.args}) : super(key: key);

  final ActivityFormArgs args;

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValueAct;
  String? selectedValueObj;

  TextEditingController actTypeController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController whenDateController = TextEditingController();

  String? whenDate;
  String? message;
  final format = DateFormat("yyyy-MM-dd");
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? openDate;

  ActivitiesBloc _activitiesBloc = ActivitiesBloc();

  @override
  void initState() {
    if (widget.args.activitiesId.runtimeType != Null) {
      print("sini cari");
      _activitiesBloc
        ..add(ActivitiesById(int.parse(widget.args.activitiesId.toString())));
    }
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
                child: SizedBox()),
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => _activitiesBloc,
        child: BlocListener<ActivitiesBloc, ActivitiesState>(
          listener: (context, state) {
            if (state is DataActivitiesById) {
              setState(() {
                selectedValueAct = state.activityTpe;
              });

              selectedValueObj = state.object;
              institutionController.text = state.institution;
              whenDateController.text = state.when;
              remarksController.text = state.remarks.toString();
            }

            if (state is MessageState) {
              if (state.message == 'Success!') {
                const snackBar = SnackBar(
                  content: Text('Success'),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelFormWidget(label: "What do you want to do?"),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          // filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                            value == null ? "Choose Activity Type" : null,
                        // dropdownColor: Colors.blueAccent,
                        value: selectedValueAct,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValueAct = newValue!;
                          });
                        },
                        items: actTypeItems),
                    LabelFormWidget(label: "Who do you want to meet / call?"),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        // style: TextStyle(color: Colors.blue),
                        controller: institutionController,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          // filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Must required';
                          }
                          return null;
                        }),
                    LabelFormWidget(label: "When do you want to meet/call?"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        // filled: true,
                        fillColor: Colors.grey,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5, color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onTap: () {
                        _selectDate(context, 'openDate');
                      },
                      controller: whenDateController,
                      focusNode: AlwaysDisabledFocusNode(),
                    ),
                    LabelFormWidget(label: "Why do you want to meet/call?"),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          // filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                            value == null ? "Choose Object" : null,
                        // dropdownColor: Colors.blueAccent,
                        value: selectedValueObj,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValueObj = newValue!;
                          });
                        },
                        items: objectiveItems),
                    LabelFormWidget(
                        label: "Could you describe it more details ?"),
                    TextFormField(
                        maxLines: 4,
                        textInputAction: TextInputAction.next,
                        // style: TextStyle(color: Colors.blue),
                        controller: remarksController,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          // filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Must required';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(16),
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.args.activitiesId.runtimeType ==
                                  Null) {
                                _activitiesBloc.add(PostActivities(
                                    id: null,
                                    activityTpe: selectedValueAct.toString(),
                                    institution: institutionController.text,
                                    when: whenDateController.text,
                                    object: selectedValueObj.toString(),
                                    remarks: remarksController.text));
                              } else {
                                _activitiesBloc.add(UpdateActivities(
                                    id: widget.args.activitiesId,
                                    activityTpe: selectedValueAct.toString(),
                                    institution: institutionController.text,
                                    when: whenDateController.text,
                                    object: selectedValueObj.toString(),
                                    remarks: remarksController.text));
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay> _selectTime(BuildContext context, dateType) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  _selectDate(BuildContext context, dateType) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: openDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (newSelectedDate != null) {
      openDate = newSelectedDate;

      whenDateController
        ..text = DateFormat('yyyy-MM-dd HH:mm:ss').format(openDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: whenDateController.text.length,
            affinity: TextAffinity.upstream));

      final time = await _selectTime(context, dateType);

      setState(() {
        DateTime openDate = DateTime(
          newSelectedDate.year,
          newSelectedDate.month,
          newSelectedDate.day,
          time.hour,
          time.minute,
        );

        whenDateController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(openDate);
        whenDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(openDate);
      });
    }
  }
}

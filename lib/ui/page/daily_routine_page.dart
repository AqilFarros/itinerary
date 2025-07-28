part of 'page.dart';

class DailyRoutinePage extends StatefulWidget {
  const DailyRoutinePage({super.key});

  @override
  State<DailyRoutinePage> createState() => _DailyRoutinePageState();
}

class _DailyRoutinePageState extends State<DailyRoutinePage> {
  final dailyRoutine = RoutineService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  String selectedCategory = '';
  final category = [
    'housekeeping',
    'sport',
    'education',
    'cooking',
    'entertainment',
  ];

  @override
  void initState() {
    selectedCategory = category[0];
    super.initState();
  }

  void addRoutine() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        await dailyRoutine.addRoutine(
          name: nameController.text,
          type: selectedCategory,
          start: startController.text,
          end: endController.text,
        );
        if (!mounted) return;
        setState(() {
          nameController.clear();
          typeController.clear();
          startController.clear();
          endController.clear();
        });
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: isLoading
              ? [
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ]
              : [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Theme.of(context).hintColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addRoutine();
                    },
                    child: Text(
                      "Add",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ],
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  controller: nameController,
                  label: "Name",
                  hint: "Activitie's name",
                  validator: InputValidator.requiredField,
                ),
                SizedBox(height: AppTheme.defaultMargin),
                DropdownButtonFormField(
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  isExpanded: true,
                  value: selectedCategory,
                  validator: InputValidator.requiredField,
                  items: category
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                ),
                SizedBox(height: AppTheme.defaultMargin),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: startController,
                        label: "Start",
                        hint: "05:00",
                        onTap: () {
                          _selectTime(startController, startTime);
                        },
                        validator: InputValidator.requiredField,
                      ),
                    ),
                    SizedBox(width: AppTheme.defaultMargin),
                    Expanded(
                      child: InputField(
                        controller: endController,
                        label: "End",
                        hint: "06:00",
                        validator: (value) {
                          final required = InputValidator.requiredField(value);
                          if (required != null) return required;

                          if (startTime.isAfter(endTime)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "End time must be after start time",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            );
                            return "End time must be after start time";
                          }

                          return null;
                        },
                        onTap: () {
                          if (startController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please select start time first",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            _selectTime(endController, endTime);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectTime(TextEditingController controller, TimeOfDay time) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
        if (controller == startController) {
          startTime = pickedTime;
        } else {
          endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultMargin),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.blueAccent,
              Colors.lightBlue,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppTheme.defaultMargin * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppTheme.defaultMargin - 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(AppTheme.defaultMargin - 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.settings,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.defaultMargin),
              Text(
                "My Daily Routine",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(color: Colors.white),
              ),
              SizedBox(height: AppTheme.defaultMargin * 2),
              StreamBuilder(
                stream: dailyRoutine.getRoutine(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: Colors.white);
                  }

                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return SizedBox();
                  }

                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.docs
                          .map(
                            (item) => Container(
                              key: ValueKey(item.id),
                              margin: EdgeInsets.only(
                                bottom: AppTheme.defaultMargin,
                              ),
                              child: SwipeToDeleteRoutine(
                                key: ValueKey(item.id),
                                onDismissed: () async {
                                  await dailyRoutine.deleteRoutine(item.id);
                                },
                                child: CarouselRoutine(
                                  name: item['name'],
                                  type: item['type'],
                                  start: item['start'],
                                  end: item['end'],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }

                  return SizedBox();
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Theme.of(context).hintColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "Add daily routine",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

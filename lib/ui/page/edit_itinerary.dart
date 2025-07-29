part of 'page.dart';

class EditIteneraryPage extends StatefulWidget {
  const EditIteneraryPage({super.key, required this.id,required this.place,required this.type,required this.from,required this.to,required this.description,});

  final String id;
  final String place;
  final String type;
  final Timestamp from;
  final Timestamp to;
  final String description;

  @override
  State<EditIteneraryPage> createState() => _EditIteneraryPageState();
}

class _EditIteneraryPageState extends State<EditIteneraryPage> {
  final TextEditingController placeController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final itinerary = ItineraryService();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    placeController.text = widget.place;
    typeController.text = widget.type;
    fromController.text = Helper.formatDate(widget.from.toDate());
    toController.text = Helper.formatDate(widget.to.toDate());
    descriptionController.text = widget.description; 
    super.initState();
  }

  void editItinerary() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        await itinerary.updateItinerary(
          id: widget.id,
          place: placeController.text,
          description: descriptionController.text,
          from: fromController.text,
          to: toController.text,
          type: typeController.text,
        );

        if (!mounted) return;
        Navigator.of(context).pop({
          'place': placeController.text,
          'type': typeController.text,
          'from': Timestamp.fromDate(Helper.formatDateToISO8601(fromController.text)),
          'to': Timestamp.fromDate(Helper.formatDateToISO8601(toController.text)),
          'description': descriptionController.text,
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

  void _selectDate(
    TextEditingController controller, {
    DateTime? firstDate,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = Helper.formatDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(AppTheme.defaultMargin * 2),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/logo.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Text(
                    "Edit your itinerary",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  InputField(
                    controller: placeController,
                    hint: "ex: Jakarta, Bandung, Bali",
                    label: "Place",
                    validator: InputValidator.requiredField,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: typeController,
                    label: "Type",
                    hint: "ex: family, friends, work",
                    validator: InputValidator.requiredField,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          controller: fromController,
                          label: "From",
                          hint: "15 December 2022",
                          textInputType: TextInputType.name,
                          validator: InputValidator.requiredField,
                          onTap: () {
                            _selectDate(fromController);
                          },
                        ),
                      ),
                      SizedBox(width: AppTheme.defaultMargin),
                      Expanded(
                        child: InputField(
                          controller: toController,
                          label: "To",
                          hint: "16 December 2022",
                          validator: InputValidator.requiredField,
                          onTap: () {
                            if (fromController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select from date first",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              _selectDate(
                                toController,
                                firstDate: Helper.formatDateToISO8601(
                                  fromController.text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: descriptionController,
                    label: "Description",
                    hint: "",
                    maxLine: 5,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: isLoading ? [
                      CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ] : [
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
                      SizedBox(width: AppTheme.defaultMargin),
                      ElevatedButton(
                        onPressed: () {
                          editItinerary();
                        },
                        child: Text(
                          "Update",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
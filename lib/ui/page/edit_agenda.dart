part of 'page.dart';

class EditAgenda extends StatefulWidget {
  const EditAgenda({
    super.key,
    required this.itineraryId,
    required this.agendaId,
    required this.name,
    required this.type,
    required this.location,
    required this.date,
    required this.description,
    required this.fromDate,
    required this.toDate,
  });

  final String itineraryId;
  final String agendaId;
  final String name;
  final String type;
  final String location;
  final Timestamp date;
  final String description;
  final Timestamp fromDate;
  final Timestamp toDate;

  @override
  State<EditAgenda> createState() => _EditAgendaState();
}

class _EditAgendaState extends State<EditAgenda> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final agenda = AgendaService();

  @override
  void initState() {
    nameController.text = widget.name;
    typeController.text = widget.type;
    locationController.text = widget.location;
    dateController.text = Helper.formatDate(widget.date.toDate());
    descriptionController.text = widget.description;
    super.initState();
  }

  void editAgenda() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        await agenda.updateAgenda(
          itineraryId: widget.itineraryId,
          agendaId: widget.agendaId,
          name: nameController.text,
          type: typeController.text,
          place: locationController.text,
          date: dateController.text,
          description: descriptionController.text,
        );

        if (!mounted) return;
        Navigator.pop(context);
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

  void _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: widget.fromDate.toDate(),
      lastDate: widget.toDate.toDate(),
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
                    "Edit agenda",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  InputField(
                    controller: nameController,
                    hint: "Your agenda's name",
                    label: "Place",
                    validator: InputValidator.requiredField,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: typeController,
                    label: "Type",
                    hint: "ex: flight, culiner, shopping",
                    validator: InputValidator.requiredField,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: locationController,
                    label: "Location",
                    hint: "Mall name, zoo name etc",
                    textInputType: TextInputType.name,
                    validator: InputValidator.requiredField,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  InputField(
                    controller: dateController,
                    label: "Date",
                    hint: "15 December 2022",
                    textInputType: TextInputType.name,
                    validator: InputValidator.requiredField,
                    onTap: () {
                      _selectDate(dateController);
                    },
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
                          editAgenda();
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

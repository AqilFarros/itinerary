part of 'page.dart';

class AddAgenda extends StatefulWidget {
  const AddAgenda({super.key, required this.itineraryId, required this.startDate, required this.endDate});

  final String itineraryId;
  final Timestamp startDate;
  final Timestamp endDate;

  @override
  State<AddAgenda> createState() => _AddAgendaState();
}

class _AddAgendaState extends State<AddAgenda> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final agenda = AgendaService();

  void addAgenda() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        await agenda.addAgenda(
          id: widget.itineraryId,
          name: nameController.text,
          type: typeController.text,
          place: locationController.text,
          date: dateController.text,
          description: descriptionController.text,
        );

        if (!mounted) return;
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
      firstDate: widget.startDate.toDate(),
      lastDate: widget.endDate.toDate(),
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
                    "Add your next agenda",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  InputField(
                    controller: nameController,
                    hint: "Your agenda's name",
                    label: "Name",
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
                          addAgenda();
                        },
                        child: Text(
                          "Add",
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

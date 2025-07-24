part of 'page.dart';

class AddAgenda extends StatefulWidget {
  const AddAgenda({super.key});

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
                    children: [
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
                          if (formKey.currentState!.validate()) {}
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

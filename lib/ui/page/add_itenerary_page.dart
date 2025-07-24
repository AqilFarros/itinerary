part of 'page.dart';

class AddIteneraryPage extends StatefulWidget {
  const AddIteneraryPage({super.key});

  @override
  State<AddIteneraryPage> createState() => _AddIteneraryPageState();
}

class _AddIteneraryPageState extends State<AddIteneraryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
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
                    "Add your dream itinerary",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  InputField(
                    controller: nameController,
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
                        ),
                      ),
                      SizedBox(width: AppTheme.defaultMargin),
                      Expanded(
                        child: InputField(
                          controller: toController,
                          label: "To",
                          hint: "16 December 2022",
                          validator: InputValidator.requiredField,
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

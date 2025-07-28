part of 'page.dart';

class ItineraryPage extends StatefulWidget {
  const ItineraryPage({super.key});

  @override
  State<ItineraryPage> createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  final itinerary = ItineraryService();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final typeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  void _updateAgenda() {}

  void _agendaDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Theme.of(context).hintColor, width: 1),
              ),
              child: Text(
                "Cancel",
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Update",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateItinerary(String id) async {
    if (formKey.currentState!.validate()) {
      try {
        await itinerary.updateItinerary(
          id: id,
          place: nameController.text,
          description: descriptionController.text,
          from: fromController.text,
          to: toController.text,
          type: typeController.text,
        );
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
      }
    }
  }

  void _updateDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Theme.of(context).hintColor, width: 1),
              ),
              child: Text(
                "Cancel",
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateItinerary(id);
              },
              child: Text(
                "Update",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipRRect(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: Image.network(
                      'https://i.pinimg.com/736x/35/aa/53/35aa537a8a5a55658c617821fc287357.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(color: Colors.black.withOpacity(0.2)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: AppTheme.defaultMargin * 2),
              padding: EdgeInsets.symmetric(vertical: AppTheme.defaultMargin),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultMargin,
                    ),
                    child: Row(
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
                        GestureDetector(
                          onTap: () {
                            _updateDialog("");
                          },
                          child: Container(
                            padding: EdgeInsets.all(AppTheme.defaultMargin - 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultMargin,
                    ),
                    child: Text(
                      "BATAM",
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultMargin,
                    ),
                    child: Text(
                      "12 December 2025",
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppTheme.defaultMargin,
                    runSpacing: AppTheme.defaultMargin,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppTheme.defaultMargin,
                          horizontal: AppTheme.defaultMargin * 150 / 100,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                        ),
                        child: Text(
                          "Family",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: AppTheme.defaultMargin / 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: AppTheme.defaultMargin,
                          horizontal: AppTheme.defaultMargin * 150 / 100,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                        ),
                        child: Text(
                          "10 Days trip",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  Container(
                    width: 250,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppTheme.defaultMargin * 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://i.pinimg.com/736x/35/aa/53/35aa537a8a5a55658c617821fc287357.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultMargin,
                    ),
                    child: Text(
                      "Itinerary to Batam",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Text(
                    "Upcoming",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: AppTheme.defaultMargin),
                        ActivityCard(),
                        ActivityCard(),
                        ActivityCard(),
                      ],
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Text(
                    "Expired",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: AppTheme.defaultMargin),
                        ActivityCard(),
                        ActivityCard(),
                        ActivityCard(),
                      ],
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultMargin,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add-agenda',
                          arguments: '',
                        );
                      },
                      child: Text(
                        "Add agenda",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

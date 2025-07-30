part of '../page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();

  final birthController = TextEditingController();
  String? selectedGender;
  List<String> gender = ["Man", "Woman", "None"];
  var box = Hive.box('user');

  @override
  void initState() {
    if (box.get('birth') != null && box.get('birth') != '') {
      birthController.text = Helper.formatDate(box.get('birth'));
    }
    if (box.get('gender') != null) {
      selectedGender = box.get('gender');
    }
    super.initState();
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      await box.put('birth', pickedDate);
      setState(() {
        birthController.text = Helper.formatDate(pickedDate);
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
        child: Column(
          children: [
            SizedBox(height: AppTheme.defaultMargin * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
              ],
            ),
            SizedBox(height: AppTheme.defaultMargin),
            FutureBuilder(
              future: authService.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "${snapshot.data!['first_name']} ${snapshot.data!['last_name']}",
                        style: Theme.of(context).textTheme.displayMedium!,
                      ),
                      SizedBox(height: AppTheme.defaultMargin),
                      Text(
                        authService.currentUser!.email!,
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      SizedBox(height: AppTheme.defaultMargin * 2),
                      Row(
                        children: [
                          Expanded(
                            child: InputField(
                              onTap: _selectDate,
                              controller: birthController,
                              label: "Birth",
                              hint: "20 December 2000",
                            ),
                          ),
                          SizedBox(width: AppTheme.defaultMargin),
                          Expanded(
                            child: DropdownButtonFormField(
                              onChanged: (value) async {
                                await box.put('gender', value);
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                              isExpanded: true,
                              style: Theme.of(context).textTheme.bodySmall,
                              value: selectedGender ?? "None",
                              items: gender
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

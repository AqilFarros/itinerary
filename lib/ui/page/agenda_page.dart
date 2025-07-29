part of 'page.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final agenda = AgendaService();

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
              Text(
                "My Agenda",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(color: Colors.white),
              ),
              SizedBox(height: AppTheme.defaultMargin * 2),
              StreamBuilder(
                stream: agenda.getAgenda(),
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
                            (item) => EventCard(
                              name: item['name'],
                              date: item['date'],
                              description: item['description'],
                              type: item['type'],
                              location: item['place'],
                            )
                          )
                          .toList(),
                    );
                  }

                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

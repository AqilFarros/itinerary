part of 'page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();
  final dailyRoutine = RoutineService();
  final itinerary = ItineraryService();
  final agenda = AgendaService();
  late Future<Map<String, dynamic>> user;

  @override
  void initState() {
    user = authService.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueAccent[100]!,
                    Colors.white,
                    Colors.lightBlue[100]!,
                    Colors.lightBlue[200]!,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppTheme.defaultMargin * 4),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultMargin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultMargin,
                  ),
                  child: FutureBuilder(
                    future: user,
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
                        return Text(
                          "👋 Hello ${snapshot.data!['first_name']} ${snapshot.data!['last_name']}",
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultMargin,
                  ),
                  child: Text(
                    "Here's our plan for bright future ✨",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: AppTheme.defaultMargin * 2),
                TitleWidget(text: "My Daily Routine"),
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
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.defaultMargin,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/daily-routine');
                          },
                          child: Text(
                            "Add routinity",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/daily-routine');
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            height: 110,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          items: snapshot.data!.docs
                              .map(
                                (item) => CarouselRoutine(
                                  name: item['name'],
                                  type: item['type'],
                                  start: item['start'],
                                  end: item['end'],
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }

                    return SizedBox();
                  },
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
                        children:
                            [
                              TitleWidget(text: "My Upcoming Event"),
                              SizedBox(height: AppTheme.defaultMargin),
                            ] +
                            snapshot.data!.docs
                                .take(2)
                                .map(
                                  (item) => EventCard(
                                    name: item['name'],
                                    date: item['date'],
                                    description: item['description'],
                                    type: item['type'],
                                    location: item['place'],
                                  ),
                                )
                                .toList() +
                            [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: AppTheme.defaultMargin,
                                ),
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/agenda');
                                  },
                                  child: Text(
                                    "See more",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: AppTheme.defaultMargin),
                            ],
                      );
                    }

                    return SizedBox();
                  },
                ),
                TitleWidget(text: "My Dream Itinerary"),
                SizedBox(height: AppTheme.defaultMargin),
                StreamBuilder(
                  stream: itinerary.getItinerary(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: Colors.white);
                    }

                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.defaultMargin,
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add-itinerary');
                          },
                          child: Text(
                            "Add itinerary",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      left: AppTheme.defaultMargin,
                                    ),
                                    child: ItineraryCard(
                                      id: snapshot.data!.docs[index].id,
                                      place:
                                          snapshot.data!.docs[index]['place'],
                                      from: snapshot.data!.docs[index]['from'],
                                      to: snapshot.data!.docs[index]['to'],
                                      type: snapshot.data!.docs[index]['type'],
                                      description: snapshot
                                          .data!
                                          .docs[index]['description'],
                                    ),
                                  );
                                } else {
                                  return ItineraryCard(
                                    id: snapshot.data!.docs[index].id,
                                    place: snapshot.data!.docs[index]['place'],
                                    from: snapshot.data!.docs[index]['from'],
                                    to: snapshot.data!.docs[index]['to'],
                                    type: snapshot.data!.docs[index]['type'],
                                    description: snapshot
                                        .data!
                                        .docs[index]['description'],
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: AppTheme.defaultMargin / 2),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: AppTheme.defaultMargin,
                            ),
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/add-itinerary');
                              },
                              child: Text(
                                "Add itenerary",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return SizedBox();
                  },
                ),
                SizedBox(height: AppTheme.defaultMargin * 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

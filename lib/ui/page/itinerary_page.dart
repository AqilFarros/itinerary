part of 'page.dart';

class ItineraryPage extends StatefulWidget {
  const ItineraryPage({
    super.key,
    required this.id,
    required this.place,
    required this.type,
    required this.from,
    required this.to,
    required this.description,
  });

  final String id;
  final String place;
  final String type;
  final Timestamp from;
  final Timestamp to;
  final String description;

  @override
  State<ItineraryPage> createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  final itinerary = ItineraryService();
  String? type;
  String? place;
  Timestamp? from;
  Timestamp? to;
  String? description;

  void _deleteDialog(String id) {
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
              onPressed: () async {
                await itinerary.deleteItinerary(id);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
          title: Text(
            "Are you sure want to delete this itinerary?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }

  void _editDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () async {
                final updatedDate =
                    await Navigator.pushNamed<Map<String, dynamic>>(
                      context,
                      '/edit-itinerary',
                      arguments: {
                        'id': id,
                        'place': place ?? widget.place,
                        'type': type ?? widget.type,
                        'from': from ?? widget.from,
                        'to': to ?? widget.to,
                        'description': description ?? widget.description,
                      },
                    );

                if (updatedDate != null) {
                  setState(() {
                    place = updatedDate['place'];
                    type = updatedDate['type'];
                    from = updatedDate['from'];
                    to = updatedDate['to'];
                    description = updatedDate['description'];
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Theme.of(context).hintColor, width: 1),
              ),
              child: Text(
                "Edit",
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteDialog(id);
              },
              child: Text(
                "Delete",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
          title: Text(
            "Edit or delete itinerary",
            style: Theme.of(context).textTheme.titleLarge,
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
                            _editDialog(widget.id);
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
                      place ?? widget.place,
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
                      Helper.formatDate((from ?? widget.from).toDate()),
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
                          type ?? widget.type,
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
                          "${Helper.dayDifferenceFromTimestamp(from ?? widget.from, to ?? widget.to)} Days trip",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  Hero(
                    tag: widget.id,
                    child: Container(
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
                  ),
                  SizedBox(height: AppTheme.defaultMargin * 2),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultMargin,
                    ),
                    child: Text(
                      "Itinerary to ${place ?? widget.place}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultMargin),
                  StreamBuilder(
                    stream: itinerary.getAgenda(widget.id),
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
                        List upcoming = snapshot.data!.docs.where((element) {
                          final date = element['date'].toDate();
                          final now = DateTime.now();

                          final dateOnly = DateTime(
                            date.year,
                            date.month,
                            date.day,
                          );
                          final todayOnly = DateTime(
                            now.year,
                            now.month,
                            now.day,
                          );

                          return dateOnly.isAtSameMomentAs(todayOnly) ||
                              dateOnly.isAfter(todayOnly);
                        }).toList();

                        List expired = snapshot.data!.docs.where((element) {
                          final date = element['date'].toDate();
                          final now = DateTime.now();

                          final dateOnly = DateTime(
                            date.year,
                            date.month,
                            date.day,
                          );
                          final todayOnly = DateTime(
                            now.year,
                            now.month,
                            now.day,
                          );

                          return dateOnly.isBefore(todayOnly);
                        }).toList();
                        return Column(
                          children: [
                            upcoming.isNotEmpty
                                ? Column(
                                    children: [
                                      Text(
                                        "Upcoming",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      SizedBox(height: AppTheme.defaultMargin),
                                      SizedBox(
                                        height: 250,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: upcoming.length,
                                          itemBuilder: (context, index) {
                                            if (index == 0) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  left: AppTheme.defaultMargin,
                                                ),
                                                child: ActivityCard(
                                                  id: upcoming[index].id,
                                                  itineraryId: widget.id,
                                                  name: upcoming[index]['name'],
                                                  type: upcoming[index]['type'],
                                                  location:
                                                      upcoming[index]['place'],
                                                  date: upcoming[index]['date'],
                                                  description:
                                                      upcoming[index]['description'],
                                                  fromDate: from ?? widget.from,
                                                  toDate: to ?? widget.to,
                                                ),
                                              );
                                            } else {
                                              return ActivityCard(
                                                id: upcoming[index].id,
                                                itineraryId: widget.id,
                                                name: upcoming[index]['name'],
                                                type: upcoming[index]['type'],
                                                location:
                                                    upcoming[index]['place'],
                                                date: upcoming[index]['date'],
                                                description:
                                                    upcoming[index]['description'],
                                                fromDate: from ?? widget.from,
                                                toDate: to ?? widget.to,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: AppTheme.defaultMargin),
                                    ],
                                  )
                                : SizedBox(),
                            expired.isNotEmpty
                                ? Column(
                                    children: [
                                      Text(
                                        "Expired",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      SizedBox(height: AppTheme.defaultMargin),
                                      SizedBox(
                                        height: 250,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: expired.length,
                                          itemBuilder: (context, index) {
                                            if (index == 0) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  left: AppTheme.defaultMargin,
                                                ),
                                                child: ActivityCard(
                                                  id: upcoming[index].id,
                                                  itineraryId: widget.id,
                                                  name: expired[index]['name'],
                                                  type: expired[index]['type'],
                                                  location:
                                                      expired[index]['place'],
                                                  date: expired[index]['date'],
                                                  description:
                                                      expired[index]['description'],
                                                  fromDate: from ?? widget.from,
                                                  toDate: to ?? widget.to,
                                                ),
                                              );
                                            } else {
                                              return ActivityCard(
                                                id: upcoming[index].id,
                                                itineraryId: widget.id,
                                                name: expired[index]['name'],
                                                type: expired[index]['type'],
                                                location:
                                                    expired[index]['place'],
                                                date: expired[index]['date'],
                                                description:
                                                    expired[index]['description'],
                                                fromDate: from ?? widget.from,
                                                toDate: to ?? widget.to,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: AppTheme.defaultMargin),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        );
                      }

                      return SizedBox();
                    },
                  ),
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
                          arguments: {
                            'id': widget.id,
                            'startDate': from ?? widget.from,
                            'endDate': to ?? widget.to,
                          },
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

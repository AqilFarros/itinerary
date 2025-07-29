part of 'widget.dart';

class ItineraryCard extends StatelessWidget {
  const ItineraryCard({super.key, required this.id, required this.from, required this.to, required this.place, required this.type,required this.description,});

  final String id;
  final String place;
  final Timestamp from;
  final Timestamp to;
  final String type;
  final String description;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/itinerary', arguments: {
          "id": id,
          "place": place,
          "type": type,
          "from": from,
          "to": to,
          "description": description,
        });
      },
      child: Hero(
        tag: id,
        child: Container(
          width: 250,
          height: 300,
          margin: EdgeInsets.only(right: AppTheme.defaultMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.defaultMargin * 2),
            image: DecorationImage(
              image: NetworkImage(
                "https://i.pinimg.com/736x/35/aa/53/35aa537a8a5a55658c617821fc287357.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(AppTheme.defaultMargin * 2),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      width: 250,
                      height: 150,
                      padding: EdgeInsets.all(AppTheme.defaultMargin),
                      decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(0.6),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(AppTheme.defaultMargin * 2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            Helper.formatDate(from.toDate()),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: AppTheme.defaultMargin / 2),
                          Wrap(
                            spacing: AppTheme.defaultMargin / 2,
                            runSpacing: AppTheme.defaultMargin / 2,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppTheme.defaultMargin / 2,
                                  horizontal: AppTheme.defaultMargin,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: Theme.of(
                                    context,
                                  ).hintColor.withOpacity(0.5),
                                ),
                                child: Text(
                                  type,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  right: AppTheme.defaultMargin / 2,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: AppTheme.defaultMargin / 2,
                                  horizontal: AppTheme.defaultMargin,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: Theme.of(
                                    context,
                                  ).hintColor.withOpacity(0.5),
                                ),
                                child: Text(
                                  "${Helper.dayDifferenceFromTimestamp(from, to)} Days trip",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}

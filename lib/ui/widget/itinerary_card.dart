part of 'widget.dart';

class ItineraryCard extends StatelessWidget {
  const ItineraryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/itinerary');
      },
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
                          "Batam",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "12 December 2025",
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
                                color: Theme.of(context).hintColor.withOpacity(0.5),
                              ),
                              child: Text(
                                "Family",
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
                                color: Theme.of(context).hintColor.withOpacity(0.5),
                              ),
                              child: Text(
                                "10 Days trip",
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
    );
  }
}

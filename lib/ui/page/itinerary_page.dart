part of 'page.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

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
                        Container(
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
                        Navigator.pushNamed(context, '/add-agenda');
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

part of 'page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultMargin,
                  ),
                  child: Text(
                    "👋 Hello Aqil Farros",
                    style: Theme.of(context).textTheme.titleLarge,
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
                GestureDetector(
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
                    items: imageSliders,
                  ),
                ),
                SizedBox(height: AppTheme.defaultMargin * 2),
                TitleWidget(text: "My Upcoming Event"),
                SizedBox(height: AppTheme.defaultMargin),
                EventCard(),
                EventCard(),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultMargin,
                  ),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "See more",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.defaultMargin),
                TitleWidget(text: "My Dream Itinerary"),
                SizedBox(height: AppTheme.defaultMargin),
                SizedBox(
                  height: 300,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: AppTheme.defaultMargin),
                      ItineraryCard(),
                      ItineraryCard(),
                      ItineraryCard(),
                    ],
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
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                  ),
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

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];

final List<Widget> imageSliders = imgList
    .map((item) => CarouselRoutine())
    .toList();

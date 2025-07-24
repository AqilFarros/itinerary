part of 'widget.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultMargin),
      child: Container(
        margin: EdgeInsets.only(bottom: AppTheme.defaultMargin / 2),
        padding: EdgeInsets.all(AppTheme.defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.defaultMargin * 2),
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            width: 3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppTheme.defaultMargin / 2,
                    horizontal: AppTheme.defaultMargin,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  child: Text(
                    "Flight",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.defaultMargin / 2),
            Text(
              "Traveling to Japan",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "Starting my journey to Batam island with my collegue friend.",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: AppTheme.defaultMargin),
            Wrap(
              spacing: AppTheme.defaultMargin / 2,
              runSpacing: AppTheme.defaultMargin / 2,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Airport",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "25 December 2025",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

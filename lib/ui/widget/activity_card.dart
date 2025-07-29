part of 'widget.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    super.key,
    required this.id,
    required this.itineraryId,
    required this.name,
    required this.type,
    required this.location,
    required this.date,
    required this.description,
    required this.fromDate,
    required this.toDate,
  });

  final String id;
  final String itineraryId;
  final String name;
  final String type;
  final String location;
  final Timestamp date;
  final String description;
  final Timestamp fromDate;
  final Timestamp toDate;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  final agenda = AgendaService();

  void _deleteDialog() {
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
                await agenda.deleteAgenda(
                  agendaId: widget.id,
                  itineraryId: widget.itineraryId,
                );
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
            "Are you sure want to delete this agenda?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }

  void _agendaDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/edit-agenda',
                  arguments: {
                    'itineraryId': widget.itineraryId,
                    'agendaId': widget.id,
                    'name': widget.name,
                    'type': widget.type,
                    'location': widget.location,
                    'date': widget.date,
                    'description': widget.description,
                    'fromDate': widget.fromDate,
                    'toDate': widget.toDate,
                  },
                );
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
                _deleteDialog();
              },
              child: Text(
                "Delete",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
          content: SingleChildScrollView(
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
                        widget.type,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.defaultMargin / 2),
                Text(
                  widget.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: AppTheme.defaultMargin / 2),
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
                          widget.location,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).hintColor),
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
                          Helper.formatDate(widget.date.toDate()),
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          title: Text(
            widget.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _agendaDialog();
      },
      child: Container(
        width: 250,
        height: 250,
        margin: EdgeInsets.only(right: AppTheme.defaultMargin),
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
                    widget.type,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.defaultMargin / 2),
            Text(
              widget.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              widget.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Spacer(),
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
                      widget.location,
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
                      Helper.formatDate(widget.date.toDate()),
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

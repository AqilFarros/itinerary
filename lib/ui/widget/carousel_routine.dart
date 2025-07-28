part of 'widget.dart';

class CarouselRoutine extends StatelessWidget {
  const CarouselRoutine({super.key, required this.name, required this.type, required this.start, required this.end});

  final String name;
  final String type;
  final int start;
  final int end;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(AppTheme.defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color.fromARGB(255, 255, 250, 250),
            Colors.white,
            const Color.fromARGB(255, 255, 244, 244),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.bodyLarge),
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 20,
                    color: Theme.of(context).hintColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${Helper.minuteToHour(start)} - ${Helper.minuteToHour(end)}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            'asset/icon/$type.png',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

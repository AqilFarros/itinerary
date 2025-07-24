part of 'widget.dart';

class CarouselRoutine extends StatelessWidget {
  const CarouselRoutine({super.key});

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
              Text("Work out", style: Theme.of(context).textTheme.bodyLarge),
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 20,
                    color: Theme.of(context).hintColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "05:00 - 12.00",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            'asset/icon/sport.png',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

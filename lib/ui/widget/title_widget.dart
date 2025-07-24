part of 'widget.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultMargin),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: color ?? Colors.black),
          ),
        ],
      ),
    );
  }
}

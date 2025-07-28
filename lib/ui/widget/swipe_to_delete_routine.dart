part of 'widget.dart';

class SwipeToDeleteRoutine extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;

  const SwipeToDeleteRoutine({
    super.key,
    required this.child,
    required this.onDismissed,
  });

  @override
  State<SwipeToDeleteRoutine> createState() => _SwipeToDeleteRoutineState();
}

class _SwipeToDeleteRoutineState extends State<SwipeToDeleteRoutine>
    with SingleTickerProviderStateMixin {
  double _dragExtent = 0.0;
  late AnimationController _fadeController;
  bool _isDismissing = false;

  static const double threshold = 0.3; // swipe 30% layar untuk trigger

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    // Geser ke kanan saja (delta negatif)
    // if (details.delta.dx < 0) {
    //   setState(() {
    //     _dragExtent += details.delta.dx;
    //   });
    // }

    setState(() {
      // Geser hanya sampai ke 0 (tidak ke kanan melebihi awal)
      _dragExtent = (_dragExtent + details.delta.dx).clamp(
        0.0,
        MediaQuery.of(context).size.width,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) async {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_dragExtent.abs() > screenWidth * threshold) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Routine?'),
          content: const Text(
            'Are you sure want to delete this routine?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirm == true) {
        setState(() {
          _isDismissing = true;
        });
        await _fadeController.forward();
        widget.onDismissed();
      } else {
        setState(() {
          _dragExtent = 0;
        });
      }
    } else {
      setState(() {
        _dragExtent = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dragOffset = _dragExtent.clamp(0.0, screenWidth);

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: Stack(
        children: [
          // Background merah
          Positioned.fill(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.defaultMargin),
                color: Colors.red.withOpacity(
                (_dragExtent.abs() / screenWidth).clamp(0.0, 1.0),
              ),
              ),
              child: const Text(
                "Swipe to delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Child dengan efek geser dan fade out
          AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Opacity(
                opacity: 1.0 - _fadeController.value,
                child: Transform.translate(
                  offset: Offset(dragOffset, 0),
                  child: child,
                ),
              );
            },
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

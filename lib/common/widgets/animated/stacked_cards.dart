import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/clickable_wrapper.dart';
import 'package:flutter/material.dart';

class CardItem {
  final Widget title;
  final Widget body;
  final String? buttonTitle;
  final ButtonStyle? buttonStyle;
  final GestureTapCallback? onTap;

  /// Provide **either** a gradient **or** a solid colour.
  final List<Color>? gradientColors;
  final Color? solidColor;
  final bool? isButton;
  final BorderRadius? borderRadius;

  CardItem({
    required this.title,
    required this.body,
    this.buttonTitle,
    this.buttonStyle,
    this.gradientColors,
    this.solidColor,
    this.isButton,
    this.borderRadius,
    this.onTap,
  });
}

class StackedCards extends StatefulWidget {
  final List<CardItem> items;

  // layout knobs
  final double collapsedHeight;
  final double expandedHeight;
  final double overlap;
  final double cardBorderRadius;

  const StackedCards({
    super.key,
    required this.items,
    this.collapsedHeight = 100,
    this.expandedHeight = 240,
    this.overlap = 70,
    this.cardBorderRadius = 16,
  }) : assert(expandedHeight > collapsedHeight, 'expandedHeight must be > collapsedHeight');

  @override
  State<StackedCards> createState() => _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards> {
  double get _collapsed => widget.collapsedHeight;
  double get _expanded => widget.expandedHeight;
  double get _gap => widget.overlap;

  late List<CardItem> _items;
  late CardItem _selected;

  @override
  void initState() {
    super.initState();
    _items = List.of(widget.items);
    _selected = _items.last;
  }

  @override
  Widget build(BuildContext context) {
    final totalH = _expanded + (_items.length - 1) * _gap;

    return SizedBox(
      height: totalH,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: _items.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          final top = idx * _gap;
          final cardH = item == _selected ? _expanded : _collapsed;

          /*──────── background ────────*/
          final fallback = Colors.primaries[idx % Colors.primaries.length].shade200;

          final bg = BoxDecoration(
            gradient: item.gradientColors != null
                ? LinearGradient(colors: item.gradientColors!, begin: Alignment.topLeft, end: Alignment.bottomRight)
                : null,
            color: item.gradientColors == null ? (item.solidColor ?? fallback) : null,
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
          );

          return AnimatedPositioned(
            key: ValueKey(item.title),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: top,
            left: 20,
            right: 20,
            height: cardH,
            child: ClipRRect(
              borderRadius: item.borderRadius ?? BorderRadius.circular(widget.cardBorderRadius),
              child: Container(
                decoration: bg,

                height: cardH,
                clipBehavior: Clip.hardEdge,
                child: ClickableWrapper(
                  borderRadius: item.borderRadius ?? BorderRadius.circular(widget.cardBorderRadius),
                  padding: EdgeInsets.zero,
                  onTap: () => _bringToFront(item),
                  child: item == _selected ? _buildExpandedContent(item, cardH) : _buildCollapsedHeader(item),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /*───────── helpers ─────────*/

  Widget _buildCollapsedHeader(CardItem item) => Padding(
    padding: const EdgeInsets.all(AppDimens.spacingLg),
    // padding: const EdgeInsets.only(left: AppDimens.spacingLg, right: 30, top: 20, bottom: AppDimens.spacingSm),
    child: DefaultTextStyle.merge(
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      child: item.title,
    ),
  );

  Widget _buildExpandedContent(CardItem item, double height) => Padding(
    padding: const EdgeInsets.all(AppDimens.spacingLg),
    child: OverflowBox(
      maxHeight: height - 36, // account for padding
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            child: item.title,
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Expanded(
            child: DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              child: item.body,
            ),
          ),
          // const SizedBox(height: 60),
        ],
      ),
    ),
  );

  // Widget _buildExpandedContent2(CardItem item) => Stack(
  //   children: [
  //     Positioned(
  //       child: Padding(
  //         padding: const EdgeInsets.all(18),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             DefaultTextStyle.merge(
  //               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
  //               child: item.title,
  //             ),
  //             const SizedBox(height: 12),
  //             Expanded(
  //               child: DefaultTextStyle.merge(
  //                 style: const TextStyle(fontSize: 16, color: Colors.black54),
  //                 child: Container(color: Colors.blue, child: item.body),
  //               ),
  //             ),
  //             const SizedBox(height: 60),
  //           ],
  //         ),
  //       ),
  //     ),
  //     if (item.isButton == true)
  //       Positioned(
  //         right: 16,
  //         bottom: 16,
  //         child: ElevatedButton(
  //           style:
  //               item.buttonStyle ??
  //               ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.white,
  //                 foregroundColor: Colors.black87,
  //                 textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 elevation: 2,
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //               ),
  //           onPressed: item.onTap,
  //           child: Text(item.buttonTitle ?? 'Learn More'),
  //         ),
  //       ),
  //   ],
  // );

  void _bringToFront(CardItem item) {
    setState(() {
      _items.remove(item);
      _items.add(item);
      _selected = item;
    });
  }
}

import 'package:flutter/material.dart';

class HingedWidget extends StatefulWidget {
  final Widget header;
  final Widget? alterHeader;
  final Widget content;
  final int contentLength;
  final double? width;
  final double? basicHeigth;

  const HingedWidget({
    super.key,
    this.alterHeader,
    required this.header,
    required this.content,
    required this.contentLength,
    this.width,
    this.basicHeigth,
  });

  @override
  State<HingedWidget> createState() => _LargeHingedState();
}

class _LargeHingedState extends State<HingedWidget> {
  bool _isOpen = false;
  bool _openContent = false;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        // curve: Curves.linear,
        height: _isOpen ? ((widget.basicHeigth ?? 200) + (widget.contentLength * 22)) : 60,
        onEnd: () => setState(() {
          if (_isOpen) {
            if (!_openContent) _openContent = true;
          }
        }),
        child: GestureDetector(
          onTap: () => setState(() {
            if (_isOpen) _openContent = false;
            _isOpen = !_isOpen;
          }),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Card(
              // borderRadius: BorderRadius.circular(6),
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: widget.alterHeader != null
                              ? _isOpen
                                  ? widget.alterHeader
                                  : widget.header
                              : widget.header,
                        ),
                        Icon(
                          _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 40,
                        ),
                      ],
                    ),
                    _openContent ? SizedBox(child: widget.content) : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

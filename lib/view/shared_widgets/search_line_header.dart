import 'package:flutter/material.dart';

import '../../constants/themes/app_color.dart';

class SearchLineHeader extends StatefulWidget {
  final String title;
  final bool searchbarEnabled;

  const SearchLineHeader({
    super.key,
    this.searchbarEnabled = false,
    required this.title,
  });

  @override
  State<SearchLineHeader> createState() => _SearchLineHeaderState();
}

class _SearchLineHeaderState extends State<SearchLineHeader> {
  final TextEditingController _searchController = TextEditingController();
  late final String _title;
  late final bool _isEnabled;
  @override
  void initState() {
    _title = widget.title;
    _isEnabled = widget.searchbarEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constrains) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: SizedBox(
            height: 50,
            width: constrains.maxWidth,
            child: _isEnabled
                ? Row(
                    children: [
                      SizedBox(
                        width: (constrains.maxWidth / 10) * 3.5,
                        child: Text(
                          _title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.kPrimaryButtonColor,
                              fontSize: 22),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: constrains.maxWidth / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12), color: Colors.white),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                _searchController.text = value;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                suffixIcon: const Icon(Icons.search),
                                hintText: 'Suche...',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: constrains.maxWidth - 100,
                    child: Center(
                      child: Text(
                        _title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.kPrimaryButtonColor,
                            fontSize: 22),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
          ),
        ),
      );
}

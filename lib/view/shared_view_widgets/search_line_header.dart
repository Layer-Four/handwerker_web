import 'package:flutter/material.dart';

import '../../constants/themes/app_color.dart';

class SearchLineHeader extends StatefulWidget {
  final String _currentViewTitle;
  final bool searchbarEnabled;

  const SearchLineHeader({
    super.key,
    required String title,
    this.searchbarEnabled = true,
  }) : _currentViewTitle = title;

  @override
  State<SearchLineHeader> createState() => _SearchLineHeaderState();
}

class _SearchLineHeaderState extends State<SearchLineHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constrains) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            height: 50,
            width: constrains.maxWidth,
            child: Row(
              children: [
                SizedBox(
                  width: widget.searchbarEnabled
                      ? (constrains.maxWidth / 10) * 3.5
                      : constrains.maxWidth - 100,
                  child: Text(
                    widget._currentViewTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.kPrimaryButtonColor,
                        fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // TODO: is There a case where Searchbar hidden or unable to activ
                Visibility(
                  visible: widget.searchbarEnabled,
                  child: Padding(
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                )
              ],
            ),
          ),
        ),
      );
}

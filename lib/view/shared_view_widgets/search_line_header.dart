import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchLineHeader extends StatefulWidget {
  final String _currentViewTitle;
  final bool searchbarEnabled;

  const SearchLineHeader({super.key, required String title, this.searchbarEnabled = true}) : _currentViewTitle = title;

  @override
  State<SearchLineHeader> createState() => _SearchLineHeaderState();
}

class _SearchLineHeaderState extends State<SearchLineHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                widget._currentViewTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600, color: Colors.orange, fontSize: 22),
              ),
              Visibility(
                visible: widget.searchbarEnabled,
                child: Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
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
      );
}

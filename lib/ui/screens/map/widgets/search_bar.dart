import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class MapSearchBar extends StatefulWidget {
  const MapSearchBar({
    super.key,
    required this.optionsBuilder,
    required this.onSelected,
  });

  final Iterable<Station> Function(String query) optionsBuilder;
  final ValueChanged<Station> onSelected;

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_handleTextChanged);
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _focusNode.removeListener(_handleFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = widget.optionsBuilder(_controller.text).toList(growable: false);
    final showSuggestions = _showSuggestions && suggestions.isNotEmpty;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search station',
                  hintStyle: AppTextStyles.label.copyWith(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.iconNormal,
                  ),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            _focusNode.requestFocus();
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.iconLight,
                          ),
                        ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            if (showSuggestions) ...[
              const SizedBox(height: 10),
              Material(
                color: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                    maxHeight: 280,
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      color: AppColors.greyLight,
                    ),
                    itemBuilder: (context, index) {
                      final station = suggestions[index];
                      return ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: AppColors.iconNormal,
                        ),
                        title: Text(
                          station.name,
                          style: AppTextStyles.label.copyWith(fontSize: 14),
                        ),
                        subtitle: Text(
                          station.location.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                        onTap: () => _selectStation(station),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleTextChanged() {
    if (mounted) {
      setState(() {
        _showSuggestions = _controller.text.trim().isNotEmpty;
      });
    }
  }

  void _handleFocusChanged() {
    if (!mounted) {
      return;
    }

    if (_focusNode.hasFocus) {
      setState(() {
        _showSuggestions = _controller.text.trim().isNotEmpty;
      });
      return;
    }

    Future<void>.delayed(const Duration(milliseconds: 120), () {
      if (!mounted || _focusNode.hasFocus) {
        return;
      }

      setState(() {
        _showSuggestions = false;
      });
    });
  }

  void _selectStation(Station station) {
    _controller.text = station.name;
    _controller.selection = TextSelection.collapsed(offset: station.name.length);
    setState(() {
      _showSuggestions = false;
    });
    _focusNode.unfocus();
    widget.onSelected(station);
  }
}

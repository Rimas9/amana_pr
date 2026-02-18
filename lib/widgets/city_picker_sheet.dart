import 'package:flutter/material.dart';

class CityPickerSheet extends StatefulWidget {
  final List<String> cities;
  final String selectedCity;

  const CityPickerSheet({
    super.key,
    required this.cities,
    required this.selectedCity,
  });

  @override
  State<CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<CityPickerSheet> {
  late final TextEditingController _controller;
  late List<String> _filtered;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _filtered = List<String>.from(widget.cities);
    _controller.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _controller.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = List<String>.from(widget.cities);
      } else {
        _filtered =
            widget.cities.where((c) => c.toLowerCase().contains(q)).toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearch);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.62,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          builder: (context, t, child) {
            return Opacity(
              opacity: t,
              child: Transform.translate(
                offset: Offset(0, (1 - t) * 18),
                child: child,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0A3F8E).withOpacity(0.92),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(26)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 4,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Choose City',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Search…',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.6)),
                      prefixIcon: Icon(Icons.search,
                          color: Colors.white.withOpacity(0.75)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: Colors.white.withOpacity(0.08),
                    ),
                    itemBuilder: (context, i) {
                      final city = _filtered[i];
                      final isSelected = city == widget.selectedCity;

                      return ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: isSelected
                              ? Colors.yellow
                              : Colors.white.withOpacity(0.85),
                        ),
                        title: Text(
                          city,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w600,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle,
                                color: Colors.yellow)
                            : null,
                        onTap: () => Navigator.pop(context, city),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

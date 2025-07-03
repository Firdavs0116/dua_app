// zikr_list_page.dart
import 'package:flutter/material.dart';
import 'package:my_dua_app/features/zikr/presentation/pages/zikr_details_page.dart';

class ZikrListPage extends StatelessWidget {
  const ZikrListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final zikrs = [
      {
        'arabic': 'سُبْحَانَ اللهِ',
        'transliteration': 'Subḥānallāh',
        'translation': 'Glory be to Allah',
        'repeat': 33,
      },
      {
        'arabic': 'الحَمْدُ لِلهِ',
        'transliteration': 'Al-ḥamdu lillāh',
        'translation': 'Praise be to Allah',
        'repeat': 33,
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Zikrs"),
        actions: [
          const Icon(Icons.language),
          const SizedBox(width: 8),
          const Icon(Icons.brightness_6),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Remembrance of Allah to purify the heart.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a zikr...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildChip('All'),
                  _buildChip('Essential'),
                  _buildChip('Morning & Evening'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: zikrs.length,
                itemBuilder: (context, index) {
                  final zikr = zikrs[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'arabic',
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('transliteration'),
                          const SizedBox(height: 5),
                          Text('translation'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Repeat: ${zikr['repeat']}",
                                  style: const TextStyle(color: Colors.red)),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ZikrDetailPage(zikr: zikr),
                                    ),
                                  );
                                },
                                child: const Text("Start"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: false,
        onSelected: (_) {},
      ),
    );
  }
}

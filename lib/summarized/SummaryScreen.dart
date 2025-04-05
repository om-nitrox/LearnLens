import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SummaryScreen extends StatefulWidget {
  final String text;
  const SummaryScreen({Key? key, required this.text}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String? _summary;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateSummary();
  }

  Future<void> _generateSummary() async {
    if (widget.text.trim().isEmpty) {
      setState(() {
        _summary = "⚠️ No text provided for summary.";
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const String apiKey = "AIzaSyB9-NS-zzzN02_L2Ctxlpju93tjGRX1VT0";
    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);

    final prompt = """
Summarize the following text using this format:

- Group related points under clear and descriptive HEADINGS.
- HEADINGS should be in ALL CAPS and written on a new line.
- Subpoints should come under each heading with dashes (-).
- Add a blank line between headings and between subpoints of different headings.
- DO NOT add any introduction or conclusion.

Example:

TITLE 1
- Point 1
- Point 2

TITLE 2
- Point A
- Point B

Now summarize this:

"${widget.text}"
""";

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text != null) {
        final raw = response.text!.trim();
        print("✅ Gemini summary response:\n$raw");

        setState(() {
          _summary = raw;
        });
      } else {
        _summary = "❌ Failed to generate summary.";
      }
    } catch (e) {
      print("❌ Error generating summary: $e");
      setState(() {
        _summary = "⚠️ Error: Unable to generate summary.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Widget> _buildBulletPoints(String summaryText) {
    final lines = summaryText.split('\n');
    List<Widget> widgets = [];

    for (var line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(SizedBox(height: 12));
      } else if (RegExp(r'^[A-Z0-9\s]+$').hasMatch(line.trim())) {
        // Headline (all caps)
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            line.trim(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      } else if (RegExp(r'^[-•*→]').hasMatch(line.trim())) {
        // Bullet point
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("• ", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Text(
                  line.replaceFirst(RegExp(r'^[-•*→]\s*'), ''),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
      } else {
        // Fallback (normal line)
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            line,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Summary")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _summary == null
              ? Center(child: Text("No summary generated."))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildBulletPoints(_summary!),
                    ),
                  ),
                ),
    );
  }
}

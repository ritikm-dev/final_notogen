import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardScreen extends StatefulWidget {
  final String useremail ;
  final String user_name ;
  const DashboardScreen({super.key, required this.useremail,required this.user_name});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _record = AudioRecorder();
  bool _isRecording = false;
  bool _showSubmit = false;
  String? _recordedFilePath;

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      await _record.start(const RecordConfig(), path: 'audio_${DateTime.now()}.m4a');
      setState(() {
        _isRecording = true;
        _showSubmit = false;
      });
    }
  }

  Future<void> _stopRecording() async {
    final path = await _record.stop();
    setState(() {
      _isRecording = false;
      _showSubmit = true;
      _recordedFilePath = path;
    });
  }

  void _submitRecording() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Audio submitted: $_recordedFilePath')),
    );
  }

  @override
  void dispose() {
    _record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🎙️ Mic Button
            ElevatedButton.icon(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              label: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.red : Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 20),

            // 🧱 Two Boxes (like Google Classroom)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildClassBox('Project 1', Colors.orangeAccent),
                  _buildClassBox('Project 2', Colors.greenAccent),
                ],
              ),
            ),

            // ✅ Submit Button (shows after recording)
            if (_showSubmit)
              ElevatedButton(
                onPressed: _submitRecording,
                child: const Text('Submit'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassBox(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

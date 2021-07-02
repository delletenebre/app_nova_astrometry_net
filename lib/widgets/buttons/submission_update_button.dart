import 'package:astrometry_net/database/submission.dart';
import 'package:flutter/material.dart';

class SubmissionUpdateButton extends StatefulWidget {
  final Submission submission;
  
  const SubmissionUpdateButton({
    Key? key,
    required this.submission,
  }) : super(key: key);

  @override
  _SubmissionUpdateButtonState createState() => _SubmissionUpdateButtonState();
}

class _SubmissionUpdateButtonState extends State<SubmissionUpdateButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return CircularProgressIndicator();
    }

    return TextButton(
      onPressed: requestStatus,
      child: Text('Update'),
    );
  }

  Future<void> requestStatus() async {
    setState(() {
      _loading = true;
    });

    await widget.submission.updateStatus();
    
    setState(() {
      _loading = false;
    });
  }
}
import 'package:astrometry_net/database/job.dart';
import 'package:flutter/material.dart';

class JobUpdateButton extends StatefulWidget {
  final Job job;
  // final VoidCallback onUpdate;
  
  const JobUpdateButton({
    Key? key,
    required this.job,
    // required this.onUpdate,
  }) : super(key: key);

  @override
  _JobUpdateButtonState createState() => _JobUpdateButtonState();
}

class _JobUpdateButtonState extends State<JobUpdateButton> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return CircularProgressIndicator();
    }

    return TextButton(
      onPressed: requestStatus,
      // tooltip: 'Request job status from server',
      child: Text('Update')
    );
  }

  Future<void> requestStatus() async {
    setState(() {
      _loading = true;
    });

    await widget.job.updateStatus();
    // widget.onUpdate();
    
    setState(() {
      _loading = false;
    });
  }
}
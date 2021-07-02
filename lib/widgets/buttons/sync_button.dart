import 'package:astrometry_net/api/api.dart';
import 'package:astrometry_net/resources/storage.dart';
import 'package:flutter/material.dart';

class SyncButton extends StatefulWidget {
  const SyncButton({ Key? key }) : super(key: key);

  @override
  _SyncButtonState createState() => _SyncButtonState();
}

class _SyncButtonState extends State<SyncButton> with TickerProviderStateMixin {
  bool _loading = false;

  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();

    rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Storage.getApiKey().isEmpty) {
      return SizedBox();
    }

    return IconButton(
      splashRadius: 24.0,
      onPressed: () async {
        if (_loading) {
          
        } else {
          syncJobs();
        }
      },
      tooltip: 'Sync data with server',
      icon: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
        child: const Icon(Icons.sync)
      ),
    );
  }

  Future<void> syncJobs() async {
    setState(() {
      _loading = true;
    });
    rotationController.repeat();

    final response = await Storage.syncJobsWithServer();
    if (!response.success) {
      if (response.statusCode == ApiResponse.API_ERROR_CODE) {
        final snackBar = SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(response.data['errormessage']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    
    rotationController.stop();
    rotationController.forward().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }
}
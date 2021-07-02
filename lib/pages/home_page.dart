import 'package:astrometry_net/api/api.dart';
import 'package:astrometry_net/database/job.dart';
import 'package:astrometry_net/database/submission.dart';
import 'package:astrometry_net/resources/storage.dart';
import 'package:astrometry_net/widgets/buttons/expandable_fab.dart';
import 'package:astrometry_net/widgets/buttons/sync_button.dart';
import 'package:astrometry_net/widgets/job_list_item.dart';
import 'package:astrometry_net/widgets/multi_value_listenable_builder.dart';
import 'package:astrometry_net/widgets/page_layout.dart';
import 'package:astrometry_net/widgets/submission_list_item.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Astrometry.net',
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _uploadImage(context),
            icon: const Icon(Icons.insert_photo),
            tooltip: 'Upload image'
          ),
          ActionButton(
            onPressed: () => _uploadImagByUrl(context),
            icon: const Icon(Icons.link),
            tooltip: 'Upload by URL'
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: SyncButton(),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: IconButton(
            splashRadius: 24.0,
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
          ),
        ),
      ],

      child: MultiValueListenableBuilder(
        Storage.submissionsBox.listenable(),
        Storage.jobsBox.listenable(),

        builder: (context, Box<Submission> submissionsBox, Box<Job> jobsBox, widget) {
          int itemsLength = 0;

          final submissions = submissionsBox.values.where((submission) {
            return submission.jobs.isEmpty;
          });
          final hasSubmissions = submissions.isNotEmpty;
          if (hasSubmissions) {
            itemsLength += submissions.length + 1;
          }

          final jobs = jobsBox.values.toList();
          final hasJobs = jobs.isNotEmpty;
          if (hasJobs) {
            jobs.sort((a, b) => b.id.compareTo(a.id));
            itemsLength += jobs.length + 1;
          }

          return RefreshIndicator(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: itemsLength,
              itemBuilder: (BuildContext context, int index) {

                if (hasSubmissions && index == 0) {

                  // render Submissions title
                  return ListTitle('Submissions');

                } else if (hasSubmissions && index <= submissions.length) {

                  // render submission item
                  final submissionIndex = index - 1;
                  final submission = submissions.elementAt(submissionIndex);
                  return SubmissionListItem(submission);

                } else if ((!hasSubmissions && index == 0) ||
                           (hasSubmissions && index == (submissions.length + 1))) {

                  // render Jobs title
                  return ListTitle('Jobs');

                } else {

                  // render jobs
                  int jobIndex = index - 1;
                  if (hasSubmissions) {
                    jobIndex = index - 1 - (submissions.length + 1);
                  }
                  final job = jobs.elementAt(jobIndex);
                  return JobListItem(job);

                }
              }
            ),
            onRefresh: () async {
              await Storage.syncJobsWithServer();
              await updateJobsStatuses(jobs);
            },
          );
        },
      ),
    );
  }

  Future<void> updateJobsStatuses(Iterable<Job> jobs) async {
    final notSyncedJobs = jobs.where((job) => !job.finished);

    for (final job in notSyncedJobs) {
      await job.updateStatus();
    }
  }

  void _uploadImage(BuildContext context) async {
    if (Storage.getApiKey().isEmpty) {
      _showSnackbar(context,
        message: 'Please, enter API key in settings',
        action: SnackBarAction(
          label: 'Go to settings',
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
      );

      return;
    }

    try {
      final file = await FilePickerCross.importFromStorage(
        type: FileTypeCross.custom,
        fileExtension: 'jpg,jpeg,png,gif,fits' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
      );

      if (file.path != null) {
        final response = await Api.uploadFile(file.path!, file.fileName!);
        if (response.success) {
          _addSubmission(context, response);
        } else {
          if (response.statusCode == ApiResponse.API_ERROR_CODE) {
            _showSnackbar(context,
              message: response.data['errormessage'],
            );
          }
        }
      }
      
    } on FileSelectionCanceledError catch (exception)  {
      final reason = exception.platformError.toString();
      print(reason);
    }
  }

  void _uploadImagByUrl(BuildContext context) async {
    if (Storage.getApiKey().isEmpty) {
      _showSnackbar(context,
        message: 'Please, enter API key in settings',
        action: SnackBarAction(
          label: 'Go to settings',
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
      );

      return;
    }

    await _displayImageUrlDialog(context, (String url) async {
      final isUrlValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
      if (isUrlValid) {
        final response = await Api.uploadFileByUrl(url);
        if (response.success) {
          _addSubmission(context, response);
        } else {
          if (response.statusCode == ApiResponse.API_ERROR_CODE) {
            _showSnackbar(context,
              color: Theme.of(context).errorColor,
              message: response.data['errormessage'],
            );
          }
        }
      } else {
        _showSnackbar(context,
          message: 'URL is not valid',
          color: Theme.of(context).errorColor,
        );
      }
    });
  }
  
  Future<void> _displayImageUrlDialog(BuildContext context, Function onFinish) async {
    final imageUrlTextFieldController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter image URL'),
          content: TextField(
            controller: imageUrlTextFieldController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(hintText: 'Image URL'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'.toUpperCase()),
              onPressed: () {
                imageUrlTextFieldController.clear();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'.toUpperCase()),
              onPressed: () {
                onFinish(imageUrlTextFieldController.text);
                imageUrlTextFieldController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addSubmission(BuildContext context, ApiResponse response) async {
    final submissionId = response.data['subid'];
    await Storage.createSubmission(submissionId)..updateStatus();
    _showSnackbar(context,
      message: 'Image uploaded successfully. It may take several minutes to process your request. Please be patient',
    );
  }

  void _showSnackbar(
    BuildContext context,
    {
      String message = '',
      Color? color,
      SnackBarAction? action,
    }
  ) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(message),
      action: action
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

@immutable
class ListTitle extends StatelessWidget {
  const ListTitle(this.title, {
    Key? key
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(title.toUpperCase(),
            style: theme.textTheme.caption!.copyWith(
              fontSize: 14.0,
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
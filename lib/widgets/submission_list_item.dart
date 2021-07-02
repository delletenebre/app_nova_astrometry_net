import 'package:astrometry_net/database/submission.dart';
import 'package:astrometry_net/widgets/buttons/submission_update_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubmissionListItem extends StatelessWidget {
  const SubmissionListItem(this.submission, {
    Key? key,
  }) : super(key: key);

  final Submission submission;

  @override
  Widget build(BuildContext context) {
    Widget subtitle = Text('-');
    final dateFormatter = DateFormat.yMMMMd().add_Hms();

    if (submission.processingFinished != null) {
      if (submission.jobs.isEmpty) {
        subtitle = Text('Processing');
      } else {
        subtitle = Text('Complete');
      }
    } else if (submission.processingStarted != null) {
      subtitle = Text('Started at: ' + dateFormatter.format(submission.processingStarted!));
    } else {
      subtitle = Text('Not started yet');
    }

    Widget? leading;

    var titleString = submission.id.toString();

    final title = Text(titleString);
    
    return Card(
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: SubmissionUpdateButton(
          submission: submission,
        ),
        // trailing: Text(_age(_users[index])),
      ),
    );
  }
}
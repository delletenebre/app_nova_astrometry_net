import 'package:astrometry_net/api/api.dart';
import 'package:astrometry_net/database/job.dart';
import 'package:astrometry_net/widgets/buttons/job_update_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobListItem extends StatelessWidget {
  const JobListItem(this.job, {
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    if (job.success) {
      leading = Image.network('${Api.URL}/annotated_display/${job.id}',
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          
          return CircularProgressIndicator();
        },
      );
    }

    Widget? trailing;
    if (!job.finished) {
      trailing = JobUpdateButton(
        job: job,
      );
    }

    VoidCallback? onTap;
    if (job.finished && job.success) {
      onTap = () => Navigator.pushNamed(context, '/job',
        arguments: {
          'job': job,
        }
      );
    }
    
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(job.id.toString()),
        subtitle: Text(job.status + '\n' + DateFormat.yMd().format(job.createdAt)),
        isThreeLine: true,
        trailing: trailing,
      )
    );
  }
}
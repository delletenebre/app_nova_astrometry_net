// import 'package:astrometry_net/api/api.dart';
// import 'package:astrometry_net/database/job.dart';
// import 'package:astrometry_net/database/submission.dart';
// import 'package:astrometry_net/resources/storage.dart';
// import 'package:astrometry_net/widgets/buttons/expandable_fab.dart';
// import 'package:astrometry_net/widgets/buttons/job_update_button.dart';
// import 'package:astrometry_net/widgets/buttons/submission_update_button.dart';
// import 'package:astrometry_net/widgets/buttons/sync_button.dart';
// import 'package:astrometry_net/widgets/page_layout.dart';
// import 'package:file_selector/file_selector.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class SubmissionsPage extends StatelessWidget {
//   const SubmissionsPage({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PageLayout(
//       title: 'Submissions',
//       floatingActionButton: ExpandableFab(
//         distance: 112.0,
//         children: [
//           ActionButton(
//             onPressed: _uploadImage,
//             icon: const Icon(Icons.insert_photo),
//             tooltip: 'Upload image'
//           ),
//           ActionButton(
//             onPressed: () {},
//             icon: const Icon(Icons.link),
//             tooltip: 'Upload by URL'
//           ),
//         ],
//       ),
//       actions: [
//         // Padding(
//         //   padding: EdgeInsets.only(right: 16),
//         //   child: SyncButton(),
//         // ),
//         Padding(
//           padding: EdgeInsets.only(right: 16),
//           child: IconButton(
//             splashRadius: 24.0,
//             onPressed: () => Navigator.pushNamed(context, '/settings'),
//             tooltip: 'Settings',
//             icon: const Icon(Icons.settings),
//           ),
//         ),
//       ],
//       child: ValueListenableBuilder(
//         valueListenable: Storage.submissionsBox.listenable(),
//         builder: (context, Box<Submission> box, widget) {
//           final submissions = box.values.toList().reversed;

//           return RefreshIndicator(
//             child: ListView.builder(
//               padding: EdgeInsets.all(8),
//               itemCount: submissions.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final submission = submissions.elementAt(index);

//                 Widget subtitle = Text('-');
//                 final dateFormatter = DateFormat.yMMMMd().add_Hms();
//                 if (submission.user > 0) {
//                   if (submission.processingFinished != null) {
//                     subtitle = Text('Finished at: ' + dateFormatter.format(submission.processingFinished!));
//                   } else if (submission.processingStarted != null) {
//                     subtitle = Text('Started at: ' + dateFormatter.format(submission.processingStarted!));
//                   } else {
//                     subtitle = Text('Not started yet');
//                   }
//                 }

//                 Widget? leading;

//                 var titleString = submission.id.toString();
//                 // if (submission.jobs.isNotEmpty) {
//                 //   titleString += ' (jobs: ${submission.jobs.length})';
//                 // }

//                 final title = Text(titleString);

//                 late Widget child;
//                 if (submission.jobs.isEmpty) {
//                   child = ListTile(
//                     leading: leading,
//                     title: title,
//                     subtitle: subtitle,
//                     trailing: SubmissionUpdateButton(
//                       submission: submission,
//                     ),
//                     // trailing: Text(_age(_users[index])),
//                   );
//                 } else {
//                   child = ExpansionTile(
//                     leading: leading,
//                     title: title,
//                     subtitle: subtitle,
//                     children: List<Widget>.from(
//                       submission.jobs.asMap().entries.map((entry) {
//                         final index = entry.key;
//                         final number = index + 1;
//                         final job = entry.value;

//                         Widget? trailing;
//                         if (!job.finished) {
//                           trailing = JobUpdateButton(
//                             job: job,
//                             onUpdate: () {
//                               submission.save();
//                             }
//                           );
//                         }

//                         VoidCallback? onTap;
//                         if (job.finished) {
//                           onTap = () => Navigator.pushNamed(
//                             context,
//                             '/job',
//                             arguments: {
//                               'job': job,
//                             }
//                           );
//                         }

//                         return ListTile(
//                           onTap: onTap,
//                           title: Text('$number. Job ${job.id}'),
//                           subtitle: Text(job.status),
//                           trailing: trailing,
//                         );
//                       })
//                     ),
//                   );
//                 }
                
//                 return Card(
//                   child: child
//                 );
//               }
//             ),
//             onRefresh: () async {
//               var items;

//               items = submissions.where((submission) {
//                 return submission.user == 0 ||
//                         submission.processingFinished == null;
//               });
//               for (final submission in items) {
//                 await submission.updateStatus();
//               }

//               // items = submissions.where((submission) => submission.jobs[0].status == null);
//               // for (final submission in items) {
//               //   final response = await Api.getJobInfo(submission.jobs[0].id);
//               // }
//             },
//           );
//         },
//       )

//       // child: ValueListenableBuilder(
//       //   valueListenable: Storage.jobsBox.listenable(),
//       //   builder: (context, Box<Job> box, widget) {
//       //     final jobs = box.values;

//       //     return RefreshIndicator(
//       //       child: ListView.builder(
//       //         padding: EdgeInsets.all(8),
//       //         itemCount: jobs.length,
//       //         itemBuilder: (BuildContext context, int index) {
//       //           final job = jobs.elementAt(index);

//       //           Widget? leading;
//       //           if (job.status == 'success') {
//       //             leading = Image.network('http://nova.astrometry.net/annotated_display/${job.id}',
//       //               loadingBuilder: (context, child, loadingProgress) {
//       //                 if (loadingProgress == null) {
//       //                   return child;
//       //                 }
                      
//       //                 return CircularProgressIndicator();
//       //               },
//       //             );
//       //           }
                
//       //           return Card(
//       //             child: ListTile(
//       //               onTap: () {

//       //               },
//       //               leading: leading,
//       //               title: Text(job.id.toString()),
//       //               subtitle: Text(job.status),
//       //               // trailing: Text(_age(_users[index])),
//       //             )
//       //           );
//       //         }
//       //       ),
//       //       onRefresh: () async {
//       //         // var items;

//       //         // items = submissions.where((submission) => submission.jobs == null);
//       //         // for (final submission in items) {
//       //         //   await submission.updateStatus();
//       //         // }

//       //         // items = submissions.where((submission) => submission.jobs[0].status == null);
//       //         // for (final submission in items) {
//       //         //   final response = await Api.getJobInfo(submission.jobs[0].id);
//       //         // }
//       //       },
//       //     );
//       //   },
//       // )


//       // Center(
//       //   child: Column(
//       //     children: [
//       //       ElevatedButton(
//       //         onPressed: () async {
//       //           await Api.login();
//       //         },
//       //         child: Text('get session'),
//       //       ),
//       //       ElevatedButton(
//       //         onPressed: () async {
//       //           // pushNewScreen(
//       //           //   context,
//       //           //   screen: SettingsPage(),
//       //           // );
//       //           final typeGroup = XTypeGroup(
//       //             label: 'images',
//       //             extensions: ['jpg', 'jpeg', 'png', 'gif', 'fits']
//       //           );
//       //           final file = await openFile(
//       //             acceptedTypeGroups: [typeGroup]
//       //           );
//       //           // AppLog.d(file?.path ?? '?');
//       //           // AppLog.d(file?.name ?? '?');
//       //           if (file != null) {
//       //             final response = await Api.uploadFile(file.path, file.name);
//       //             if (response.success) {
//       //               final submission = Submission(response.data['subid']);
//       //               Storage.submissionsBox.add(submission);
//       //               await submission.updateStatus();
//       //             }
//       //           }
//       //         },
//       //         child: Text('open file'),
//       //       )
//       //     ],
//       //   ),
//       // ),
//     );
//   }

//   void _uploadImage() async {
//     // await Storage.createSubmission(4661390);
//     // await Storage.createSubmission(4665492)..updateStatus();
//     // await Storage.createSubmission(4666953);

//     final typeGroup = XTypeGroup(
//       label: 'images',
//       extensions: ['jpg', 'jpeg', 'png', 'gif', 'fits']
//     );
//     final file = await openFile(
//       acceptedTypeGroups: [typeGroup]
//     );
//     // AppLog.d(file?.path ?? '?');
//     // AppLog.d(file?.name ?? '?');
//     if (file != null) {
//       final response = await Api.uploadFile(file.path, file.name);
//       if (response.success) {
//         final submissionId = response.data['subid'];
//         await Storage.createSubmission(submissionId)..updateStatus();
//       }
//     }
//   }
// }
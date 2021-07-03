import 'package:astrometry_net/api/api.dart';
import 'package:astrometry_net/database/job.dart';
import 'package:astrometry_net/resources/page_arguments.dart';
import 'package:astrometry_net/widgets/app_network_image.dart';
import 'package:astrometry_net/widgets/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPage extends StatelessWidget {
  const JobPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = PageArguments.of(context);
    final job = args['job'] as Job;

    final divider = SizedBox(height: 8.0);

    return PageLayout(
      title: 'Job results',
      child: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width),

              Row(
                children: [
                  Text('ID: '),
                  Text(job.id.toString()),
                ],
              ),
              Row(
                children: [
                  Text('Status: '),
                  Text(job.status),
                ],
              ),

              divider,

              Row(
                children: [
                  Expanded(
                    child: Text('WCS file: '),
                  ),
                  TextButton(
                    onPressed: () {
                      launch('${Api.URL}/wcs_file/${job.id}');
                    },
                    child: Text('wcs.fits'),
                  ),
                ],
              ),

              divider,

              Row(
                children: [
                  Expanded(
                    child: Text('New FITS image: '),
                  ),
                  TextButton(
                    onPressed: () {
                      launch('${Api.URL}/new_fits_file/${job.id}');
                    },
                    child: Text('new-image.fits'),
                  ),
                ],
              ),

              divider,

              Row(
                children: [
                  Expanded(
                    child: Text('Reference stars nearby (RA,Dec table): '),
                  ),
                  TextButton(
                    onPressed: () {
                      launch('${Api.URL}/rdls_file/${job.id}');
                    },
                    child: Text('rdls.fits'),
                  ),
                ],
              ),

              divider,

              Row(
                children: [
                  Expanded(
                    child: Text('Stars detected in your images (x,y table): '),
                  ),
                  TextButton(
                    onPressed: () {
                      launch('${Api.URL}/axy_file/${job.id}');
                    },
                    child: Text('axy.fits'),
                  ),
                ],
              ),

              divider,

              Row(
                children: [
                  Expanded(
                    child: Text('Correspondences between image and reference stars (table): '),
                  ),
                  TextButton(
                    onPressed: () {
                      launch('${Api.URL}/corr_file/${job.id}');
                    },
                    child: Text('corr.fits'),
                  ),
                ],
              ),

              divider,

              SizedBox(
                width: double.maxFinite,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    _buildImagePreview(
                      context,
                      title: 'Annotated',
                      type: 'annotated_display',
                      jobId: job.id,
                    ),
                    _buildImagePreview(
                      context,
                      title: 'Grid',
                      type: 'grid_display',
                      jobId: job.id,
                    ),
                    _buildImagePreview(
                      context,
                      title: 'Red-Green',
                      type: 'red_green_image_display',
                      jobId: job.id,
                    ),
                    _buildImagePreview(
                      context,
                      title: 'Extraction',
                      type: 'extraction_image_display',
                      jobId: job.id,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context, {
    required String title,
    required String type,
    required int jobId
  }) {
    const maxImagesCount = 4;
    const padding = 16.0; // page padding
    const spacing = 8.0; // wrap spacing

    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width - padding * 2;

    double cardWidth = 320.0;
    final realCardWidth = 320.0 + 8.0; // add Card's extra margin

    final absItemsCount = (screenWidth / realCardWidth).floor();
    final realWrapWidth = screenWidth - (spacing * (absItemsCount));

    if (realWrapWidth % realCardWidth > 0) {
      final currentCount = (realWrapWidth / realCardWidth).floor();
      if (currentCount < maxImagesCount) {
        cardWidth = (realWrapWidth / (currentCount + 1)).floorToDouble();
        cardWidth -= 8.0; // substract Card's extra margin
      }
    }

    if (mediaQuery.size.width < mediaQuery.size.height && screenWidth < 600) {
      cardWidth = screenWidth;
    }

    return Card(
      child: SizedBox(
        width: cardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(title),
            ),

            Center(
              child: AppNetworkImage('${Api.URL}/$type/$jobId',
                withProgress: true,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: PhotoView(
                          imageProvider: NetworkImage('${Api.URL}/$type/$jobId'),
                          tightMode: true,
                        ),
                      );
                    }
                  );
                }
              )
            ),
            
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () async {
                    await launch('${Api.URL}/$type/$jobId');
                  },
                  child: Text('Open in browser'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
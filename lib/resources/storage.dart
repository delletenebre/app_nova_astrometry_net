import 'package:astrometry_net/api/api.dart';
import 'package:astrometry_net/database/annotation.dart';
import 'package:astrometry_net/database/calibration.dart';
import 'package:astrometry_net/database/job.dart';
import 'package:astrometry_net/database/submission.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_localization.dart';

export 'package:hive_flutter/hive_flutter.dart';

class Storage {
  static const PREF_KEY_LOCALE = 'locale';
  static final defaultLocale = AppLocalization.systemLocale;

  static const PREF_KEY_DARK_THEME = 'darkTheme';
  static final defaultDarkTheme = false;

  static const PREF_KEY_SESSION_KEY = 'sessionKey';
  static final defaultSessionKey = '';

  static const PREF_KEY_API_KEY = 'apiKey';
  static final defaultApiKey = '';

  static late final Box settingsBox;
  static late final Box<Submission> submissionsBox;
  static late final Box<Job> jobsBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    settingsBox = await Hive.openBox('settings');

    Hive.registerAdapter(AnnotationAdapter());
    Hive.registerAdapter(CalibrationAdapter());
    Hive.registerAdapter(JobAdapter());
    Hive.registerAdapter(SubmissionAdapter());

    // Hive.deleteBoxFromDisk('submissions');
    // Hive.deleteBoxFromDisk('jobs');

    submissionsBox = await Hive.openBox('submissions');
    jobsBox = await Hive.openBox('jobs');
  }

  static dynamic read(String key, {dynamic defaultValue}) {
    return settingsBox.get(key, defaultValue: defaultValue);
  }

  static void write(String key, dynamic value) {
    settingsBox.put(key, value);
  }

  static String getLocale() {
    return read(PREF_KEY_LOCALE, defaultValue: defaultLocale);
  }
  static void saveLocale(String value) {
    return write(PREF_KEY_LOCALE, value);
  }

  static bool getDarkThemeEnabled() {
    return read(PREF_KEY_DARK_THEME, defaultValue: defaultDarkTheme);
  }
  static void saveDarkThemeEnabled(bool value) {
    return write(PREF_KEY_DARK_THEME, value);
  }

  static Future<String> getSessionKey() async {
    var sessionKey = read(PREF_KEY_SESSION_KEY, defaultValue: defaultSessionKey);
    if (sessionKey == defaultSessionKey) {
      sessionKey = await Api.login();
    }

    return sessionKey;
  }
  static void saveSessionKey(String value) {
    return write(PREF_KEY_SESSION_KEY, value);
  }

  static String getApiKey() {
    return read(PREF_KEY_API_KEY, defaultValue: defaultApiKey);
  }
  static void saveApiKey(String value) {
    return write(PREF_KEY_API_KEY, value);
  }

  static Future<Job> createJob(int id) async {
    final job = Job(id);
    await jobsBox.add(job);
    return job;
  }

  static Future<Submission> createSubmission(int id) async {
    final submission = Submission(id);
    await submissionsBox.add(submission);
    return submission;
  }

  static Future<ApiResponse> syncJobsWithServer() async {
    final response = await Api.getJobs();
    if (response.success) {
      final localJobs = jobsBox.values;

      final localJobsIds = List<int>.from(localJobs.map((job) => job.id));
      final serverJobsIds = List<int>.from(response.data['jobs']);

      final notSyncedJobsIds = serverJobsIds.where((serverJobId) => !localJobsIds.contains(serverJobId));

      for (final jobId in notSyncedJobsIds) {
        final job = await Storage.createJob(jobId);
        await job.updateStatus();
      }
    }

    return response;
  }
}


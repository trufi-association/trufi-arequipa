// Pure VM test: hive 2.2.3 runs on dart:io with Hive.init(<temp dir>), no
// plugin, no device. Covers the #71 fix (fresh instances read the box on
// demand) and the start-up rule of the survey prompt.
import 'dart:io';

import 'package:arequipa_bus/pages/survey/repository/survey_hive_local_repository.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

/// What LifecycleReactorNotifications2.onInitState does on every cold start,
/// minus the UI: returns whether the survey modal would open.
Future<bool> simulateStart() async {
  final repository = SurveyHiveLocalRepository();
  final startCount = await repository.getCount() + 1;
  await repository.saveCount(startCount);
  return SurveyHiveLocalRepository.shouldShowSurvey(
    startCount: startCount,
    completed: await repository.isCompleted(),
  );
}

void main() {
  late Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('survey_box_');
    Hive.init(dir.path);
    await Hive.openBox(SurveyHiveLocalRepository.path);
  });

  tearDown(() async {
    await Hive.close();
    await dir.delete(recursive: true);
  });

  group('box access (#71: the box is read on demand)', () {
    test('fresh instances read and write the counter, nothing to load first',
        () async {
      expect(await SurveyHiveLocalRepository().getCount(), 0);
      await SurveyHiveLocalRepository().saveCount(1);
      expect(await SurveyHiveLocalRepository().getCount(), 1);
    });

    test('getSurvey is null until saveSurvey (SurveyCubit._load path)',
        () async {
      final repository = SurveyHiveLocalRepository();
      expect(await repository.getSurvey(), isNull);
      await repository.saveSurvey(SurveyState.surveyStateDefault
          .copyWith(isPresentation: false)
          .toJson());
      expect((await repository.getSurvey())!.isPresentation, isFalse);
    });

    test('with the box closed the getter throws HiveError (not silent)',
        () async {
      await Hive.close();
      await expectLater(
        SurveyHiveLocalRepository().getCount(),
        throwsA(isA<HiveError>()),
      );
    });

    test('isCompleted is false until markCompleted, also across instances',
        () async {
      expect(await SurveyHiveLocalRepository().isCompleted(), isFalse);
      await SurveyHiveLocalRepository().markCompleted();
      expect(await SurveyHiveLocalRepository().isCompleted(), isTrue);
    });
  });

  group('shouldShowSurvey (pure rule)', () {
    test('asks on starts 2 to maxSurveyPrompts + 1 only', () {
      final asked = [
        for (var start = 1; start <= 10; start++)
          if (SurveyHiveLocalRepository.shouldShowSurvey(
            startCount: start,
            completed: false,
          ))
            start,
      ];
      expect(asked.length, SurveyHiveLocalRepository.maxSurveyPrompts);
      expect(asked, [2, 3, 4],
          reason: 'maxSurveyPrompts is 3 by default; update this list with it');
    });

    test('never once the survey was completed', () {
      for (var start = 1; start <= 10; start++) {
        expect(
          SurveyHiveLocalRepository.shouldShowSurvey(
            startCount: start,
            completed: true,
          ),
          isFalse,
          reason: 'start $start',
        );
      }
    });
  });

  group('start-up sequence (reactor logic against the real box)', () {
    test('the counter grows on every start; the modal opens on 2, 3 and 4',
        () async {
      final opened = <int>[];
      for (var start = 1; start <= 6; start++) {
        if (await simulateStart()) opened.add(start);
        expect(await SurveyHiveLocalRepository().getCount(), start);
      }
      expect(opened, [2, 3, 4]);
    });

    test('submitting the survey stops the prompt before the cap', () async {
      expect(await simulateStart(), isFalse); // start 1
      expect(await simulateStart(), isTrue); // start 2: asked and answered
      await SurveyHiveLocalRepository().markCompleted();
      expect(await simulateStart(), isFalse); // start 3
      expect(await simulateStart(), isFalse); // start 4
    });
  });
}

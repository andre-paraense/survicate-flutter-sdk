import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survicate_flutter_sdk/models/survicate_answer_model.dart';
import 'package:survicate_flutter_sdk/models/user_traits_model.dart';
import 'package:survicate_flutter_sdk/survicate_flutter_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('survicate_flutter_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  final SurvicateFlutterSdk survicateFlutterSdk = SurvicateFlutterSdk();

  setUpAll(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'registerSurveyListeners') {
        return true;
      }

      if (methodCall.method == 'unregisterSurveyListeners') {
        return true;
      }

      if (methodCall.method == 'invokeEvent') {
        return true;
      }

      if (methodCall.method == 'enterScreen') {
        return true;
      }

      if (methodCall.method == 'leaveScreen') {
        return true;
      }

      if (methodCall.method == 'setUserTraits') {
        return true;
      }

      if (methodCall.method == 'reset') {
        return true;
      }

      return survicateFlutterSdk.handlerMethodCalls(methodCall);
    });
  });

  tearDown(() {
    survicateFlutterSdk.onSurveyDisplayedListener = null;
    survicateFlutterSdk.onQuestionAnsweredListener = null;
    survicateFlutterSdk.onSurveyClosedListener = null;
    survicateFlutterSdk.onSurveyCompletedListener = null;
  });

  tearDownAll(() {
    channel.setMockMethodCallHandler(null);
  });

  group('reset', () {
    test('Return true upon correctly calling reset', () async {
      expect(await survicateFlutterSdk.reset(), true);
    });
  });

  group('setUserTraits', () {
    test('Return false if user traits are null', () async {
      expect(await survicateFlutterSdk.setUserTraits(null), false);
    });

    test('Return false if user traits are all null', () async {
      expect(
          await survicateFlutterSdk.setUserTraits(UserTraitsModel(
              userId: null, firstName: null, customTraits: null)),
          false);
    });

    test('Return false if user traits are all empty', () async {
      expect(
          await survicateFlutterSdk.setUserTraits(
              UserTraitsModel(userId: null, firstName: null, customTraits: {})),
          false);
    });

    test('Return true if any user trait is not empty', () async {
      expect(
          await survicateFlutterSdk.setUserTraits(UserTraitsModel(
              userId: 'userId', firstName: null, customTraits: {})),
          true);
    });

    test('Return true if all user traits are not empty', () async {
      expect(
          await survicateFlutterSdk.setUserTraits(UserTraitsModel(
              userId: 'userId',
              firstName: 'userName',
              addressFirstLine: 'addressFirstLine',
              addressSecondLine: 'addressSecondLine',
              annualRevenue: 'annualRevenue',
              city: 'city',
              department: 'department',
              email: 'email',
              employees: 'employees',
              fax: 'fax',
              industry: 'industry',
              jobTitle: 'jobTitle',
              lastName: 'lastName',
              organization: 'organization',
              phone: 'phone',
              state: 'state',
              website: 'website',
              zipCode: 'zipCode',
              customTraits: {'customKey': 'customValue'})),
          true);
    });
  });

  group('leaveScreen', () {
    test('Return false if screen name is null', () async {
      expect(await survicateFlutterSdk.leaveScreen(null), false);
    });

    test('Return false if screen name is empty', () async {
      expect(await survicateFlutterSdk.leaveScreen(''), false);
    });

    test('Return true if screen name is passed', () async {
      expect(await survicateFlutterSdk.leaveScreen('screenName'), true);
    });
  });

  group('enterScreen', () {
    test('Return false if screen name is null', () async {
      expect(await survicateFlutterSdk.enterScreen(null), false);
    });

    test('Return false if screen name is empty', () async {
      expect(await survicateFlutterSdk.enterScreen(''), false);
    });

    test('Return true if screen name is passed', () async {
      expect(await survicateFlutterSdk.enterScreen('screenName'), true);
    });
  });

  group('invokeEvent', () {
    test('Return false if event name is null', () async {
      expect(await survicateFlutterSdk.invokeEvent(null), false);
    });

    test('Return false if event name is empty', () async {
      expect(await survicateFlutterSdk.invokeEvent(''), false);
    });

    test('Return true if event name is passed', () async {
      expect(await survicateFlutterSdk.invokeEvent('eventName'), true);
    });
  });

  group('registerSurveyListeners', () {
    test('Return false if the callbacks are null', () async {
      expect(
          await survicateFlutterSdk.registerSurveyListeners(
              callbackSurveyDisplayedListener: null,
              callbackQuestionAnsweredListener: null,
              callbackSurveyClosedListener: null,
              callbackSurveyCompletedListener: null),
          false);
    });

    test('Return true if the callbacks are passed and previously registered',
        () async {
      bool Function(String?) previousCallback = (String? surveyId) {
        return false;
      };
      survicateFlutterSdk.onSurveyDisplayedListener = previousCallback;
      bool Function(String?) newCallback = (String? surveyId) {
        return true;
      };
      bool Function(String?, num?, SurvicateAnswerModel)
          previousCallbackQuestion =
          (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
        return false;
      };
      survicateFlutterSdk.onQuestionAnsweredListener = previousCallbackQuestion;
      bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
          (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
        return true;
      };
      expect(
          await survicateFlutterSdk.registerSurveyListeners(
              callbackSurveyDisplayedListener: newCallback,
              callbackQuestionAnsweredListener: newCallbackQuestion,
              callbackSurveyClosedListener: newCallback,
              callbackSurveyCompletedListener: newCallback),
          true);
      expect(survicateFlutterSdk.onSurveyDisplayedListener!('surveyId'), true);
      expect(
          survicateFlutterSdk.onQuestionAnsweredListener!(
              'surveyId',
              1,
              SurvicateAnswerModel.fromMap(
                  {'type': 'type', 'id': null, 'ids': null, 'value': null})),
          true);
      expect(survicateFlutterSdk.onSurveyClosedListener!('surveyId'), true);
      expect(survicateFlutterSdk.onSurveyCompletedListener!('surveyId'), true);
    });

    test('Return true if the callback is passed and not previously registered',
        () async {
      bool Function(String?) newCallback = (String? surveyId) {
        return true;
      };
      bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
          (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
        return true;
      };
      expect(
          await survicateFlutterSdk.registerSurveyListeners(
              callbackSurveyDisplayedListener: newCallback,
              callbackQuestionAnsweredListener: newCallbackQuestion,
              callbackSurveyClosedListener: newCallback,
              callbackSurveyCompletedListener: newCallback),
          true);
      expect(survicateFlutterSdk.onSurveyDisplayedListener!('surveyId'), true);
      expect(
          survicateFlutterSdk.onQuestionAnsweredListener!(
              'surveyId',
              1,
              SurvicateAnswerModel.fromMap({
                'type': 'type',
                'id': 1,
                'ids': [1, 2, 3],
                'value': 'value'
              })),
          true);
      expect(survicateFlutterSdk.onSurveyClosedListener!('surveyId'), true);
      expect(survicateFlutterSdk.onSurveyCompletedListener!('surveyId'), true);
    });
  });

  group('unregisterSurveyListeners', () {
    test('Return false if the registered listener is null', () async {
      expect(await survicateFlutterSdk.unregisterSurveyListeners(), false);
    });

    test('Return true if there was a previous registered listener', () async {
      bool Function(String?) previousCallback = (String? surveyId) {
        return true;
      };
      bool Function(String?, num?, SurvicateAnswerModel)
          previousCallbackQuestion =
          (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
        return false;
      };
      survicateFlutterSdk.onSurveyDisplayedListener = previousCallback;
      survicateFlutterSdk.onQuestionAnsweredListener = previousCallbackQuestion;
      survicateFlutterSdk.onSurveyClosedListener = previousCallback;
      survicateFlutterSdk.onSurveyCompletedListener = previousCallback;
      expect(await survicateFlutterSdk.unregisterSurveyListeners(), true);
      expect(survicateFlutterSdk.onSurveyDisplayedListener, null);
      expect(survicateFlutterSdk.onQuestionAnsweredListener, null);
      expect(survicateFlutterSdk.onSurveyClosedListener, null);
      expect(survicateFlutterSdk.onSurveyCompletedListener, null);
    });
  });

  group('handlerMethodCalls', () {
    test('non-existing method callback', () async {
      String argument = 'argument';

      Map<String, String> arguments = {};
      arguments['argument'] = argument;

      try {
        await channel.invokeMethod('non-existing-method', arguments);
        fail("exception not thrown");
      } catch (e) {
        expect(e, isInstanceOf<MissingPluginException>());
      }
    });

    group('onSurveyDisplayedListener', () {
      test('Return false if there is no survey displayed listener attached',
          () async {
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';

        expect(
            await channel.invokeMethod('onSurveyDisplayed', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        expect(await channel.invokeMethod('onSurveyDisplayed', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, String> arguments = {};
        expect(
            await channel.invokeMethod('onSurveyDisplayed', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments',
          () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';
        expect(
            await channel.invokeMethod('onSurveyDisplayed', arguments), true);
      });
    });

    group('onQuestionAnsweredListener', () {
      test('Return false if there is no survey displayed listener attached',
          () async {
        Map<String, dynamic> arguments = {};
        arguments['surveyId'] = 'surveyId';
        arguments['questionId'] = 1;
        arguments['answer'] = {
          'type': 'type',
          'id': 1,
          'ids': [1, 2, 3],
          'value': 'value'
        };

        expect(
            await channel.invokeMethod('onQuestionAnswered', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        expect(await channel.invokeMethod('onQuestionAnswered', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, dynamic> arguments = {};
        expect(
            await channel.invokeMethod('onQuestionAnswered', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments',
          () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, dynamic> arguments = {};
        arguments['surveyId'] = 'surveyId';
        arguments['questionId'] = 1;
        arguments['answer'] = {
          'type': 'type',
          'id': 1,
          'ids': [1, 2, 3],
          'value': 'value'
        };
        expect(
            await channel.invokeMethod('onQuestionAnswered', arguments), true);
      });
    });

    group('onSurveyClosedListener', () {
      test('Return false if there is no survey displayed listener attached',
          () async {
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';

        expect(await channel.invokeMethod('onSurveyClosed', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        expect(await channel.invokeMethod('onSurveyClosed', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, String> arguments = {};
        expect(await channel.invokeMethod('onSurveyClosed', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments',
          () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';
        expect(await channel.invokeMethod('onSurveyClosed', arguments), true);
      });
    });

    group('onSurveyCompletedListener', () {
      test('Return false if there is no survey displayed listener attached',
          () async {
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';

        expect(
            await channel.invokeMethod('onSurveyCompleted', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        expect(await channel.invokeMethod('onSurveyCompleted', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, String> arguments = {};
        expect(
            await channel.invokeMethod('onSurveyCompleted', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments',
          () async {
        bool Function(String?) newCallback = (String? surveyId) {
          return true;
        };
        bool Function(String?, num?, SurvicateAnswerModel) newCallbackQuestion =
            (String? surveyId, num? questionId, SurvicateAnswerModel answer) {
          return true;
        };
        expect(
            await survicateFlutterSdk.registerSurveyListeners(
                callbackSurveyDisplayedListener: newCallback,
                callbackQuestionAnsweredListener: newCallbackQuestion,
                callbackSurveyClosedListener: newCallback,
                callbackSurveyCompletedListener: newCallback),
            true);
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';
        expect(
            await channel.invokeMethod('onSurveyCompleted', arguments), true);
      });
    });
  });
}

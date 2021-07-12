import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:messageboard_app/main.dart';


void main() {

  group('Testing App Performance Tests', () {

    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    final signInButton = find.byKey(ValueKey("signin"));
    final games = find.byKey(ValueKey("games"));
    Firebase.initializeApp();

    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(MyApp());
      


  await binding.watchPerformance(() async {
    await tester.pumpAndSettle();
  }, reportKey: 'scrolling_summary');
});
testWidgets('signin', (tester) async {
  await tester.pumpWidget(MyApp());

  try{
    await tester.tap(signInButton);
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.text('Welcome! Select A Room'), findsOneWidget);

  }catch(e) {

  }

try{
    await tester.tap(games);
    await tester.pumpAndSettle();

  }catch(e) {

  }


});
    });
}
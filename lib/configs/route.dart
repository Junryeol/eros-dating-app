import 'package:eros/widgets/pages/home_page.dart';
import 'package:eros/widgets/pages/error_page.dart';
import 'package:eros/widgets/pages/sign_in_page.dart';
import 'package:eros/widgets/pages/sign_up_page.dart';
import 'package:eros/widgets/pages/sign_out_page.dart';
import 'package:eros/widgets/pages/splash_page.dart';
import 'package:eros/widgets/pages/intro_page.dart';
import 'package:eros/widgets/pages/image_crop_page.dart';

class RoutePath {
  static routes(context){
    return {
      '/home': (context) => HomePage(),
      '/image_crop': (context) => ImageCropPage(),
      '/intro': (context) => IntroPage(),
      '/error': (context) => ErrorPage(),
      '/sign_up': (context) => SignUpPage(),
      '/sign_in': (context) => SignInPage(),
      '/sign_out': (context) => SignOutPage(),
      '/splash': (context) => SplashPage(),
    };
  }
}

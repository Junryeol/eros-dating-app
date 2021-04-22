import 'package:eros/widgets/pages/account/create_account_page.dart';
import 'package:eros/widgets/pages/account/find_email_page.dart';
import 'package:eros/widgets/pages/account/reset_password_page.dart';
import 'package:eros/widgets/pages/account/terms_agreement_page.dart';
import 'package:eros/widgets/pages/account/terms_detail_page.dart';
import 'package:eros/widgets/pages/home_page.dart';
import 'package:eros/widgets/pages/index_page.dart';
import 'package:eros/widgets/pages/profile/basic_profile_page.dart';
import 'package:eros/widgets/pages/profile/profile_tag_select_page.dart';
import 'package:eros/widgets/pages/profile/register_profile_page.dart';
import 'package:eros/widgets/pages/system/error_page.dart';
import 'package:eros/widgets/pages/account/sign_in_page.dart';
import 'package:eros/widgets/pages/account/sign_up_page.dart';
import 'package:eros/widgets/pages/system/splash_page.dart';
import 'package:eros/widgets/pages/system/intro_page.dart';
import 'package:eros/widgets/pages/profile/image_crop_page.dart';
import 'package:eros/widgets/pages/test_page.dart';

class RoutePath {
  static routes(context){
    return {
      '/test': (context) => TestPage(),
      '/home': (context) => HomePage(),
      '/image_crop': (context) => ImageCropPage(),
      '/intro': (context) => IntroPage(),
      '/error': (context) => ErrorPage(),
      '/sign_up': (context) => SignUpPage(),
      '/sign_in': (context) => SignInPage(),
      '/register_profile': (context) => RegisterProfilePage(),
      '/splash': (context) => SplashPage(),
      '/terms_detail': (context) => TermsDetailPage(),
      '/index': (context) => IndexPage(),
      '/basic_profile': (context) => BasicProfilePage(),
      '/profile_tag_select': (context) => ProfileTagSelectPage(),
    };
  }
}

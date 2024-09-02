import 'package:get/get.dart';

import '../modules/add_new_car/bindings/add_new_car_binding.dart';
import '../modules/add_new_car/views/add_new_car_view.dart';
import '../modules/banned/bindings/banned_binding.dart';
import '../modules/banned/views/banned_view.dart';
import '../modules/edit_car/bindings/edit_car_binding.dart';
import '../modules/edit_car/views/edit_car_view.dart';
import '../modules/get_started/bindings/get_started_binding.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/gifts/bindings/gifts_binding.dart';
import '../modules/gifts/views/gifts_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/my_account/bindings/my_account_binding.dart';
import '../modules/my_account/views/my_account_view.dart';
import '../modules/my_cars/bindings/my_cars_binding.dart';
import '../modules/my_cars/views/my_cars_view.dart';
import '../modules/my_reservations/bindings/my_reservations_binding.dart';
import '../modules/my_reservations/views/my_reservations_view.dart';
import '../modules/new_update/bindings/new_update_binding.dart';
import '../modules/new_update/views/new_update_view.dart';
import '../modules/remind_password/bindings/remind_password_binding.dart';
import '../modules/remind_password/views/remind_password_view.dart';
import '../modules/reservation_details/bindings/reservation_details_binding.dart';
import '../modules/reservation_details/views/reservation_details_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/send_gifts/bindings/send_gifts_binding.dart';
import '../modules/send_gifts/views/send_gifts_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/subscriptions/bindings/subscriptions_binding.dart';
import '../modules/subscriptions/views/subscriptions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NEW_UPDATE,
      page: () => const NewUpdateView(),
      binding: NewUpdateBinding(),
    ),
    GetPage(
      name: _Paths.BANNED,
      page: () => const BannedView(),
      binding: BannedBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.REMIND_PASSWORD,
      page: () => const RemindPasswordView(),
      binding: RemindPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_CARS,
      page: () => const MyCarsView(),
      binding: MyCarsBinding(),
    ),
    GetPage(
      name: _Paths.GIFTS,
      page: () => const GiftsView(),
      binding: GiftsBinding(),
    ),
    GetPage(
      name: _Paths.MY_ACCOUNT,
      page: () => const MyAccountView(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: _Paths.MY_RESERVATIONS,
      page: () => const MyReservationsView(),
      binding: MyReservationsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_CAR,
      page: () => const AddNewCarView(),
      binding: AddNewCarBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_CAR,
      page: () => const EditCarView(),
      binding: EditCarBinding(),
    ),
    GetPage(
      name: _Paths.RESERVATION_DETAILS,
      page: () => const ReservationDetailsView(),
      binding: ReservationDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEND_GIFTS,
      page: () => const SendGiftsView(),
      binding: SendGiftsBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTIONS,
      page: () => const SubscriptionsView(),
      binding: SubscriptionsBinding(),
    ),
  ];
}

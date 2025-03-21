import 'package:go_router/go_router.dart';
import 'package:sehattek_app/presentation/layout/common_layout.dart';
import 'package:sehattek_app/presentation/pages/auth/desktop/login_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => CommonLayout(child: LoginPage())),
  ],
);

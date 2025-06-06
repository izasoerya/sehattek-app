import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:sehattek_app/presentation/layout/common_layout.dart';
import 'package:sehattek_app/presentation/pages/auth/desktop/login_page_desktop.dart';
import 'package:sehattek_app/presentation/pages/auth/desktop/register_page_desktop.dart';
import 'package:sehattek_app/presentation/pages/auth/mobile/login_page_mobile.dart';
import 'package:sehattek_app/presentation/pages/auth/mobile/register_page_mobile.dart';
import 'package:sehattek_app/presentation/pages/dashboard/desktop/dashboard_page_desktop.dart';
import 'package:sehattek_app/presentation/pages/dashboard/mobile/dashboard_page_mobile.dart';
import 'package:sehattek_app/presentation/pages/order/desktop/order_page_desktop.dart';
import 'package:sehattek_app/presentation/pages/order/mobile/order_page_mobile.dart';

String determinePlatform(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if (ResponsiveBreakpoints.of(context).between(MOBILE, TABLET)) {
    return 'mobile';
  } else if (ResponsiveBreakpoints.of(context).between(TABLET, DESKTOP)) {
    return 'tablet';
  } else if (ResponsiveBreakpoints.of(context).between(DESKTOP, '4K')) {
    return 'desktop';
  } else if (width > 1920) {
    return 'large desktop';
  } else if (width > 2560) {
    return '4k';
  }
  return 'desktop';
}

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    if (state.fullPath == '/login' &&
        BlocProvider.of<AuthenticationBloc>(context).state is UserLoggedIn) {
      return '/dashboard';
    } else if (state.fullPath == '/dashboard' &&
        BlocProvider.of<AuthenticationBloc>(context).state is! UserLoggedIn) {
      return '/login';
    } else if (state.fullPath == '/order' &&
        BlocProvider.of<AuthenticationBloc>(context).state is! UserLoggedIn) {
      return '/login';
    }
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        String platform = determinePlatform(context);

        if (platform == 'mobile') {
          return CommonLayout(child: LoginPageMobile());
        } else if (platform == 'desktop') {
          return CommonLayout(child: LoginPageDesktop());
        } else {
          return CommonLayout(child: LoginPageDesktop()); // 4k platform
        }
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        String platform = determinePlatform(context);

        if (platform == 'mobile') {
          return CommonLayout(child: RegisterPageMobile());
        } else if (platform == 'desktop') {
          return CommonLayout(child: RegisterPageDesktop());
        } else {
          return CommonLayout(child: RegisterPageDesktop()); // 4k platform
        }
      },
    ),
    GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          String platform = determinePlatform(context);

          if (platform == 'mobile') {
            return CommonLayout(child: DashboardPageMobile());
          } else if (platform == 'desktop') {
            return CommonLayout(child: DashboardPageDesktop());
          } else {
            return CommonLayout(child: DashboardPageDesktop()); // 4k platform
          }
        }),
    GoRoute(
        path: '/order',
        builder: (context, state) {
          String platform = determinePlatform(context);

          if (platform == 'mobile') {
            return CommonLayout(child: OrderPageMobile());
          } else if (platform == 'desktop') {
            return CommonLayout(child: OrderPageDesktop());
          } else {
            return CommonLayout(child: OrderPageDesktop()); // 4k platform
          }
        }),
    GoRoute(
        path: '/report',
        builder: (context, state) {
          String platform = determinePlatform(context);

          if (platform == 'mobile') {
            return CommonLayout(child: DashboardPageMobile());
          } else if (platform == 'desktop') {
            return CommonLayout(child: DashboardPageDesktop());
          } else {
            return CommonLayout(child: DashboardPageDesktop()); // 4k platform
          }
        }),
  ],
);

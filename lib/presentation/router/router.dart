import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sehattek_app/presentation/layout/common_layout.dart';
import 'package:sehattek_app/presentation/pages/auth/desktop/login_page_desktop.dart';
import 'package:sehattek_app/presentation/pages/auth/desktop/register_page_desktop.dart';
import 'package:sehattek_app/presentation/pages/auth/mobile/login_page_mobile.dart';
import 'package:sehattek_app/presentation/pages/auth/mobile/register_page_mobile.dart';
import 'package:sehattek_app/presentation/pages/dashboard/desktop/dashboard_page_desktop.dart';

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
            return CommonLayout(child: DashboardPageDesktop());
          } else if (platform == 'desktop') {
            return CommonLayout(child: DashboardPageDesktop());
          } else {
            return CommonLayout(child: DashboardPageDesktop()); // 4k platform
          }
        }),
  ],
);

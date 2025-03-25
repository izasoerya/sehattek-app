import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Logo
          // Image.network(
          //   'https://th.bing.com/th/id/R.c770c604acddc785eb785bbaeba4ba3e?rik=8MBQ9zQJEpBP8A&riu=http%3a%2f%2f4.bp.blogspot.com%2f-Gh9XxDrFKOE%2fULCIFZGmm7I%2fAAAAAAAAAy8%2fh1GYADBLSP4%2fs320%2fLogo%2bUGM%2b(Universitas%2bGadjah%2bMada)-hitam.jpg&ehk=OhRHlVSHSLj05HNYGTmHbdD62e2RHI74LtwMjZ67fgs%3d&risl=&pid=ImgRaw&r=0',
          //   height: 40,
          // ),
          Icon(Icons.menu, size: 40),

          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Order',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Reports',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

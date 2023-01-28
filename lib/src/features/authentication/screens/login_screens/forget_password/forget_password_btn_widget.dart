import 'package:flutter/material.dart';

class ForgetPasswordBtnWidget extends StatelessWidget {

  final IconData btnIcon;
  String title, subTitle;
  final VoidCallback onTap;


  ForgetPasswordBtnWidget({
    Key? key,
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(this.btnIcon, size: 40.0,),
            SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.title, style: Theme.of(context).textTheme.bodyMedium,),
                Text(this.subTitle, style: Theme.of(context).textTheme.bodySmall,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

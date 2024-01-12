import 'package:class20/const/all_color.dart';
import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons(
      {super.key,
      required this.titile,
      required this.onTap,
      this.loading = false});
  final String titile;
  final VoidCallback onTap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        color: AllColors.secendaryColors,
        child: InkWell(
          // onTap: loading ? null : onTap,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: AllColors.secendaryColors,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: AllColors.secendaryColors),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: loading
                  ? const CircularProgressIndicator(
                      color: AllColors.textWhiteColor,
                    )
                  : Text(
                      titile,
                      style: const TextStyle(
                          fontSize: 20, color: AllColors.textWhiteColor),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

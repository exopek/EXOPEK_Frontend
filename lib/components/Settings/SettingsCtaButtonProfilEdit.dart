import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsCtaButtonProfilEdit extends StatelessWidget {
  final String userName;
  final String? imageUrl;
  final VoidCallback? onPressed;
  const SettingsCtaButtonProfilEdit(
      {super.key, required this.userName, this.onPressed, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFF0C0C0C),
        ),
        child: Stack(
          children: [
            if (imageUrl != null)
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    ),
                    color: Color(0xFFD9D9D9),
                    shape: OvalBorder(),
                  ),
                ),
              ),
            if (imageUrl == null)
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          color: Color(0xFF262424),
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    )),
              ),
            Positioned(
              left: 100,
              top: 23,
              child: Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 42,
              child: Text(
                AppLocalizations.of(context).profilEditCtaButtonTitle,
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              right: 26,
              top: 30,
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

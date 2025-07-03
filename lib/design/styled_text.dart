import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  final String text;


  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.fugazOne(
      textStyle: TextStyle(color: Colors.green,
      fontSize: 25
      ),
    )
    );
  }
}


class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.zenDots(
      textStyle: TextStyle(color: Colors.white, fontSize: 20),
    )
    );
  }
}

class StyledNote extends StatelessWidget {
  const StyledNote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 12),
    )
    );
  }
}
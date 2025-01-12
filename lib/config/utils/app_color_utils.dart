import 'dart:ui';

extension ColorUtils on Color {
  // Convert Color to int
  int toInt() {
    final alpha = (a * 255).toInt(); // alpha component
    final red = (r * 255).toInt(); // red component
    final green = (g * 255).toInt(); // green component
    final blue = (b * 255).toInt(); // blue component
    // Combine the components into a single int using bit shifting
    return (alpha << 24) | (red << 16) | (green << 8) | blue;
  }
}

// class AppColorUtils {
//   // Convert Color to int
//   static int colorToInt(Color color) {
//     // Convert alpha from 0.0-1.0 to 0-255
//     final a = (color.a * 255).round();
//     // For r,g,b, just round to the nearest integer
//     final r = (color.r * 255).round();
//     final g = (color.g * 255).round();
//     final b = (color.b * 255).round();

//     // Combine the components into a single int using bit shifting
//     return (a << 24) | (r << 16) | (g << 8) | b;
//   }

// Convert int to Color
  // static Color intToColor(int value) {
  //   // Extract alpha and convert to 0.0-1.0
  //   final a = ((value >> 24) & 0xFF) / 255.0;
  //   // Extract r,g,b as direct double values
  //   final r = ((value >> 16) & 0xFF) / 255.0;
  //   final g = ((value >> 8) & 0xFF) / 255.0;
  //   final b = (value & 0xFF) / 255.0;

  //   return Color.fromRGBO(
  //       (r * 255).round(), (g * 255).round(), (b * 255).round(), a);
  // }
// }

import 'package:flutter/material.dart';

/// This class contains all custom styles and theme information
/// to be easily updated in a single place.
class Style {
  const Style();

  // =================
  // | Border radius |
  // =================

  /// Large circular radius: 24
  static const Radius radiusLg = Radius.circular(24);

  /// Medium circular radius: 12
  static const Radius radiusMd = Radius.circular(12);

  /// Small circular radius: 8
  static const Radius radiusSm = Radius.circular(8);

  // ===============
  // | Light Theme |
  // ===============

  /// The custom light theme of this application
  static final ThemeData lightTheme =
      ThemeData.light(useMaterial3: true).copyWith(
    // Light or dark mode
    brightness: Brightness.light,
    // Basic color definitions
    colorScheme: ColorScheme.fromSeed(
      // Overwrite the primary colors
      seedColor: primary500,
      primary: primary500,
      onPrimary: text50,
      secondary: secondary500,
      onSecondary: text950,
      error: errorColor,
      // The main background
      surface: gray100,
      // Elements like cards on the main background
      surfaceContainer: Colors.white,
      // Text on the main background
      onSurface: text950,
      // Text on the cards
      onSurfaceVariant: text800,
    ),
    // Divider
    dividerColor: gray300,
    // Used for shadows and in this project also borders of cards
    shadowColor: Colors.black.withOpacity(.1),
    // Specific text styles and fonts
    textTheme: ThemeData.light(useMaterial3: true).textTheme.apply(
          fontFamily: 'Nunito',
          displayColor: text950,
          bodyColor: text900,
        ),
    primaryTextTheme: ThemeData.light(useMaterial3: true).textTheme.apply(
          fontFamily: 'Nunito',
          displayColor: Colors.white,
          bodyColor: text50,
        ),
    // Bottom navigation theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary500,
      elevation: 2,
    ),
    // Note: If different components are used you might need to provide specific styles for them
  );

  // ===============
  // | Dark Theme |
  // ===============

  /// The custom dark theme of this application
  static final ThemeData darkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    // Light or dark mode
    brightness: Brightness.dark,
    // Basic color definitions
    colorScheme: ColorScheme.fromSeed(
      // Overwrite the primary color
      seedColor: primary400,
      primary: primary400,
      onPrimary: text950,
      secondary: secondary400,
      onSecondary: text950,
      error: errorColor,
      // The main background
      surface: Colors.black,
      // Elements like cards on the main background
      surfaceContainer: gray900,
      // Text on the main background
      onSurface: text50,
      // Text on the cards
      onSurfaceVariant: text100,
    ),
    // Divider
    dividerColor: gray600,
    // Used for shadows and in this project also borders of cards
    shadowColor: Colors.white.withOpacity(.1),
    // Specific text styles and fonts
    textTheme: ThemeData.dark(useMaterial3: true).textTheme.apply(
          fontFamily: 'Nunito',
          displayColor: text50,
          bodyColor: text100,
        ),
    primaryTextTheme: ThemeData.dark(useMaterial3: true).textTheme.apply(
          fontFamily: 'Nunito',
          displayColor: text950,
          bodyColor: text900,
        ),
    // Bottom navigation theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: gray800,
      selectedItemColor: primary400,
      elevation: 2,
    ),
    // Note: If different components are used you might need to provide specific styles for them
  );
}

// Primary swatch -> floob
const Color primary50 = Color(0xFFFFF5ED);
const Color primary100 = Color(0xFFFEE9D6);
const Color primary200 = Color(0xFFFCD0AC);
const Color primary300 = Color(0xFFFAAE77);
const Color primary400 = Color(0xFFF78D51);
const Color primary500 = Color(0xFFF3611C);
const Color primary600 = Color(0xFFE44712);
const Color primary700 = Color(0xFFBD3411);
const Color primary800 = Color(0xFF972A15);
const Color primary900 = Color(0xFF792515);
const Color primary950 = Color(0xFF421008);

// Secondary swatch -> floob
const Color secondary50 = Color(0xFFF6F3FF);
const Color secondary100 = Color(0xFFEEE9FE);
const Color secondary200 = Color(0xFFDFD6FE);
const Color secondary300 = Color(0xFFC8B5FD);
const Color secondary400 = Color(0xFFAD8BFA);
const Color secondary500 = Color(0xFF9862F7);
const Color secondary600 = Color(0xFF8639EE);
const Color secondary700 = Color(0xFF7727DA);
const Color secondary800 = Color(0xFF6420B7);
const Color secondary900 = Color(0xFF531C96);
const Color secondary950 = Color(0xFF331065);

// Text swatch -> floob
const Color text50 = Color(0xFFF9FAFB);
const Color text100 = Color(0xFFF3F4F6);
const Color text200 = Color(0xFFE5E7EB);
const Color text300 = Color(0xFFD1D5DB);
const Color text400 = Color(0xFF9CA3AF);
const Color text500 = Color(0xFF6b7280);
const Color text600 = Color(0xFF4b5563);
const Color text700 = Color(0xFF374151);
const Color text800 = Color(0xFF1F2937);
const Color text900 = Color(0xFF111827);
const Color text950 = Color(0xFF030712);

// Extra colors -> floob
const Color errorColor = Color(0xFFDC2626);
const Color warningColor = Color(0xFFEAB308);
const Color infoColor = Color(0xFF2563EB);
const Color successColor = Color(0xFF16A34A);

// Gray swatch -> tailwindcss zinc
const Color gray50 = Color(0xFFFAFAFA);
const Color gray100 = Color(0xFFF4F4F5);
const Color gray200 = Color(0xFFE4E4E7);
const Color gray300 = Color(0xFFD4D4D8);
const Color gray400 = Color(0xFFA1A1AA);
const Color gray500 = Color(0xFF71717A);
const Color gray600 = Color(0xFF52525B);
const Color gray700 = Color(0xFF3F3F46);
const Color gray800 = Color(0xFF27272A);
const Color gray900 = Color(0xFF18181B);
const Color gray950 = Color(0xFF09090B);

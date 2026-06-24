# Neo Bank Logo Assets

## فایل‌ها

| فایل | کاربرد |
|---|---|
| `layer_1_back.svg` | لایه عقب (کم‌رنگ‌ترین، بنفش روشن، opacity 0.4) |
| `layer_2_middle.svg` | لایه وسط (بنفش پررنگ، opacity 0.7) |
| `layer_3_front.svg` | لایه جلو (سفید، کاملاً مات) |
| `logo_combined_transparent.svg` | هر سه لایه با هم، بدون پس‌زمینه — برای app bar |
| `app_icon_1024.svg` | لوگو با پس‌زمینه مربعی گرد آبی تیره، سایز 1024×1024 — برای آیکون اپ |

## نصب در پروژه Flutter

این فایل‌ها رو کپی کن به:
```
assets/logo/
  layer_1_back.svg
  layer_2_middle.svg
  layer_3_front.svg
  logo_combined_transparent.svg
```

و در `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/logo/
```

پکیج `flutter_svg` رو اضافه کن:
```yaml
dependencies:
  flutter_svg: ^2.0.10
```

## آیکون اپ (iOS / Android)

`app_icon_1024.svg` رو به PNG تبدیل کن (مثلاً با https://cloudconvert.com/svg-to-png یا با Figma/Illustrator)
سپس از پکیج `flutter_launcher_icons` استفاده کن:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/logo/app_icon_1024.png"
```

بعد بزن:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## استفاده در App Bar

```dart
SvgPicture.asset(
  'assets/logo/logo_combined_transparent.svg',
  width: 32,
  height: 32,
)
```

## استفاده در Splash Page (انیمیشن لایه به لایه)

کد کامل ویجت `AnimatedNeoLogo` رو در فایل `animated_neo_logo.dart` ببین.
این ویجت سه تا لایه رو با تأخیر (staggered) و افکت فید + اسلاید نشون میده.

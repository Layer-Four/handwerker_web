# handwerker_web

Run via running lib/main.dart

- Set your preferred line length to 120 characters, so that we can all have a consistent code style  and autoformatting doesn't wrongly format your code.
## use of Freezed code generator
to generate classes with flutter freezed you can look at pub.dev dokumentation. https://pub.dev/packages/freezed

to create a freezed class musst be flaged with  @freezed that import freezed package in file.
also must initialzied two "part" file like 

-   part 'project_vm.freezed.dart';
-   part 'project_vm.g.dart';

important, the file include the parent file name like "project_vm" followed with ".freezed.dart" or ".g.dart" for the mixin class that freezed generated or the json convert class from json_annotation
the mixin class must have the same name of original class and the prefix " _$ " like " _$ProjectVM "
instead of classic constructor we need a factory that return the name of the original class and the prefix " _ " like _ProjectVM
the attributes must required or nullable on some Cases use "@Default" to set defautl value.
if u need  some own mehtod for the generated class you must also write a private Constructor like " Project._();".
### freezed toJson/fromJson

for write the toJson/fromJson, you just need to write the fromJson method and call a lambda expression that return the mixin class and the suffix "FromJson(json)".
exampl:

    -  factory ProjectVM.fromJson(Map<String, dynamic> json) => _$ProjectVMFromJson(json);

when you finish the declaration of your class run in terminal 
when you write more than one class or need more changes than can you run

    -  dart run build_runner watch --delete-conflicting-outputs

this called the builder to look at your changes and rebuild immediately all freezed flaged classes.

for single build calls you can just use 

    -  dart run build_runner build --delete-conflicting-outputs   

sometimes the terminal show hints or errors and show the line of invalidet code.

## firebase deploy

for firebase deploy you must have access to firebase instance, check this with your terminal

    -  firebase login

when the terminal return your email adress or push the webbrowser and ask for your credentials.

After your credentials are successful confirmed you just need go to the project directory like  "cd user/develop/project" and in this directory use

    -   firebase deploy

## build Test version

    -   flutter build apk --release  // build in build\app\outputs\flutter-apk the release version for a installable file for android
    -   flutter build web --release  // build in build directory a web folder with the Web-App
    -   flutter build ios --release  // you need a MacOS device and XCode for build Versions for Apple devices



# flutter_music

# FLUTTER 2.0
# DART 2.12.0
A new Flutter application.
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
 
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## Interval(begin, end)曲线
## mac更新 path
   ###   0. 全程命令路径是用户的root目录： cd ~
   ###
   ###   1. 按快捷键“Command + Space”打开搜索栏，输入“terminal”启动终端，输入： open .zshrc 编辑zsh配置文件。
   ###
   ### 　　　　如果提示找不到此文件，因为是新macOS没有这个文件，需要手动创建。输入： touch .zshrc 即可创建文件。
   ###
   ###   2. 在文本编辑器中输入： source ~/.bash_profile ，按“Command + S”保存文件后关闭文本编辑器。
   ###
   ### 　　　　这行文本的意思是，在zsh终端开启的时候，自动执行“.bash_profile”配置文件，这样配置文件的内容就可以正常加载了。
   ###
   ###   3. 在终端中输入： source ~/.zshrc ，即可正常使用配置的“mvn”命令了。

# flutter run --no-sound-null-safety

#  flutter build apk --target-platform android-arm --split-per-abi --no-sound-null-safety

#  keytool.exe -list -keystore C:\Users\Administrator\Desktop\AndroidStudioProjects\djt.jks -v


# jks转keystore
keytool -importkeystore -srckeystore C:\Users\Administrator\Desktop\AndroidStudioProjects\djt.jks -srcstoretype JKS -deststoretype PKCS12 -destkeystore test.p12
  
 keytool -v -importkeystore -srckeystore C:\Users\Administrator\Desktop\AndroidStudioProjects\test.p12 -srcstoretype PKCS12 -destkeystore C:\Users\Administrator\Desktop\AndroidStudioProjects\test.keystore -deststoretype JKS

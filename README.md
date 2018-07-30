# simple_bfinject_sample

This project is a simple bfinject dynamic library example. More information about bfinject [here](https://github.com/BishopFox/bfinject)

## Compilation

```
MacOS:dir paul$ make
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.4.sdk -miphoneos-version-min=11.0 -g -arch arm64 -I /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.4.sdk/usr/include  -Wdeprecated-declarations   -c -o getpath.o getpath.m
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++ -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.4.sdk -miphoneos-version-min=11.0 -g -arch arm64 -I /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.4.sdk/usr/include  -Wdeprecated-declarations getpath.o -shared -o getpath.dylib -dynamic getpath.m \
	-lobjc -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.4.sdk/usr/lib -lz -lsqlite3 -lxml2 -lz -ldl -lSystem  -framework CoreFoundation -framework IOKit -framework Foundation -framework JavaScriptCore -framework UIKit -framework Security -framework CFNetwork -framework CoreGraphics -ObjC
warning: (arm64)  failed to insert symbol '_bfinject_rocknroll' in the debug map.
warning: (arm64)  failed to insert symbol '___bfinject_rocknroll_block_invoke' in the debug map.
warning: (arm64)  failed to insert symbol '___block_descriptor_tmp' in the debug map.
warning: (arm64)  failed to insert symbol '___block_literal_global' in the debug map.
```

## Execution

You can simply copy the getpath.dlyb library on the iOS device and test it:

```
iPhone-de-Paul:~ root# bash bfinject -P Demo123 -l getpath.dylib 
[+] Electra detected.
[+] Injecting into '/var/containers/Bundle/Application/CF34CBAC-580A-46C7-8C2D-C54DAA2D3B06/Demo123.app/Demo123'
[+] Getting Team ID from target application...
[+] Thinning dylib into non-fat arm64 image
[+] Signing injectable .dylib with Team ID 89RP75VB88 and platform entitlements...
[bfinject4realz] Calling task_for_pid() for PID 894.
[bfinject4realz] Calling thread_create() on PID 894
[bfinject4realz] Looking for ROP gadget... found at 0x183b6d4e0
[bfinject4realz] Fake stack frame at 0x108000000
[bfinject4realz] Calling _pthread_set_self() at 0x183daf778...
[bfinject4realz] Returned from '_pthread_set_self'
[bfinject4realz] Calling dlopen() at 0x183b6d460...
[bfinject4realz] Returned from 'dlopen'
[bfinject4realz] Success! Library was loaded at 0x1d41f3800
[+] So long and thanks for all the fish.
```

You can check the NSLog debug string containing the application path in Xcode (Windows -> Devices -> Console)

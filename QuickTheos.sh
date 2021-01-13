#!/bin/bash

brew install -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Installing homebrew"

brew install ldid xz
echo "Installing ldid"

echo "export THEOS=~/theos" >> ~/.profile
echo "Set up the enviroment"

git clone --recursive https://github.com/theos/theos.git $THEOS
echo "Cloned THEOS"

PS3='Choose an option: '
foods=("Get SDK" "Do not need SDK" "Create tweak template")
select fav in "${foods[@]}"; do
    case $fav in
        "Get SDK")
curl -LO https://github.com/theos/sdks/archive/master.zip
 TMP=$(mktemp -d)
 unzip master.zip -d $TMP
 mv $TMP/sdks-master/*.sdk $THEOS/sdks
 rm -r master.zip $TMP
            ;;
        "Do not need SDK")
logout
            ;;
            "Create tweak template")
cd Desktop

mkdir Tweak

cd

cd Desktop/Tweak

touch control
touch Makefile
touch Tweak.x
touch Tweak.plist
touch Tweak.h

echo
echo "Created all files, now putting text within"
sleep 1
echo

cd
cd Desktop/Tweak
echo "Package: com.name.Tweak
Name: Tweak
Version: 1.0.0
Architecture: iphoneos-arm
Description: 
Maintainer: Name
Author: Name
Section: Tweaks
Depends: applist, ws.hbang.common, preferenceloader, com.rpetrich.rocketbootstrap" >> control

echo
echo "Created control"
sleep 0.1

cd
cd Desktop/Tweak
echo "ARCHS = arm64 arm64e

DEBUG = 0
FINALPACKAGE = 1

export SDKVERSION=13.7

TWEAK_NAME = Tweak
Tweak_FILES = Tweak.x
Tweak_CFLAGS = -fobjc-arc
Tweak_EXTRA_FRAMEWORKS += Cephei
Tweak_PRIVATE_FRAMEWORKS = CoreTelephony
Tweak_LIBRARIES = colorpicker

after-install::
    install.exec "sbreload"


" >> Makefile


echo "Created Makefile"
sleep 0.1

cd
cd Desktop/Tweak
echo "{ Filter = { Bundles = ( "com.apple.UIKit" ); }; }" >> Tweak.plist


echo "Created plist"
sleep 0.1


cd
cd Desktop/Tweak
echo "#import "Tweak.h"" >> Tweak.x


echo "Created Tweak.x"
sleep 0.1


cd
cd Desktop/Tweak
echo "#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <substrate.h>
#import <UIKit/UIKit.h>
#import <sys/types.h>
#import <sys/stat.h>
#import <stdio.h>
#import <unistd.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <errno.h>
#import <libcolorpicker.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Post : NSObject
@end" >> Tweak.h


echo "Created Tweak.h"
sleep 0.1

echo
echo "All done, have fun"
cd
echo
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done
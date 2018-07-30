DYLIBS=getpath.dylib
BFINJECT_SRC=getpath.m
OBJS=$(addsuffix .o,$(basename $(BFINJECT_SRC))) 

SDK=$(shell xcodebuild -showsdks| grep iphoneos | awk '{print $$4}')
SDK_PATH=$(shell xcrun --sdk $(SDK) --show-sdk-path)

CC=$(shell xcrun --sdk $(SDK) --find clang)
CXX=$(shell xcrun --sdk $(SDK) --find clang++)
LD=$(CXX)
INCLUDES=-I $(SDK_PATH)/usr/include 
ARCHS=-arch arm64

IOS_FLAGS=-isysroot $(SDK_PATH) -miphoneos-version-min=11.0
CFLAGS=$(IOS_FLAGS) -g $(ARCHS) $(INCLUDES) -Wdeprecated-declarations
CXXFLAGS=$(IOS_FLAGS) -g $(ARCHS) $(INCLUDES) -Wdeprecated-declarations

FRAMEWORKS=-framework CoreFoundation -framework IOKit -framework Foundation -framework JavaScriptCore -framework UIKit -framework Security -framework CFNetwork -framework CoreGraphics
LIBS=-lobjc -L$(SDK_PATH)/usr/lib -lz -lsqlite3 -lxml2 -lz -ldl -lSystem #$(SDK_PATH)/usr/lib/libstdc++.tbd 
LDFLAGS=$(IOS_FLAGS) $(ARCHS) $(FRAMEWORKS) $(LIBS)  -ObjC -all_load
MAKE=$(shell xcrun --sdk $(SDK) --find make)

DEVELOPERID=$(shell security find-identity -v -p codesigning | grep "iPhone Developer:" |awk '{print $$2}')

all: $(DYLIBS) 

$(DYLIBS): $(OBJS)
	$(CXX) $(CXXFLAGS) getpath.o -shared -o getpath.dylib -dynamic getpath.m \
	$(LIBS) $(FRAMEWORKS) -ObjC
	
$(BINARY_NAME): $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

%.o: %.mm $(DEPS)
	$(CXX) -c $(CXXFLAGS) $< -o $@

%.o: %.c $(DEPS)
	$(CC) -c $(CFLAGS) $< -o $@

webroot.o: webroot.c

clean:
	rm -f getpath.o $(OBJS) 2>&1 > /dev/null
	rm -f $(DYLIBS) 2>&1 > /dev/null

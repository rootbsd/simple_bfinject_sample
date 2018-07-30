#include <stdio.h>
#include <unistd.h>
#include <mach/mach.h>
#include <mach-o/dyld.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <stdint.h>
#import <Foundation/Foundation.h>

#define DEBUG(...) {}


__attribute__ ((constructor)) static void bfinject_rocknroll() {
   NSLog(@"let's start...");

   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{        
     const char *fullPathStr = _dyld_get_image_name(0);
     NSLog(@"Path to app: %s", fullPathStr);
   });

   NSLog(@"let's stop...");

}

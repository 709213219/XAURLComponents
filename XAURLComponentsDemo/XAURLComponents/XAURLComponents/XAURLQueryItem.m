#import "XAURLQueryItem.h"
#import <objc/runtime.h>

@implementation XAURLQueryItem

- (instancetype)initWithName:(NSString *)name value:(NSString *)value {
    if ((self = [super init])) {
        _name = name;
        _value = value;
    }
    return self;
}

+ (instancetype)queryItemWithName:(NSString *)name value:(NSString *)value {
    return [[XAURLQueryItem alloc] initWithName:name value:value];
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        _name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _value = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"value"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_value forKey:@"value"];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return [XAURLQueryItem allocWithZone:zone];
}

#pragma mark - Runtime Injection

__asm(
      ".section        __DATA,__objc_classrefs,regular,no_dead_strip\n"
#if	TARGET_RT_64_BIT
      ".align          3\n"
      "L_OBJC_CLASS_NSURLQueryItem:\n"
      ".quad           _OBJC_CLASS_$_NSURLQueryItem\n"
#else
      ".align          2\n"
      "_OBJC_CLASS_NSURLQueryItem:\n"
      ".long           _OBJC_CLASS_$_NSURLQueryItem\n"
#endif
      ".weak_reference _OBJC_CLASS_$_NSURLQueryItem\n"
      );

__attribute__((constructor)) static void XAURLQueryItemPatchEntry(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            // >= iOS8
            if (objc_getClass("NSURLQueryItem")) {
                return;
            }
            
            Class *urlQueryItem = NULL;
            
#if TARGET_CPU_ARM
            __asm("movw %0, :lower16:(_OBJC_CLASS_NSURLQueryItem-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_NSURLQueryItem-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(urlQueryItem));
#elif TARGET_CPU_ARM64
            __asm("adrp %0, L_OBJC_CLASS_NSURLQueryItem@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_NSURLQueryItem@PAGEOFF" : "=r"(urlQueryItem));
#elif TARGET_CPU_X86_64
            __asm("leaq L_OBJC_CLASS_NSURLQueryItem(%%rip), %0" : "=r"(urlQueryItem));
#elif TARGET_CPU_X86
            void *pc = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_NSURLQueryItem-L0(%0), %1" : "=r"(pc), "=r"(urlQueryItem));
#else 
#error Unsupported CPU
#endif
            
            if (urlQueryItem && !*urlQueryItem) {
                Class class = objc_allocateClassPair([XAURLQueryItem class], "NSURLQueryItem", 0);
                *urlQueryItem = class;
            }
        }
    });
}

@end

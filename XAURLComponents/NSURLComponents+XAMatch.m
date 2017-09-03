#import "NSURLComponents+XAMatch.h"
#import <objc/runtime.h>

@implementation NSURLComponents (XAMatch)

#pragma mark - string
- (NSString *)xa_string {
    return self.URL.absoluteString;
}

#pragma mark - queryItems
- (NSArray *)xa_queryItems {
    NSMutableArray *queryItems = [NSMutableArray array];
    NSDictionary *params = [self paramsWithUrlString:self.string];
    if (params && [params isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in params.allKeys) {
            NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:params[key]];
            [queryItems addObject:item];
        }
    }
    return queryItems;
}

- (NSDictionary *)paramsWithUrlString:(NSString *)urlStr {
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array.lastObject;
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            paramsDict[parArr[0]] = parArr[1];
                        }
                    }
                }
                return paramsDict;
            }
        }
    }
    return nil;
}

#pragma mark - rangeOf
- (NSRange)xa_rangeOfScheme {
    return [self xa_rangeOfString:self.scheme];
}

- (NSRange)xa_rangeOfUser {
    return [self xa_rangeOfString:self.percentEncodedUser];
}

- (NSRange)xa_rangeOfPassword {
    return [self xa_rangeOfString:self.percentEncodedPassword];
}

- (NSRange)xa_rangeOfHost {
    return [self xa_rangeOfString:self.percentEncodedHost];
}

- (NSRange)xa_rangeOfPort {
    return [self xa_rangeOfString:self.port.stringValue];
}

- (NSRange)xa_rangeOfPath {
    return [self xa_rangeOfString:self.percentEncodedPath];
}

- (NSRange)xa_rangeOfQuery {
    return [self xa_rangeOfString:self.percentEncodedQuery];
}

- (NSRange)xa_rangeOfFragment {
    return [self xa_rangeOfString:self.percentEncodedFragment];
}

- (NSRange)xa_rangeOfString:(NSString *)string {
    if (string && [string isKindOfClass:[NSString class]] && string.length) {
        return [self.string rangeOfString:string];
    } else {
        return NSMakeRange(NSNotFound, 0);
    }
}

#pragma mark - Method Resolution
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    Class class = [self class];
    SEL swizzledSelector = NSSelectorFromString([NSString stringWithFormat:@"xa_%@", NSStringFromSelector(sel)]);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    class_addMethod(class, sel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    return YES;
}

@end

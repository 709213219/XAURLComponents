#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XAURLQueryItem : NSObject <NSSecureCoding, NSCopying> {
@private
    NSString *_name;
    NSString *_value;
}
- (instancetype)initWithName:(NSString *)name value:(nullable NSString *)value;
+ (instancetype)queryItemWithName:(NSString *)name value:(nullable NSString *)value;
@property (readonly) NSString *name;
@property (nullable, readonly) NSString *value;

@end

NS_ASSUME_NONNULL_END

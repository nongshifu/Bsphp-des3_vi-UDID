#import "QQ350722326.h"

@implementation NSObject (mian)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject Bsphp];
    });
}
@end

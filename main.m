#import "QQ350722326.h"

@implementation NSObject (mian)
+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"load");
        [NSObject Bsphp];
    });
}
@end

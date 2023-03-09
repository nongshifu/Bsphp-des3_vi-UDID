#import "WX_NongShiFu123.h"

@implementation NSObject (mian)
+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WX_NongShiFu123 alloc] BSPHP];
    });
}
@end

#import "TFJGVGLGKFTVCSV.h"

@interface TFJGVGLGKFTVCSV ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField;
@end
@implementation TFJGVGLGKFTVCSV
- (instancetype)init {
    self = [super init];
    if (self) {
        _textField= [[UITextField alloc] init];
        [_textField setSecureTextEntry:true];
        
        self = _textField.subviews.firstObject;
        [self setUserInteractionEnabled:true];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textField= [[UITextField alloc] init];
        [_textField setSecureTextEntry:true];
        self = _textField.subviews.firstObject;
        self.frame=frame;
        [self setUserInteractionEnabled:true];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _textField= [[UITextField alloc] init];
        [_textField setSecureTextEntry:true];
        
        self = _textField.subviews.firstObject;
        [self setUserInteractionEnabled:true];
    }
    return self;
}

@end

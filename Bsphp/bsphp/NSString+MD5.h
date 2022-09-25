//
//  NSString+MD5.h
//
//  Created by Keith Smiley on 3/25/13.
//  Copyright (c) 2013 Keith Smiley. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef NS_ASSUME_NONNULL_BEGIN
NS_ASSUME_NONNULL_BEGIN
#endif

@interface NSString (MD5)

- (NSString *)__attribute__((optnone))MD5Digest;
- (NSString *)__attribute__((optnone))stringByReversed;

@end

#ifdef NS_ASSUME_NONNULL_END
NS_ASSUME_NONNULL_END
#endif

//
//  NSDictionary+KeyExists.h
//  Test
//
//  Created ByOm Prakash on 3/17/10.
//  Copyright 2010 . All rights reserved.
//
#import <Foundation/Foundation.h>
@interface NSDictionary (KeyExists) 
- (BOOL) keyExists:(NSString *) key;
- (BOOL) valueForKeyIsNull:(NSString *) key;

@end

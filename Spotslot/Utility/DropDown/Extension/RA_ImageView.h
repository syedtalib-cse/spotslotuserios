//
//  RA_ImageView.h
//  RA_Swift
//
//  Created By"Shiv Mohan Singh" on 03/02/17.
//  Copyright © 2017 Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    FIRST_SOURCE = 0,
    SECOND_SOURCE,
} SORUCE_TYPE;

@interface RA_ImageView : UIImageView
@property (assign, nonatomic) NSInteger sourceTable;
@end

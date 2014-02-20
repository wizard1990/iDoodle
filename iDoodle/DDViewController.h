//
//  DDViewController.h
//  iDoodle
//
//  Created by Yan Zhang on 12/17/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DDDoodleProtocal.h"

@class DDDoodleBoard;

@interface DDViewController : NSViewController <LockMouseDelegate, MovePenImageDelegate>

@property (nonatomic, strong) DDDoodleBoard* doodleBoard;

- (void)startDoodle;
- (void)stopDoodle;
- (void)clearContent;

@end
//
//  DDDoodleBoard.h
//  iDoodle
//
//  Created by Yan Zhang on 12/18/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DDDoodleProtocal.h"
#import "DDDoodleConst.h"

@interface DDDoodleBoard : NSView

@property (nonatomic, assign) StrokeColor strokeColor;
@property (nonatomic, assign) NSInteger strokeWidth;
@property (nonatomic, assign) NSInteger eraserWidth;
@property (nonatomic, weak) id<LockMouseDelegate> delegate;
@property (nonatomic, weak) id<MovePenImageDelegate> penDelegate;

- (void)clearContent;

@end
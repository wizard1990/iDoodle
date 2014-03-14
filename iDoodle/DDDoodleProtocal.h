//
//  DDDoodleProtocal.h
//  iDoodle
//
//  Created by Yan Zhang on 1/5/14.
//  Copyright (c) 2014 Yan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LockMouseDelegate <NSObject>

@required
- (void)lockMouseAtPoint: (NSPoint)point;

@end

@protocol MovePenImageDelegate <NSObject>

@required
- (void) setImageatPoint: (NSPoint) point;
- (void) hidePenImage;
- (void) unhidePenImage: (BOOL)isEraser;

@end
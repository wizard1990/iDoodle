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
- (void)lockMouseAtStartPoint;

@end

@protocol MovePenImageDelegate <NSObject>

@required
- (void) setPenImage: (NSView *)penView atPoint: (NSPoint) point;
- (void) hidePenImage: (NSView *)penView;
- (void) unhidePenImage: (NSView *)penView;

@end
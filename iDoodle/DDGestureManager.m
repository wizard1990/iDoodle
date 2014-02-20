//
//  DDGestureManager.m
//  iDoodle
//
//  Created by Yan Zhang on 12/17/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import "DDGestureManager.h"

@implementation DDGestureManager

static DDGestureManager *mInstance;

+(DDGestureManager *) sharedInstance
{
    @synchronized(self) {
        if(!mInstance) {
            mInstance = [[DDGestureManager alloc] init];
        }
    }
    return mInstance;
}

@end

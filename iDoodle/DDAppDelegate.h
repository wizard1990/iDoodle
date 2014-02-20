//
//  DDAppDelegate.h
//  iDoodle
//
//  Created by Yan Zhang on 12/17/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DDViewController;

@interface DDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) DDViewController* doodleView;

@end

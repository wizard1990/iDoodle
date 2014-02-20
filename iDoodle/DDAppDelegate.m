//
//  DDAppDelegate.m
//  iDoodle
//
//  Created by Yan Zhang on 12/17/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import "DDAppDelegate.h"
#import "DDViewController.h"

@implementation DDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.doodleView = [[DDViewController alloc] init];
    [self.window.contentView addSubview:self.doodleView.view];
    [self.window makeFirstResponder:(NSView *)self.doodleView.doodleBoard];
}

- (IBAction)doodle:(id)sender
{
    [self.doodleView startDoodle];
}

- (IBAction)unDoodle:(id)sender
{
    [self.doodleView stopDoodle];
}

- (IBAction)clearContent:(id)sender
{
    [self.doodleView clearContent];
}

@end

//
//  DDViewController.m
//  iDoodle
//
//  Created by Yan Zhang on 12/17/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import "DDViewController.h"
#import "DDDoodleBoard.h"
#import "DDGestureManager.h"

@interface DDViewController ()

@property (nonatomic, strong) NSImageView *penView;
@property (nonatomic, strong) NSImageView *eraserView;

@end

@implementation DDViewController
{
    double scale;
    BOOL isDoodle;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.doodleBoard = [[DDDoodleBoard alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))];
        self.doodleBoard.delegate = self;
        self.doodleBoard.penDelegate = self;
        scale = 1.0f;
        isDoodle = false;
        [self.view addSubview: self.doodleBoard];
        //[self.view.window makeFirstResponder:self.doodleBoard];
        
        _penView = [[NSImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        _eraserView = [[NSImageView alloc] initWithFrame:CGRectMake(100, 100, 32, 32)];
        _eraserView.image = [NSImage imageNamed:@"EraserCursor"];
        //[self.view addSubview:_eraserView];
        [_eraserView setHidden:YES];
        
        //todo:: add image
    }
    return self;
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

#pragma mark - User Actions
- (void)startDoodle
{
    if (!isDoodle) {
        [NSCursor hide];
        isDoodle = YES;
        [self.doodleBoard setAcceptsTouchEvents:YES];
    }
}

- (void)stopDoodle
{
    if (isDoodle) {
        [NSCursor unhide];
        isDoodle = NO;
        [self.doodleBoard setAcceptsTouchEvents:NO];
    }
}

- (void)clearContent
{
    if (isDoodle) {
        [self.doodleBoard clearContent];
    }
}

#pragma mark - Lock Mouse Delegate
- (void)lockMouseAtStartPoint
{
    NSRect frameRelativeToWindow = [self.view
                                    convertRect:self.view.bounds toView:nil
                                    ];
    NSPoint pointRelativeToScreen = [self.view.window
                                     convertRectToScreen:frameRelativeToWindow
                                     ].origin;
    
    NSPoint mouseWarpLocation = NSMakePoint(pointRelativeToScreen.x + 50, pointRelativeToScreen.y + 50);
    CGEventSourceRef evsrc = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    CGEventSourceSetLocalEventsSuppressionInterval(evsrc, 0.0);
    CGAssociateMouseAndMouseCursorPosition (0);
    CGWarpMouseCursorPosition(mouseWarpLocation);
    CGAssociateMouseAndMouseCursorPosition (1);
}

#pragma mark - Move Pen Delegate
- (void)setImageatPoint:(NSPoint)point
{
    [_eraserView setFrameOrigin:point];
}

- (void)hidePenImage
{
    [_eraserView setHidden:YES];
}

- (void)unhidePenImage: (BOOL)isEraser
{
    [_eraserView setHidden:NO];
}
@end

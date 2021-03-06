//
//  DDDoodleBoard.m
//  iDoodle
//
//  Created by Yan Zhang on 12/18/13.
//  Copyright (c) 2013 Yan Zhang. All rights reserved.
//

#import "DDDoodleBoard.h"

const NSUInteger DDLISTLIMIT = 512;

@implementation DDDoodleBoard
{
    NSMutableArray *pointsList;
    BOOL eraseFlag;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.strokeWidth = 2;
        self.eraserWidth = 6;
        self.strokeColor = BLACK;
        eraseFlag = NO;
        pointsList = [[NSMutableArray alloc] initWithCapacity:DDLISTLIMIT];
        [self clearContent];
    }
    return self;
}

- (BOOL)isOpaque
{
    return YES;
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)flagsChanged:(NSEvent *)theEvent
{
    BOOL pressed = ([theEvent modifierFlags] & NSCommandKeyMask) ==
    NSCommandKeyMask;
    if (pressed) {
        eraseFlag = YES;
    }
    else if (eraseFlag && [theEvent modifierFlags] == 256) {
        eraseFlag = NO;
    }
    [pointsList removeAllObjects];
}

#pragma mark - Drawing Methods
- (void)drawLineFrom:(CGPoint)start To:(CGPoint)end
{
    NSColor *color;
    switch (self.strokeColor) {
        case BLACK:
            color = [NSColor blackColor];
            break;
        case RED:
            color = [NSColor redColor];
            break;
        case GREEN:
            color = [NSColor greenColor];
        case BLUE:
            color = [NSColor blueColor];
            break;
        default:
            color = [NSColor blackColor];
            break;
    }
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path setLineWidth:self.strokeWidth];
    [path moveToPoint:start];
    [path lineToPoint:end];
    [color set];
    [path stroke];
}

- (void)drawLineFromPointsList
{
    NSColor *color;
    if (eraseFlag) {
        color = [NSColor whiteColor];
    }
    else {
        switch (self.strokeColor) {
            case BLACK:
                color = [NSColor blackColor];
                break;
            case RED:
                color = [NSColor redColor];
                break;
            case GREEN:
                color = [NSColor greenColor];
            case BLUE:
                color = [NSColor blueColor];
                break;
            default:
                color = [NSColor blackColor];
                break;
        }
    }
    NSBezierPath *path = [NSBezierPath bezierPath];
    if (eraseFlag) {
        [path setLineWidth:self.eraserWidth];
    }
    else {
        [path setLineWidth:self.strokeWidth];
    }
    [color set];
    
    [path moveToPoint:[[pointsList objectAtIndex:0] pointValue]];
    for (NSUInteger i = 1; i < [pointsList count]; i++) {
        [path lineToPoint:[[pointsList objectAtIndex:i] pointValue]];
    }
    [path stroke];
}

- (void)clearContent
{
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context, NSRectToCGRect(self.frame));
    [self setNeedsDisplay:YES];
}

#pragma mark - Touch Event Handling
- (void)touchesBeganWithEvent:(NSEvent *)event
{
    [NSCursor unhide];
    [pointsList removeAllObjects];
    NSSet *anyTouches = [event touchesMatchingPhase:NSTouchPhaseTouching inView:self];
    if ([anyTouches count] > 1) {
        return;
    }
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseBegan inView:self];
    if ([touches count] == 1) {
        NSTouch *touch = [touches anyObject];
        NSPoint startPoint = CGPointMake(self.frame.size.width*touch.normalizedPosition.x, self.frame.size.height*touch.normalizedPosition.y);
        [self.delegate lockMouseAtPoint:startPoint];
        [pointsList addObject:[NSValue valueWithPoint:startPoint]];
        [self.penDelegate setImageatPoint:startPoint];
        [self.penDelegate unhidePenImage:eraseFlag];
    }
}

- (void)touchesMovedWithEvent:(NSEvent *)event
{
    NSSet *anyTouches = [event touchesMatchingPhase:NSTouchPhaseTouching inView:self];
    if ([anyTouches count] > 1) {
        return;
    }
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseMoved inView:self];
    if ([touches count] == 1) {
        NSTouch *touch = [touches anyObject];
        CGPoint endPoint = CGPointMake(self.frame.size.width*touch.normalizedPosition.x, self.frame.size.height*touch.normalizedPosition.y);
        [self.delegate lockMouseAtPoint:endPoint];
        [pointsList addObject:[NSValue valueWithPoint:endPoint]];
        [self drawLineFromPointsList];
        if ([pointsList count] >= DDLISTLIMIT) {
            [pointsList removeAllObjects];
            [pointsList addObject:[NSValue valueWithPoint:endPoint]];
        }
        [self.penDelegate setImageatPoint:endPoint];
        [self setNeedsDisplay:YES];
    }
}

- (void)touchesEndedWithEvent:(NSEvent *)event
{
    [NSCursor hide];
    [self.delegate lockMouseAtPoint:CGPointMake(50, 50)];
    [pointsList removeAllObjects];
    [self.penDelegate hidePenImage];
}
@end

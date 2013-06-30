//
//  MFSliderControl.m
//  Piqueturs
//
//  Created by Mark Flowers on 6/29/13.
//  Copyright (c) 2013 Piqueturs LLC. All rights reserved.
//

#import "MFSliderControl.h"

@interface MFSliderControl()

@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic) BOOL moveSlider;

@end

@implementation MFSliderControl

- (id)initWithFrame:(CGRect)frame thumbImage:(UIImage*) thumbeImage range:(NSRange) range stepSize:(float) stepSize {
    self = [super initWithFrame:frame];
    if (self) {
        self.thumbImage = thumbeImage;
        self.range = range;
        self.step = stepSize;
        self.backgroundColor = [UIColor clearColor];
        self.trackColor = [UIColor whiteColor];
        _thumbImageView = [[UIImageView alloc] initWithImage:self.thumbImage];
        
        CGRect frame = CGRectMake(15.0f - (self.thumbImage.size.width / 2.0), (self.frame.size.height / 2) - (self.thumbImage.size.height / 2.0f) - 10.0f, fmaxf(self.thumbImage.size.width, 40.0f), fmaxf(self.thumbImage.size.height, 40.0f));
        
        _thumbImageView.contentMode = UIViewContentModeCenter;
        _thumbImageView.frame = frame;
        [self addSubview:_thumbImageView];
        
        UIPanGestureRecognizer *panner = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slid:)];
        [panner cancelsTouchesInView];
        [self addGestureRecognizer:panner];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
    
    CGContextSetLineWidth(context, 4.0);
    CGContextAddEllipseInRect(context, CGRectMake(13.0, (rect.size.height / 2.0) - 2.0, 4.0, 4.0));
    CGContextSetFillColorWithColor(context, self.trackColor.CGColor);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, 15.0, rect.size.height / 2.0);
    CGContextAddLineToPoint(context, rect.size.width - 15.0, rect.size.height / 2.0);
    CGContextStrokePath(context);
    
    int numberOfPoints = floorf(((self.range.location + self.range.length) - self.range.location) / self.step);
    float stepDistance = (rect.size.width - 30.0f) / numberOfPoints;
    
    for (int i = 1; i <= numberOfPoints; i++) {
        CGContextSetLineWidth(context, 4.0);
        CGContextAddEllipseInRect(context, CGRectMake(13.0 + (i * stepDistance), (rect.size.height / 2.0) - 2.0, 4.0, 4.0));
        CGContextSetFillColorWithColor(context, self.trackColor.CGColor);
        CGContextStrokePath(context);
    }
}

- (void) slid:(UIPanGestureRecognizer*) panner {
    if(panner.state == UIGestureRecognizerStateBegan) {
        if(CGRectContainsPoint(_thumbImageView.frame, [panner locationInView:self])) {
            _moveSlider = YES;
        } else {
            _moveSlider = NO;
        }
    } else if(panner.state == UIGestureRecognizerStateEnded) {
        _moveSlider = NO;
        
        int numberOfPoints = floorf(((self.range.location + self.range.length) - self.range.location) / self.step);
        float stepDistance = (self.frame.size.width - 30.0f) / numberOfPoints;
        
        float lowerStep = floorf(self.thumbImageView.frame.origin.x / stepDistance) * self.step;
        float delta = (self.thumbImageView.frame.origin.x /stepDistance) - lowerStep;
        
        if(delta >= self.step / 2) {
            self.value = lowerStep + self.step;
        } else {
            self.value = lowerStep;
        }
    } else {
        if(_moveSlider) {
            float xOffset = [panner locationInView:self].x;
            xOffset = fmaxf(-5.0f, xOffset);
            xOffset = fminf(self.frame.size.width - 35.0f, xOffset);
            _thumbImageView.frame = CGRectMake(xOffset, _thumbImageView.frame.origin.y, _thumbImageView.frame.size.width, _thumbImageView.frame.size.height);
        }
    }
}

- (void) setValue:(float)value {
    _value = value;
    
    int numberOfPoints = floorf(((self.range.location + self.range.length) - self.range.location) / self.step);
    float stepDistance = (self.frame.size.width - 30.0f) / numberOfPoints;
    
    float xOffset = value * stepDistance - (self.thumbImage.size.width / 4) + 1.0f;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.thumbImageView.frame = CGRectMake(xOffset, self.thumbImageView.frame.origin.y, self.thumbImageView.frame.size.width, self.thumbImageView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

@end

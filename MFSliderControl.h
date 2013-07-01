//
//  MFSliderControl.h
//  Piqueturs
//
//  Created by Mark Flowers on 6/29/13.
//  Copyright (c) 2013 Piqueturs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFSliderControl;

@protocol MFSliderControlDelegate <NSObject>

@required
- (void) slider:(MFSliderControl*) slider valueChanged:(float) value;

@end

@interface MFSliderControl : UIControl

@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic) NSRange range;
@property (nonatomic) float step;
@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic) float value;
@property (nonatomic, strong) id<MFSliderControlDelegate> delegate;

- (id)initWithFrame:(CGRect)framet thumbImage:(UIImage*) thumbeImage range:(NSRange) range stepSize:(float) stepSize;

@end

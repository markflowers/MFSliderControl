//
//  MFSliderControl.h
//  Piqueturs
//
//  Created by Mark Flowers on 6/29/13.
//  Copyright (c) 2013 Piqueturs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFSliderControl : UIControl

@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic) NSRange range;
@property (nonatomic) float step;
@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic) float value;

- (id)initWithFrame:(CGRect)framet thumbImage:(UIImage*) thumbeImage range:(NSRange) range stepSize:(float) stepSize;

@end

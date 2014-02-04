//
//  UUIconButton.m
//  Sustain
//
//  Created by Keri Anderson on 1/11/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import "UUIconButton.h"

@implementation UUIconButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/***
 *  This method allows the icon to be right adjusted
 *  in the view, with the label centered. 
 *
 */
- (void)layoutSubviews
{
    // Allow default layout, then adjust image and label positions
    [super layoutSubviews];
    
    CGRect buttonRect = self.frame;
    float buttonWidth = buttonRect.size.width;
    UIImageView *imageView = [self imageView];
    CGRect imageFrame = imageView.frame;
    float imageWidth = imageFrame.size.width;
    
        
    float difference = buttonWidth - imageWidth;
    imageFrame.origin.x = difference - imageWidth;
    
    imageView.frame = imageFrame;
    
    
    /*  Code used to create the above code
    // Allow default layout, then adjust image and label positions
    [super layoutSubviews];
    
    UIImageView *imageView = [self imageView];
    UILabel *label = [self titleLabel];
    
    CGRect imageFrame = imageView.frame;
    CGRect labelFrame = label.frame;
    
    labelFrame.origin.x = imageFrame.origin.x;
    imageFrame.origin.x = labelFrame.origin.x + CGRectGetWidth(labelFrame);
    
    imageView.frame = imageFrame;
    label.frame = labelFrame;
    */
}

@end

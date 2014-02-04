//
//  UUProfileView.m
//  Sustain
//
//  Created by Keri Anderson on 11/11/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUProfileView.h"

@implementation UUProfileView

@synthesize profileViewDelegate;


- (id)initWithProgramConstants:(UUProgramConstants*)programConstants andProfileImage:(UIImage*)profileImage
{
    self = [super init];
    if (self)
    {
        // Initialization code
        //create a weak reference to the program constants
        _programConstants = programConstants;
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[programConstants getBackgroundImage]]];
        
        _profileImage = profileImage;
        
        // create the buttons and labels
        _profileImageView = [[UIImageView alloc]initWithImage:_profileImage];
        
        
        
        _updateProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // set the text properties
        [_updateProfileButton  setTitle:@"Update Profile" forState:UIControlStateNormal];
        [_updateProfileButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_updateProfileButton  setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_updateProfileButton.titleLabel setFont:[_programConstants getBoldFontWithSize:20.0]];
        //signUpButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);  // see 'important note' above
        [_updateProfileButton setBackgroundImage:[[UIImage imageNamed:@"grayButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [_updateProfileButton setBackgroundImage:[[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
        // set the delegate for the button to be the CreateUserViewController - we want the controller to
        // handle events
        [_updateProfileButton addTarget: profileViewDelegate
                          action:@selector(updateProfileButtonWasPressed)
                forControlEvents:UIControlEventTouchDown];

        [self addSubview:_profileImageView];
        [self addSubview:_updateProfileButton];
        
        
    }
    return self;
}//end constructor

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


/**************************************************************************************************
 *
 *                          layout subviews
 *
 **************************************************************************************************/
#pragma - mark layoutSubviews
/***
 *  In the layout subviews, we need to access the original frame, and then do a bunch
 *  of math to properly create the frames for all of the subviews
 *
 */
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    
    
    // Get the bounds of the current view. We will use this to dynamically calculate the frames of our subviews
    CGRect bounds = [self bounds];
    
    // We want the background image to show up, so we need to adjust the width and height of the rectangles accordingly.
    // We can get a width adjustment immediately.
    //
    // The following notes are FYI to explain how CGRectInset works:
    // create the rectangles so that they are a bit smaller (showing more background) and
    // centered on the same point  (using CGRectInset)
    //  CGRectInsetParameters:
    //        rect:  The source CGRect structure.
    //          dx:  The x-coordinate value to use for adjusting the source rectangle.
    //               To create an inset rectangle, specify a positive value. To create a larger,
    //               encompassing rectangle, specify a negative value.
    //          dy:  The y-coordinate value to use for adjusting the source rectangle.
    //               To create an inset rectangle, specify a positive value. To create a larger,
    //               encompassing rectangle, specify a negative value.
    
    CGFloat boundsInset = bounds.size.width * 0.10; // take off a percentage of the width
    bounds = CGRectInset(bounds, boundsInset, boundsInset);
    
    // the specific rects that will be used for subviews
    CGRect profileImageViewRect;    // this will hold the profile image
    CGRect updateProfileButtonRect; // holds the updateProfile button
    
    
      
    CGRectDivide(bounds, &profileImageViewRect, &updateProfileButtonRect, bounds.size.height/ 2.0, CGRectMinYEdge);

     
    
    
    
    // set the frames
    [_profileImageView    setFrame:profileImageViewRect];
    [_updateProfileButton setFrame:updateProfileButtonRect];
    
    
    
}// end layout subviews

- (void) updateDisplayValues:(NSMutableDictionary*)displayDictionary
{
    UIImage* newImage = [displayDictionary objectForKey:@"profileImage"];
    
    _profileImageView.image = newImage;
    
    [self setNeedsDisplay];
}

@end

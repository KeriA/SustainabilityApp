//
//  UUChallengeView.m
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUChallengeView.h"


@interface UUChallengeView ()
{
    UIButton *_challengeButton;
    UIPickerView* _pickerView;
    UILabel* _challengeLabel;
}

@end


@implementation UUChallengeView


/******
 *
 *  Constructor
 *
 *  This constructor takes in the month (as an int) so that the correct
 *  image and caption will be displayed in the main challenge button.
 *
 *
 */
- (id) initWithProgramConstants: (UUProgramConstants*)programConstants andMonth: (int)month
{
    self = [super init];
    if (self) {
        
        //_model = model;
        _programConstants = programConstants;
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[_programConstants getBackgroundImage]]];
        [self setUserInteractionEnabled:TRUE];
        
        UIImage* currentMonthImage = [_programConstants getCurrentMonthImage: month];
        
        _challengeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _challengeButton.backgroundColor = [UIColor clearColor];
        [_challengeButton setImage:currentMonthImage forState:UIControlStateNormal];
        [_challengeButton addTarget:self
                   action:@selector(challengeButtonWasTapped:)
         forControlEvents:UIControlEventTouchDown];
        
        _challengeLabel = [[UILabel alloc]init];
        [_challengeLabel setBackgroundColor:[UIColor clearColor]];
        [_challengeLabel setText:[_programConstants getCurrentMonthCaption:month]];
        [_challengeLabel setTextColor:[UIColor whiteColor]];
        [_challengeLabel setFont:[_programConstants getBoldFontWithSize:17.0]];
        [_challengeLabel setTextAlignment:NSTextAlignmentCenter];
        
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_challengeButton];
        [self addSubview:_challengeLabel];
        [self addSubview:_pickerView];
        
    }
    return self;
}// end constructor

/*****************************************************************************************************************
 *
 *                              Set Delegates
 *
 *****************************************************************************************************************/

 - (void) setPickerDataSource:(id<UIPickerViewDataSource>)pickerDataSource
 {
     [_pickerView setDataSource:pickerDataSource];
 }
 - (id<UIPickerViewDataSource>)pickerDataSource
 {
     return [_pickerView dataSource];
 }
 
 - (void) setPickerDelegate:(id<UIPickerViewDelegate>)pickerDelegate
 {
     [_pickerView setDelegate:pickerDelegate];
 }
 - (id<UIPickerViewDelegate>)pickerDelegate
 {
     return [_pickerView delegate];
 }
 
/*****************************************************************************************************************
 *
 *                              Layout Subviews
 *
 *****************************************************************************************************************/
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // Get the bounds of the current view. We will use this to dynamically calculate the frames of our subviews
    CGRect bounds = [self bounds];
    CGRect insetBounds;
    
    // the specific rects that will be used for subviews
    CGRect challengeButtonRect;
    CGRect challengeLabelRect;
    CGRect pickerRect;

    
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
    
    CGFloat inset = bounds.size.width * 0.05; // take off a percentage of the width
    insetBounds = CGRectInset(bounds, inset, inset);

    //Now divide the bounds rect amongst all of the sub-rects
    // Notes on using CGRectDivide
    //    Parameters:
    //               rect:        the original rect to divide up
    //               slice:       the first slice that will be created - needs ADDRESS of rect
    //               remainder:   the remainder of the original rect will be placed in this rect  (use ADDRESS of rect)
    //               amount:      the float amount of how much to put in the first rect
    //               edge:        which edge to measure from
    //                           CGRectMinYEdge  :  will measuer from the top
    //                           CGRectMinXEdge  :  will measure from the left
    //                           CGRectMaxYedge  :  will measure from the bottom
    //                           CGRectMaxXedge  :  will measure from the right
    //
    // original rect, 1st slice,      remainder,   how much to put in slice, which edge to measure from
    CGRectDivide(insetBounds, &challengeButtonRect, &pickerRect, insetBounds.size.height/ 2.0, CGRectMinYEdge);
    CGRectDivide(challengeButtonRect, &challengeLabelRect, &challengeButtonRect, challengeButtonRect.size.height/4.0, CGRectMaxYEdge);
    // shrink the height of the challenge label rect a bit
    
    float newChallengeLabelRectY = challengeButtonRect.origin.y + challengeButtonRect.size.height;
    //challengeLabelRect = CGRectInset(challengeLabelRect, 0, 20.0);
    
    // move it up
    challengeLabelRect.origin.y = newChallengeLabelRectY;
    
    
    
    // make sure that the challenge button frame is square so that the image will show nicely
    if (challengeButtonRect.size.width > challengeButtonRect.size.height)
    {
        challengeButtonRect.size.width = challengeButtonRect.size.height;
    }
    else
    {
        challengeButtonRect.size.height = challengeButtonRect.size.width;
    }
    
                // and re-center
    float difference = bounds.size.width - challengeButtonRect.size.width;
    difference = difference/2.0;
    challengeButtonRect.origin.x = difference;

    

    
    
    // set the frames
    [_challengeButton setFrame:CGRectIntegral(challengeButtonRect)];
    [_challengeLabel  setFrame:CGRectIntegral(challengeLabelRect)];
    [_pickerView      setFrame:CGRectIntegral(pickerRect)];
    
    
    
}// end layoutSubviews

#pragma mark - IBActions
- (IBAction)challengeButtonWasTapped:(id)sender
{
    [self.delegate challengeButtonWasTapped:sender];
}

@end

//
//  UUTeamCategoriesView.m
//  Sustain
//
//  Created by Keri Anderson on 1/8/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import "UUTeamCategoriesView.h"

@interface UUTeamCategoriesView ()
{
    UUIconButton* _schoolsButton;
    UUIconButton* _businessesButton;
    UUIconButton* _otherButton;
    UIButton* _requestTeamButton;
    
    UUPickerContainerView* _pickerView;
    
}

@end

@implementation UUTeamCategoriesView

@synthesize teamCategoriesViewDelegate;


- (id)initWithProgramConstants:(UUProgramConstants*)programConstants
{
    self = [super init];
    if (self) {
        
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithPatternImage:[programConstants getBackgroundImage]]];
        _programConstants = programConstants;
        
        UIImage* _downImage = [UIImage imageNamed:@"inverted_triangle.png"];
        
        _schoolsButton = [[UUIconButton alloc]init]; //don't use rounded rect here - it moves the triangle icon
        // set the text properties
        [_schoolsButton  setTitle:@"SCHOOLS" forState:UIControlStateNormal];
        [_schoolsButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_schoolsButton  setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _schoolsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_schoolsButton.titleLabel setFont:[_programConstants getBoldFontWithSize:20.0]];
        [_schoolsButton setBackgroundImage:[[UIImage imageNamed:@"grayButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [_schoolsButton setBackgroundImage:[[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
        [_schoolsButton setImage:_downImage forState:UIControlStateNormal];
        // let the view controller handle events
        [_schoolsButton addTarget: teamCategoriesViewDelegate
                          action:@selector(schoolsButtonWasPressed)
                forControlEvents:UIControlEventTouchDown];
        
        
        _businessesButton = [[UUIconButton alloc]init];
        // set the text properties
        [_businessesButton  setTitle:@"BUSINESSES" forState:UIControlStateNormal];
        [_businessesButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_businessesButton  setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _businessesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_businessesButton.titleLabel setFont:[_programConstants getBoldFontWithSize:20.0]];
        [_businessesButton setBackgroundImage:[[UIImage imageNamed:@"grayButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [_businessesButton setBackgroundImage:[[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
        [_businessesButton setImage:_downImage forState:UIControlStateNormal];
        // let the view controller handle events
        [_businessesButton addTarget: teamCategoriesViewDelegate
                           action:@selector(businessesButtonWasPressed)
                 forControlEvents:UIControlEventTouchDown];

 
        _otherButton = [[UUIconButton alloc]init];
        // set the text properties
        [_otherButton  setTitle:@"OTHER" forState:UIControlStateNormal];
        [_otherButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_otherButton  setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _otherButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_otherButton.titleLabel setFont:[_programConstants getBoldFontWithSize:20.0]];
        [_otherButton setBackgroundImage:[[UIImage imageNamed:@"grayButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [_otherButton setBackgroundImage:[[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
        [_otherButton setImage:_downImage forState:UIControlStateNormal];
        // let the view controller handle events
        [_otherButton addTarget: teamCategoriesViewDelegate
                           action:@selector(otherButtonWasPressed)
                 forControlEvents:UIControlEventTouchDown];

  
        
        _requestTeamButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // set the text properties
        _requestTeamButton.backgroundColor = [UIColor clearColor];
        //[_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[_signUpButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted]; //when pressed
        CALayer* theLayer = [_requestTeamButton layer];  //note:  must #import <QuartzCore/QuartzCore.h> to access
        [theLayer setMasksToBounds:YES];
        [theLayer setCornerRadius: 6.0];
        [theLayer setBorderWidth: 0.0];// we want this button to look like a link, so no border
        [theLayer setBorderColor:[UIColor clearColor].CGColor];
        // This button needs to look like a link - with underlined text - use NSAttributed String
        NSDictionary* underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [_programConstants getStandardFontWithSize:16]};
        NSDictionary* selectedAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle), NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [_programConstants getStandardFontWithSize:16]};
        NSAttributedString* attString = [[NSAttributedString alloc] initWithString:@"Request New Team" attributes:underlineAttribute];
        NSAttributedString* selString = [[NSAttributedString alloc] initWithString:@"Request New Team" attributes:selectedAttribute];
        [_requestTeamButton   setAttributedTitle:attString forState:UIControlStateNormal];
        [_requestTeamButton   setAttributedTitle:selString forState:UIControlStateHighlighted];

        // set the delegate for the button to be the SignInViewControllers
        [_requestTeamButton addTarget: teamCategoriesViewDelegate
                          action:@selector(requestNewTeamButtonWasPressed)
                forControlEvents:UIControlEventTouchDown];

        
        _pickerView = [[UUPickerContainerView alloc]init];
        
        
        
        [self addSubview:_schoolsButton];
        [self addSubview:_businessesButton];
        [self addSubview:_otherButton];
        [self addSubview:_requestTeamButton];
        [self addSubview:_pickerView];
        
        
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
    CGRect schoolsButtonRect;
    CGRect businessesButtonRect;
    CGRect otherButtonRect;
    CGRect requestNewTeamRect;
    CGRect pickerRect;
    
    // rects used for spacing
    CGRect spacerRect;
     
    
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
    
    CGFloat inset = bounds.size.width * 0.15; // take off a percentage of the width
    insetBounds = CGRectInset(bounds, inset, inset);
    
    //Create the pickerview rect here   - start with it off the screen
    float pickerX = bounds.origin.x;
    float pickerWidth = bounds.size.width;
    //cast to an int to drop the floating points - otherwise "layout subviews" is triggered,
    // and the view is moved off screen again
    float pickerHeight =(int) (bounds.size.height * (2.0/3.0));
    //float pickerY = bounds.origin.y + (bounds.size.height - pickerHeight);
    float pickerY = bounds.origin.y + bounds.size.height + 1.0; //start with it off the screen
    
    
    pickerRect = CGRectMake(pickerX, pickerY, pickerWidth, pickerHeight);
    //NSLog(@"IN THE BEGINNING: pickerX = %f, pickerY = %f, pickerWidth = %f, pickerHeight = %f\n", pickerX, pickerY, pickerWidth, pickerHeight);

    
    /*pickerRect.size.width = bounds.size.width;
    pickerRect.size.height = bounds.size.height / 2.0;
    pickerRect.origin.x = bounds.origin.x;
    pickerRect.origin.y = bounds.origin.y + (bounds.size.height + 1.0); */
    
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
    
    CGRectDivide(insetBounds, &schoolsButtonRect, &businessesButtonRect, insetBounds.size.height/ 4.0, CGRectMinYEdge);
    CGRectDivide(businessesButtonRect, &businessesButtonRect, &otherButtonRect, businessesButtonRect.size.height/ 3.0, CGRectMinYEdge);
    CGRectDivide(otherButtonRect, &otherButtonRect, &spacerRect, otherButtonRect.size.height/ 2.0, CGRectMinYEdge);
    
    CGRectDivide(spacerRect, &spacerRect, &requestNewTeamRect, spacerRect.size.height/ 1.5, CGRectMinYEdge);
    
    // shrink the height of the rects a bit to give space between buttons
    float shrinkAmount = .15;
    schoolsButtonRect = CGRectInset(schoolsButtonRect, 0, schoolsButtonRect.size.height * shrinkAmount);
    businessesButtonRect = CGRectInset(businessesButtonRect, 0, businessesButtonRect.size.height * shrinkAmount);
    otherButtonRect = CGRectInset(otherButtonRect, 0, otherButtonRect.size.height * shrinkAmount);
    requestNewTeamRect = CGRectInset(requestNewTeamRect, 0, requestNewTeamRect.size.height * shrinkAmount);
    
          
    
    // set the frames
    [_schoolsButton     setFrame:CGRectIntegral(schoolsButtonRect)];
    [_businessesButton  setFrame:CGRectIntegral(businessesButtonRect)];
    [_otherButton       setFrame:CGRectIntegral(otherButtonRect)];
    [_requestTeamButton setFrame:CGRectIntegral(requestNewTeamRect)];
    [_pickerView        setFrame:CGRectIntegral(pickerRect)];

    
    
    
}// end layoutSubviews

/**************************************************************************************************
 *
 *                          Animate showing/hiding picker view
 *
 **************************************************************************************************/
-(void) showPickerView
{
    //disable the buttons
    _schoolsButton.enabled = FALSE;
    _businessesButton.enabled = FALSE;
    _otherButton.enabled = FALSE;
    _requestTeamButton.enabled = FALSE;
    
    //tell the app we are making animation - "showing the picker is arbitrary
    [UIView beginAnimations:@"showing the picker" context:nil];
    //set the delegate to self - otherwise the delegate method wont be called
    [UIView setAnimationDelegate:self];
    //set the animation length in seconds  Apple typically uses .3
    [UIView setAnimationDuration:.30];
    
    //this line specifies the animation
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    
    // just before calling commitAnimations below, you write the code to make the changes of the    
    // imageview and XCode will do the rest. It is that simple.
    // In this case, we are setting the frame for the picker view
    //Create the pickerview rect here   - start with it off the screen
    CGRect bounds = [self bounds];
    float pickerX = bounds.origin.x;
    float pickerWidth = bounds.size.width;
    //cast to an int to drop the floating points - otherwise "layout subviews" is triggered,
    // and the view is moved off screen again
    float pickerHeight = (int)(bounds.size.height * (2.0/3.0));
    float pickerY = bounds.origin.y + (bounds.size.height - pickerHeight);

    
    
    //float pickerY = bounds.origin.y + bounds.size.height + 1.0; //start with it off the screen
    _pickerView.frame = CGRectMake(pickerX, pickerY, pickerWidth, pickerHeight);
    //NSLog(@"pickerX = %f, pickerY = %f, pickerWidth = %f, pickerHeight = %f", pickerX, pickerY, pickerWidth, pickerHeight);

    [UIView commitAnimations];
    
}

-(void) hidePickerView
{
    
    //enable the buttons
    _schoolsButton.enabled = TRUE;
    _businessesButton.enabled = TRUE;
    _otherButton.enabled = TRUE;
    _requestTeamButton.enabled = TRUE;
    
    //tell the app we are making animation - "showing the picker is arbitrary
    [UIView beginAnimations:@"hiding the picker" context:nil];
    //set the delegate to self - otherwise the delegate method wont be called
    [UIView setAnimationDelegate:self];
    //set the animation length in seconds  Apple typically uses .3
    [UIView setAnimationDuration:.30];
    
    //this line specifies the animation
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    
    // just before calling commitAnimations below, you write the code to make the changes of the
    // imageview and XCode will do the rest. It is that simple.
    // In this case, we are setting the frame for the picker view
    CGRect bounds = [self bounds];
    float pickerX = bounds.origin.x;
    float pickerWidth = bounds.size.width;
    //cast to an int to drop the floating points - otherwise "layout subviews" is triggered,
    // and the view is moved off screen again
    float pickerHeight =(int) (bounds.size.height * (2.0/3.0));
    //float pickerY = bounds.origin.y + (bounds.size.height - pickerHeight);
    float pickerY = bounds.origin.y + bounds.size.height + 1.0; //start with it off the screen
    
    _pickerView.frame = CGRectMake(pickerX, pickerY, pickerWidth, pickerHeight);
    
    
    [UIView commitAnimations];
    
}

/**************************************************************************************************
 *
 *                         call reload for picker elements
 *
 **************************************************************************************************/
-(void) pickerViewReloadData
{
    [_pickerView reloadPickerData];
}


/**************************************************************************************************
 *
 *                          Set delegate for the subviews
 *
 **************************************************************************************************/
#pragma - mark setSubviewDelegates
/***
 *  This method is used for easy access to the subviews by the controller.
 *  The method is called by the controller in the 'view did load' method
 *
 */
-(void) setSubViewDelegates:(id)delegate
{
    [_pickerView setSubViewDelegates:delegate];
    
}// end set delegates


@end

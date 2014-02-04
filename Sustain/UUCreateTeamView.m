//
//  UUCreateTeamView.m
//  Sustain
//
//  Created by Keri Anderson on 1/12/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import "UUCreateTeamView.h"



@implementation UUCreateTeamView
{
    UILabel* _requestLabel;
    UILabel* _teamLabel;
    UILabel* _schoolLabel;
    UILabel* _businessLabel;
    UILabel* _otherLabel;
    
    UIButton* _schoolButton;
    UIButton* _businessButton;
    UIButton* _otherButton;
    UIButton* _submitButton;
    
    UIImage* _checkedImage;
    UIImage* _unCheckedImage;
    
    UITextField* _teamNameTextField;
    
    UIAlertView* _alertView;

}

@synthesize createTeamViewDelegate;


- (id)initWithProgramConstants:(UUProgramConstants*)programConstants
{
    self = [super init];
    if (self) {
        
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithPatternImage:[programConstants getBackgroundImage]]];
        //[self setBackgroundColor:[UIColor purpleColor]]; //for testing
        
        _programConstants = programConstants;
        
        //load the images
        _checkedImage   = [UIImage imageNamed:@"checkbox_full.ico"];
        _unCheckedImage = [UIImage imageNamed:@"checkbox_empty.ico"];
        
        //main label
        _requestLabel = [[UILabel alloc] init];
        [_requestLabel setBackgroundColor:[UIColor clearColor]];
        [_requestLabel setText:@"REQUEST"];
        [_requestLabel setTextColor:[UIColor whiteColor]];
        [_requestLabel setFont:[_programConstants getStandardFontWithSize:30.0]];
        [_requestLabel setTextAlignment:NSTextAlignmentCenter];
        
        _teamLabel = [[UILabel alloc] init];
        [_teamLabel setBackgroundColor:[UIColor clearColor]];
        [_teamLabel setText:@"TEAM"];
        [_teamLabel setTextColor:[UIColor whiteColor]];
        [_teamLabel setFont:[_programConstants getStandardFontWithSize:30.0]];
        [_teamLabel setTextAlignment:NSTextAlignmentCenter];
        

        
        //text field
        // create the textfields and set its delegates
        _teamNameTextField = [[UITextField alloc] init];
        _teamNameTextField.placeholder = @"Team Name";
        _teamNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _teamNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _teamNameTextField.backgroundColor = [UIColor whiteColor];
        _teamNameTextField.font = [programConstants getStandardFontWithSize:20.0];
        _teamNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _teamNameTextField.keyboardType = UIKeyboardTypeDefault;
        _teamNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _teamNameTextField.returnKeyType = UIReturnKeyDone;
        _teamNameTextField.textAlignment = NSTextAlignmentLeft;
        _teamNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _teamNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //Note:  must import <QuartzCore/QuartzCore.h> so that the layer property is visible
        _teamNameTextField.layer.borderWidth = 0.0;
        
        
        
        //buttons and button labels
        _schoolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _schoolButton.backgroundColor = [UIColor clearColor];
        [_schoolButton setImage:_unCheckedImage forState:UIControlStateNormal];
        [_schoolButton addTarget:createTeamViewDelegate
                          action:@selector(schoolButtonWasPressed)
                   forControlEvents:UIControlEventTouchDown];
        
        _businessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _businessButton.backgroundColor = [UIColor clearColor];
        [_businessButton setImage:_unCheckedImage forState:UIControlStateNormal];
        [_businessButton addTarget:createTeamViewDelegate
                          action:@selector(businessButtonWasPressed)
                forControlEvents:UIControlEventTouchDown];
        
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _otherButton.backgroundColor = [UIColor clearColor];
        [_otherButton setImage:_unCheckedImage forState:UIControlStateNormal];
        [_otherButton addTarget:createTeamViewDelegate
                          action:@selector(otherButtonWasPressed)
                forControlEvents:UIControlEventTouchDown];
        

        _schoolLabel = [[UILabel alloc] init];
        [_schoolLabel setBackgroundColor:[UIColor clearColor]];
        [_schoolLabel setText:@"School"];
        [_schoolLabel setTextColor:[UIColor whiteColor]];
        [_schoolLabel setFont:[_programConstants getStandardFontWithSize:15.0]];
        [_schoolLabel setTextAlignment:NSTextAlignmentCenter];
        
        _businessLabel = [[UILabel alloc] init];
        [_businessLabel setBackgroundColor:[UIColor clearColor]];
        [_businessLabel setText:@"Business"];
        [_businessLabel setTextColor:[UIColor whiteColor]];
        [_businessLabel setFont:[_programConstants getStandardFontWithSize:15.0]];
        [_businessLabel setTextAlignment:NSTextAlignmentCenter];
        
        _otherLabel = [[UILabel alloc] init];
        [_otherLabel setBackgroundColor:[UIColor clearColor]];
        [_otherLabel setText:@"Other"];
        [_otherLabel setTextColor:[UIColor whiteColor]];
        [_otherLabel setFont:[_programConstants getStandardFontWithSize:15.0]];
        [_otherLabel setTextAlignment:NSTextAlignmentCenter];
        

        //submit button
        _submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        // set the text properties
        [_submitButton  setTitle:@"Submit Request" forState:UIControlStateNormal];
        [_submitButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_submitButton  setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_submitButton.titleLabel setFont:[_programConstants getBoldFontWithSize:20.0]];
        [_submitButton setBackgroundImage:[[UIImage imageNamed:@"grayButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [_submitButton setBackgroundImage:[[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
        // set the delegate for the button to be the CreateUserViewController - we want the controller to
        // handle events
        [_submitButton addTarget: createTeamViewDelegate
                               action:@selector(submitButtonWasPressed)
                     forControlEvents:UIControlEventTouchDown];

        
        //used to ensure the team name and team type are selected before sending an email
        _alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:createTeamViewDelegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        
        
        [self addSubview:_requestLabel];
        [self addSubview:_teamLabel];
        [self addSubview:_schoolLabel];
        [self addSubview:_businessLabel];
        [self addSubview:_otherLabel];
        [self addSubview:_schoolButton];
        [self addSubview:_businessButton];
        [self addSubview:_otherButton];
        [self addSubview:_submitButton];
        [self addSubview:_teamNameTextField];
        
        
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
    CGRect requestLabelrect;
    CGRect teamLabelrect;
    CGRect schoolLabelrect;
    CGRect businessLabelrect;
    CGRect otherLabelrect;
    
    CGRect schoolButtonrect;
    CGRect businessButtonrect;
    CGRect otherButtonrect;
    CGRect submitButtonrect;
    
    CGRect teamNameTextFieldrect;
    
    //helper rects - to help distribut the other rects
    CGRect topLabelRect;
    CGRect buttonsRect;
    CGRect buttonsLabelsRect;
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
    
    CGFloat inset = bounds.size.width * 0.10; // take off a percentage of the width
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
    
    //REQUEST TEAMS LABEL
    CGRectDivide(insetBounds, &topLabelRect, &teamNameTextFieldrect, insetBounds.size.height/ 3.5, CGRectMinYEdge);
    float topLabelShrinkAmount = .15;
    topLabelRect = CGRectInset(topLabelRect, 0, topLabelRect.size.height * topLabelShrinkAmount);
    CGRectDivide(topLabelRect, &requestLabelrect, &teamLabelrect, topLabelRect.size.height/ 2.0, CGRectMinYEdge);
    
    //TEAM NAME TEXT FIELD
    CGRectDivide(teamNameTextFieldrect, &teamNameTextFieldrect, &buttonsRect, teamNameTextFieldrect.size.height/ 3.0, CGRectMinYEdge);
    float textFieldShrinkAmount = .20; //shrink the size of the text field window a bit
    teamNameTextFieldrect = CGRectInset(teamNameTextFieldrect, 0, teamNameTextFieldrect.size.height * textFieldShrinkAmount);
    
    //SCHOOL/BUSINESS/OTHER check buttons
    CGRectDivide(buttonsRect, &buttonsRect, &spacerRect, buttonsRect.size.height/ 2.0, CGRectMinYEdge);
    
    float buttonsRectShrinkAmount = .10;
    buttonsRect = CGRectInset(buttonsRect, 0, buttonsRect.size.height * buttonsRectShrinkAmount);
    CGRectDivide(buttonsRect, &buttonsRect, &buttonsLabelsRect, buttonsRect.size.height/ 2.0, CGRectMinYEdge);
    CGRectDivide(buttonsRect, &schoolButtonrect, &businessButtonrect, buttonsRect.size.width/ 3.0, CGRectMinXEdge);
    CGRectDivide(businessButtonrect, &businessButtonrect, &otherButtonrect, businessButtonrect.size.width/ 2.0, CGRectMinXEdge);
    CGRectDivide(buttonsLabelsRect, &schoolLabelrect, &businessLabelrect, buttonsLabelsRect.size.width/ 3.0, CGRectMinXEdge);
    CGRectDivide(businessLabelrect, &businessLabelrect, &otherLabelrect, businessLabelrect.size.width/ 2.0, CGRectMinXEdge);
    
    //SUBMIT BUTTON
    CGRectDivide(spacerRect, &spacerRect, &submitButtonrect, spacerRect.size.height/3.0, CGRectMinYEdge);
    
    
    
    
    
    // shrink the height of the rects a bit to give space between buttons
    //float shrinkAmount = .15;
    //schoolsButtonRect = CGRectInset(schoolsButtonRect, 0, schoolsButtonRect.size.height * shrinkAmount);
    //businessesButtonRect = CGRectInset(businessesButtonRect, 0, businessesButtonRect.size.height * shrinkAmount);
    //otherButtonRect = CGRectInset(otherButtonRect, 0, otherButtonRect.size.height * shrinkAmount);
    //requestNewTeamRect = CGRectInset(requestNewTeamRect, 0, requestNewTeamRect.size.height * shrinkAmount);
    
    
    
    // set the frames
    [_requestLabel   setFrame:CGRectIntegral(requestLabelrect)];
    [_teamLabel      setFrame:CGRectIntegral(teamLabelrect)];
    [_schoolLabel    setFrame:CGRectIntegral(schoolLabelrect)];
    [_businessLabel  setFrame:CGRectIntegral(businessLabelrect)];
    [_otherLabel     setFrame:CGRectIntegral(otherLabelrect)];
    
    [_schoolButton   setFrame:CGRectIntegral(schoolButtonrect)];
    [_businessButton setFrame:CGRectIntegral(businessButtonrect)];
    [_otherButton    setFrame:CGRectIntegral(otherButtonrect)];
    [_submitButton   setFrame:CGRectIntegral(submitButtonrect)];

    [_teamNameTextField  setFrame:teamNameTextFieldrect];   
    
    
}// end layoutSubviews

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
    
    [_teamNameTextField setDelegate:delegate];
    
}// end set delegates

/**************************************************************************************************
 *
 *                          Accessor Methods
 *
 **************************************************************************************************/
- (void) checkSchoolButton
{
    [_schoolButton setImage:_checkedImage forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void) unCheckSchoolButton
{
    [_schoolButton setImage:_unCheckedImage forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void) checkBusinessButton
{
    [_businessButton setImage:_checkedImage forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void) unCheckBusinessButton
{
    [_businessButton setImage:_unCheckedImage forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void) checkOtherButton
{
    [_otherButton setImage:_checkedImage forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void) unCheckOtherButton
{
    [_otherButton setImage:_unCheckedImage forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void) showAlertWithMessage: (NSString*) message
{
    
    [_alertView setMessage:message];
    
    [_alertView show];
    
}//end showAlert

- (void) setTextFieldFocus
{
    _teamNameTextField.text = @"";
    [_teamNameTextField becomeFirstResponder];
}

@end

//
//  UUCreateTeamViewController.m
//  Sustain
//
//  Created by Keri Anderson on 1/12/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import "UUCreateTeamViewController.h"

@interface UUCreateTeamViewController ()

@end


@implementation UUCreateTeamViewController
{
    NSString* _newTeamName;
    NSString* _newTeamType;
}

/***
 *
 *      Constructor:  create a weak reference to the model
 */
- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
        //create a weak reference to the model
        _model = model;
        
        //create a weak reference to the program constants
        _programConstants = programConstants;
        
        //set self as the delegate for request new team responses
        [_model setResponseForRequestNewTeamReceivedDelegate:self];
        
        // initialize the new Team name and type
        _newTeamName = @"";
        _newTeamType = @"";
        
    }
    return self;
    
}// end contstructor

/********************************************************************************************************
 *
 *      UIView Controller Overrides
 *
 ********************************************************************************************************/

/***
 *  Add the 'loadView' method and create a table view here.
 *  Recall, the 'Grouped' style gives the pin-striped background
 *
 */
- (void) loadView
{
    self.view = [[UUCreateTeamView alloc] initWithProgramConstants:_programConstants];
    
    
    
}// end loadView

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"NEW TEAM";
    // with iOS5 the navigation bar now has title text attributes set with a dictionary
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
} // end viewWillAppear

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    // set the view's delegate to self (this controller)
    [(UUCreateTeamView*)self.view setCreateTeamViewDelegate:self];
    
    // set the subviews' delegates to self (this controller)
    [(UUCreateTeamView*)self.view setSubViewDelegates:self];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**********************************************************************************************************
 *
 *                                   UUCreateTeamViewDelegate Methods
 *
 **********************************************************************************************************/
#pragma - mark UICreateTeamViewDelegate Methods
-(void) schoolButtonWasPressed
{
    //NSLog(@"schools Button was pressed\n");
    [(UUCreateTeamView*)self.view checkSchoolButton];
    [(UUCreateTeamView*)self.view unCheckBusinessButton];
    [(UUCreateTeamView*)self.view unCheckOtherButton];
    
    _newTeamType = @"SCHOOL";
    
}

-(void) businessButtonWasPressed
{
    //NSLog(@"business Button was pressed\n");
    [(UUCreateTeamView*)self.view checkBusinessButton];
    [(UUCreateTeamView*)self.view unCheckSchoolButton];
    [(UUCreateTeamView*)self.view unCheckOtherButton];
    
    _newTeamType = @"BUSINESS";
}

-(void) otherButtonWasPressed
{
    //NSLog(@"other Button was pressed\n");
    [(UUCreateTeamView*)self.view checkOtherButton];
    [(UUCreateTeamView*)self.view unCheckBusinessButton];
    [(UUCreateTeamView*)self.view unCheckSchoolButton];
    
    _newTeamType = @"OTHER";
}


/***
 * This method first checks to see if data fields were filled in correctly,
 * and then has the model send off an email with the new team request
 *
 */
-(void) submitButtonWasPressed
{
    //NSLog(@"submit Button was pressed\n");
    
    //first check to see if the team name has been filled in
    _newTeamName = [self cleanDisplayName:_newTeamName];
    
    if ([self teamNameIsOK:_newTeamName])
    {
        if ([self TeamTypeIsSelected:_newTeamType])
        {
            NSLog(@"Team name: %@ and Team Type %@ \n", _newTeamName, _newTeamType); //for testing
            
            //model to send email to server
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
            
            // create data dictionary and send it to the model
            //NSLog(@"PASSWORD, EMAIL, and DISPLAY NAME ALL GOOD\n"); // for testing
            NSArray* objects = [NSArray arrayWithObjects:_newTeamName, _newTeamType, nil];
            NSArray* keys    = [NSArray arrayWithObjects:@"newTeamName", @"newTeamType", nil];
            NSMutableDictionary* newTeamDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            [_model sendMessageToServer:requestNewTeam withDataDictionary:newTeamDictionary];
            
            
        }//end team type
        else  //team type needs to be selected
        {
            NSString* message = @"Please select a team type";
            [(UUCreateTeamView*)self.view showAlertWithMessage:message];
        }
        
    }//end team Name IS OK
    else  //team Name is not ok
    {
        NSString* message = @"Please enter a team name";
        [(UUCreateTeamView*)self.view setTextFieldFocus];
        [(UUCreateTeamView*)self.view showAlertWithMessage:message];
        
    }
    
    
}// end submitButtonWasPressed



/**********************************************************************************************************
 *
 *                                   UITextFieldDelegate Methods
 *
 **********************************************************************************************************/
#pragma - mark UITextFieldDelegate Methods
/** FYI
 *  Some notes about delegate methods and notifications:  We can use the methods provided by the delegate,
 *  or alternatively, we can add an observer to listen for the notifications.  Example:
 *
 *  You can get that event in textField's delegate using textFieldDidBeginEditing: method.
 *  Alternatively you can add observer to listen for UITextFieldTextDidBeginEditingNotification notification.
 *
 *  Here are the notifications provided from the UITextFields:
 *
 *  UIKIT_EXTERN NSString *const UITextFieldTextDidBeginEditingNotification;
 *  UIKIT_EXTERN NSString *const UITextFieldTextDidEndEditingNotification;
 *  UIKIT_EXTERN NSString *const UITextFieldTextDidChangeNotification;
 *
 */

/**
 *  This method is called just before the text field becomes active. This is a good place to customize
 *  the behavior of your application. In this instance, the background color of the text field changes
 *  when this method is called to indicate the text field is active. (If 'no' is returned, editing is disallowed)
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    /*
     NSLog(@"textFieldShouldBeginEditing");
     textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];*/
    return YES;
    
}// end textFieldShouldBeginEditing

/**
 *  This method is called when the text field becomes active (i.e. became first responder)
 *
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // NSLog(@"textFieldDidEndEditing");
    
}// end textFieldDidBeginEditing

/**
 *  This method is called JUST BEFORE the text field becomes inactive.  Here we set the background color
 *  back to white so that the text field can go back to its original color. This method allows
 *  cusomization of the application behavior as the text field becomes inactive.
 *
 *  Returning YES allows editing to stop and resign first responder status.  NO disallows the editing
 *  session to end.
 *
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    /* NSLog(@"textFieldShouldEndEditing");
     textField.backgroundColor = [UIColor whiteColor];*/
    return YES;
    
}// end textFieldShouldEndEditing


/**
 *  This method is called WHEN the textfield becomes inactive.  This method allows cusomization of
 *  the application behavior as the text field becomes inactive.
 *
 *  This method may be called if forced even if shouldEndEditing returns NO
 *  (e.g. view removed from window) or endEditing:YES called
 *
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //NSLog(@"textFieldDidEndEditing");
    
}// end textFieldDidEndEditing


/**
 *  This method is called each time the user types a character on the keyboard. In fact, this
 *  method is called JUST BEFORE a character is displayed.  The method is useful if certain
 *  characters need to be restricted from a text field.  In the code below, the "#" has been
 *  disallowed.
 *
 *  Returning 'NO' will not change the text.
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"textField:shouldChangeCharactersInRange:replacementString:");
    // do not allow spaces in passwords or emails
   /* if (textField.tag == passwordTFTag || textField.tag == emailTFTag)
    {
        if ([string isEqualToString:@" "])
        {
            return NO;
        }
        else {
            return YES;
        }
    }*/
    
    return YES;
}// end shouldChangeCharactersInRange

/**
 *  This method is called when the user presses the clear button, the gray "x," inside the text field.
 *  Before the active text field is cleared, this method gives an opportunity to make any needed customizations.
 *  Return NO to ignore (no notifications).
 *
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    //NSLog(@"textFieldShouldClear:");
    return YES;
    
}// end textFieldShouldClear

/**
 *  This method is called when the user presses the return key on the keyboard. In the following code,
 *  we find out which text field is active by looking at the tag property. If the "email" text field
 *  is active, the next text field, "password," should become active instead. If the "password" text
 *  field is active, "password" should resign, resigning the keyboard with it.
 *
 *  Return 'NO' to ignor (no notifications).
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _newTeamName = textField.text;
    //NSLog(@"Done button was pressed and team name is %@", _newTeamName); // for testing
   [textField resignFirstResponder];
    return YES;
    
    
}// end textFieldShouldReturn


/**********************************************************************************************************
 *
 *                                   Server Response Methods
 *
 **********************************************************************************************************/

 -(void) responseDataForRequestNewTeamReceived:(int)responseCase
{
    [SVProgressHUD dismiss];
    
    switch (responseCase)
    {
        case 1000: //sucessful register
        {
            NSLog(@"Email sent was successful\n");
            break;
        }
        case 1011:  // team name already exists
        {
            NSLog(@"Team already exists\n");
            
            break;
        }
        default: //general server error
        {
            
            NSLog(@"general error\n");
            break;
            
        }
            
            
    }//end switch
    
}//end response

/**********************************************************************************************************
 *
 *                                   helper Methods
 *
 **********************************************************************************************************/
-(BOOL) teamNameIsOK:(NSString*) teamNameString
{
    if ([teamNameString length] < 1)
        return NO;
 
    return YES;
    
}//end teamNameIsOK

-(BOOL) TeamTypeIsSelected:(NSString*) teamTypeString
{
    if ([teamTypeString isEqualToString:@""])
        return NO;
    
    return YES;
    
}// end teamTypeIsSelected

//remove leading and trailing spaces
- (NSString*) cleanDisplayName: (NSString*)name
{
    int stringLength = [name length];
    int firstRealCharacter = -1;
    int lastRealCharacter = -1;
    
    for (int i = 0; i < stringLength; i++)
    {
        if ([name characterAtIndex:i] != ' ')
        {
            firstRealCharacter = i;
            break;
        }
        
    }
    
    // walk backwards through the name string
    for (int i = stringLength - 1; i > -1; i--)
    {
        if ([name characterAtIndex:i] != ' ')
        {
            lastRealCharacter = i;
            break;
        }
        
    }
    
    if (firstRealCharacter == -1 || lastRealCharacter == -1) // no real characters
        return @"";
    
    //create a substring
    NSRange stringRange = NSMakeRange(firstRealCharacter, lastRealCharacter - firstRealCharacter + 1);
    NSString* newName = [name substringWithRange:stringRange];
    
    return newName;
    
}// end clean name



@end

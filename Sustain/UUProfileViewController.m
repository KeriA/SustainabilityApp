//
//  UUProfileViewController.m
//  Sustain
//
//  Created by Keri Anderson on 4/15/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUProfileViewController.h"

@interface UUProfileViewController ()

@end

@implementation UUProfileViewController

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
        
        _profileImage = [_model getProfileImage];
        
    }
    return self;
    
}// end contstructor

-(void) loadView
{
    self.view = [[UUProfileView alloc] initWithProgramConstants:_programConstants andProfileImage:_profileImage];
    
        
}//end loadView

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Update Profile";
    // with iOS5 the navigation bar now has title text attributes set with a dictionary
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
} // end viewDidLoad


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // set the view's delegate to self (this controller)
    [(UUProfileView*)self.view setProfileViewDelegate:self];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**************************************************************************************************
 *
 *                          for easy access to view
 *
 **************************************************************************************************/
- (UUProfileView*)getView
{
    return (UUProfileView*)[self view];
}


/**********************************************************************************************************
 *
 *                          UUCreateUserView Delegate Methdods
 *
 **********************************************************************************************************/
#pragma - mark UUProfileViewDelegate Methods
- (void) updateProfileButtonWasPressed
{
    // first test to see if information was correctly filled
    
    
    // SVProgressHUD is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call [SVProgressHUD <method>]).
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    // create data dictionary and send it to the model
    //NSLog(@"PASSWORD, EMAIL, and DISPLAY NAME ALL GOOD\n"); // for testing
    NSArray* objects = [NSArray arrayWithObjects: _profileImage, @"", @"", @"2000", nil];
    NSArray* keys    = [NSArray arrayWithObjects:@"userImage", @"password", @"displayName", @"teamKey", nil];

    NSMutableDictionary* dataDictionary = [[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
        
    [_model sendMessageToServer:updateUserProfile withDataDictionary:dataDictionary];
    
    
}//end updateProfileButtonWasPressed


/**********************************************************************************************************
 *
 *                          Server Response Recieved
 *
 *********************************************************************************************************/
-(void) UpdateProfileResponseReceived:(int)responseCase
{
    [SVProgressHUD dismiss];
    
    switch (responseCase)
    {
        case 1000: //sucessful register
        {
            //temporary code:  try pulling the info from the server to get an update
            // create data dictionary and send it to the model
            //NSLog(@"PASSWORD, EMAIL, and DISPLAY NAME ALL GOOD\n"); // for testing
            NSArray* objects = [NSArray arrayWithObjects:  @" ", nil];
            NSArray* keys    = [NSArray arrayWithObjects:@"userKey", nil];
            
            NSMutableDictionary* dataDictionary = [[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
            
            [_model sendMessageToServer:getUserProfile withDataDictionary:dataDictionary];
            
            break;
        }
        case 1002: // invalid password format
        {
            /*
            [[self getView] updateErrorMessage:invalidPasswordString];
            //set the focus to the password field
            UITextField* passwordTextField = (UITextField *)[self.view viewWithTag:passwordTFTag];
            [passwordTextField becomeFirstResponder];
            */
            
            break;
            
        }
        case 1003: // invalid username format
        {
            /*
            [[self getView] updateErrorMessage:invalidUserNameString];
            //set the focus to the password field
            UITextField* passwordTextField = (UITextField *)[self.view viewWithTag:displayNameTFTag];
            [passwordTextField becomeFirstResponder];
            
            */
            break;
            
        }
        default: //general server error
        {
            /*
            [[self getView] updateErrorMessage:generalServerErrorString];
            //set focus to display name field
            UITextField* displayTextField = (UITextField *)[self.view viewWithTag:displayNameTFTag];
            [displayTextField becomeFirstResponder];
            
            break;
            */
        }
            
            
    }//end switch
    

    
}//end UpdateProfileResponseReived

- (void) GetProfileDataReceived:(NSMutableDictionary *)responseDictionary
{
    //UIImage* newProfileImage = [responseDictionary objectForKey:@"profileImage"];
    
    [[self getView]updateDisplayValues:responseDictionary];
    
    
}//end GetProfileDataReceived

@end

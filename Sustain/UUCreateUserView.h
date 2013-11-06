//
//  UUCreateUserView.h
//  Sustain
//
//  Created by Keri Anderson on 9/3/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUProgramConstants.h"
#import <QuartzCore/QuartzCore.h>  // used so that CALayer properties of textfields will be visible

// for ease of use and clarification
#define displayNameTFTag 1
#define emailTFTag 2
#define passwordTFTag 3

// we will have the view controller handle all the events of this view
@protocol UUCreateUserViewDelegate
@required
- (void) signUpButtonWasPressed;
- (void) faceBookButtonWasPressed;
- (void) twitterButtonWasPressed;

@end // end protocol

@interface UUCreateUserView : UIView
{
    UUProgramConstants* _programConstants;
    
    UILabel*     _errorMessageLabel;
    //UITableView* _enterInfoTableView;
    UITextField* _displayNameTextField;
    UITextField* _emailTextField;
    UITextField* _passwordTextField;
    UIButton*    _signUpButton;
    UILabel*     _agreementLabel;
    UIButton*    _faceBookButton;
    UIButton*    _twitterButton;
    UIImageView* _fbImageView;
    UIImageView* _twitterImageView;
    
    id<UUCreateUserViewDelegate>createUserViewDelegate;
    
}

// delegate should be a weak reference
@property (readwrite, nonatomic) id createUserViewDelegate;


- (id)initWithProgramConstants:(UUProgramConstants*)programConstants;
-(void) setSubViewDelegates:(id)delegate;
-(void) updateErrorMessage:(NSString*)message;

@end

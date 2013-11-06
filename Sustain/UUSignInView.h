//
//  UUSignInView.h
//  Sustain
//
//  Created by Keri Anderson on 7/16/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUProgramConstants.h"
#import <QuartzCore/QuartzCore.h>

// for ease of use and clarification
#define emailTag 1
#define passwordTag 2


// we will have the view controller handle all the events of this view
@protocol UUSignInViewDelegate
@required
-(void) loginButtonWasPressed;
-(void) faceBookLoginButtonWasPressed;
-(void) signUpButtonWasPressed;

@end // end protocol

@interface UUSignInView : UIView
{
    //UILabel*     _greenULabel;
    UIImageView* _greenUImageView;
    UILabel*     _orLabel;
    UITextField* _emailTextField;
    UITextField* _passwordTextField;
    UIButton*    _loginButton;
    UIButton*    _loginWithFBButton;
    UIButton*    _signUpButton;
        
    UUProgramConstants* _programConstants;
    
    
    id<UUSignInViewDelegate>signInViewDelegate;
    
    
       
}

// delegate should be a weak reference
@property (readwrite, nonatomic) id signInViewDelegate;


- (id)initWithProgramConstants:(UUProgramConstants*)programConstants;
-(void) setSubViewDelegates:(id)delegate;


@end

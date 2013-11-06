//
//  UUAppDelegate.h
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//  this is a test

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"
#import "UUMainViewController.h"
#import "UUSignInViewController.h"

@interface UUAppDelegate : UIResponder <UIApplicationDelegate, UUDataFinishedLoadingDelegate>
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
    UUMainViewController* _mainViewController;
    UUSignInViewController* _signInViewController;
    
}

@property (strong, nonatomic) UIWindow *window;

@end

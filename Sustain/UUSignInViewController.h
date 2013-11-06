//
//  UUSignInViewController.h
//  Sustain
//
//  Created by Keri Anderson on 7/16/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"
#import "UUSignInView.h"

@interface UUSignInViewController : UIViewController<UUSignInViewDelegate, UITextFieldDelegate, UUParticipantLoginDataReceivedDelegate>
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
    UUSignInView* _signInView;
}

- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants;
-(BOOL) emailIsOK:(NSString*) emailString;
-(BOOL) passwordIsOK:(NSString*) passwordString;

@end

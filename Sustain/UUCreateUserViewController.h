//
//  UUCreateUserViewController.h
//  Sustain
//
//  Created by Keri Anderson on 9/3/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"
#import "UUMainViewController.h"
#import "UUCreateUserView.h"

@interface UUCreateUserViewController : UIViewController<UUCreateUserViewDelegate, UITextFieldDelegate, UURegisterParticipantDataReceivedDelegate>
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
    UUCreateUserView* _createUserView;
}

- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants;
-(BOOL) displayNameIsOK:(NSString*) displayString;
-(BOOL) emailIsOK:(NSString*) emailString;
-(BOOL) passwordIsOK:(NSString*) passwordString;
- (UUCreateUserView*)getView;
- (NSString*) cleanDisplayName: (NSString*)name;



@end

//
//  UUCreateTeamView.h
//  Sustain
//
//  Created by Keri Anderson on 1/12/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUProgramConstants.h"
#import <QuartzCore/QuartzCore.h> 

// we will have the view controller handle all the events of this view
@protocol UUCreateTeamViewDelegate
@required
- (void) schoolButtonWasPressed;
- (void) businessButtonWasPressed;
- (void) otherButtonWasPressed;
- (void) submitButtonWasPressed;

@end // end protocol


@interface UUCreateTeamView : UIView
{
    UUProgramConstants* _programConstants;
    
    id<UUCreateTeamViewDelegate>createTeamViewDelegate;
}

// delegate should be a weak reference
@property (readwrite, nonatomic) id createTeamViewDelegate;

- (id)initWithProgramConstants:(UUProgramConstants*)programConstants;
-(void) setSubViewDelegates:(id)delegate;

- (void) checkSchoolButton;
- (void) unCheckSchoolButton;
- (void) checkBusinessButton;
- (void) unCheckBusinessButton;
- (void) checkOtherButton;
- (void) unCheckOtherButton;

- (void) showAlertWithMessage: (NSString*) message;
- (void) setTextFieldFocus;
@end

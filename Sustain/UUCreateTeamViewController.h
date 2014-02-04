//
//  UUCreateTeamViewController.h
//  Sustain
//
//  Created by Keri Anderson on 1/12/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"
#import "UUCreateTeamView.h"

@interface UUCreateTeamViewController : UIViewController<UITextFieldDelegate, UUCreateTeamViewDelegate, UUResponseForNewTeamReceivedDelegate>
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
}

- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants;

@end

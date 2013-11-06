//
//  UUChallengeViewController.h
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"

@interface UUChallengeViewController : UIViewController
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
}


- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants;

@end

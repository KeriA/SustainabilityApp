//
//  UUMainViewController.h
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUChallengeViewController.h"
#import "UUTopUsersViewController.h"
#import "UUTeamCategoriesViewController.h"
#import "UUAboutViewController.h"
#import "UUSponsorsViewController.h"
#import "UUProfileViewController.h"
#import "UUProgramConstants.h"

@interface UUMainViewController : UIViewController
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;

    
    //controllers
    UUChallengeViewController*      challengeViewController;
    UUTopUsersViewController*       topUsersViewController;
    UUTeamCategoriesViewController* teamCategoriesViewController;
    UUAboutViewController*          aboutViewController;
    UUSponsorsViewController*       sponsorsViewController;
    UUProfileViewController*        profileViewController;
    
}


- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants *)programConstants;


@end

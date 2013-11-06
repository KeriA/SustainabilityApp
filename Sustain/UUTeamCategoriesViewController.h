//
//  UUTeamCategoriesViewController.h
//  Sustain
//
//  Created by Keri Anderson on 4/15/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUTeamsViewController.h"

@interface UUTeamCategoriesViewController : UIViewController
{
    UUSustainModel* _model;
    UUTeamsViewController* teamsViewController;
}

- (id)initWithModel:(UUSustainModel*)model;

@end

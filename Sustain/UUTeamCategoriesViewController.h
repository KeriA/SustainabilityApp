//
//  UUTeamCategoriesViewController.h
//  Sustain
//
//  Created by Keri Anderson on 4/15/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"
#import "UUTeamCategoriesView.h"
#import "UUCreateTeamViewController.h"

@interface UUTeamCategoriesViewController : UIViewController<UUTeamCategoriesViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UUPickerContainerViewDelegate>
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
    UUCreateTeamViewController* _createTeamViewController;
    
}

- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants;

@end

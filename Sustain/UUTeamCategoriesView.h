//
//  UUTeamCategoriesView.h
//  Sustain
//
//  Created by Keri Anderson on 1/8/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUProgramConstants.h"
#import "UUIconButton.h"
#import "UUPickerContainerView.h"
#import <QuartzCore/QuartzCore.h>


// we will have the view controller handle all the events of this view
@protocol UUTeamCategoriesViewDelegate
@required
- (void) schoolsButtonWasPressed;
- (void) businessesButtonWasPressed;
- (void) otherButtonWasPressed;
- (void) requestNewTeamButtonWasPressed;

@end // end protocol

@interface UUTeamCategoriesView : UIView
{
    UUProgramConstants* _programConstants;
    
    id<UUTeamCategoriesViewDelegate>teamCategoriesViewDelegate;

    
}

// delegate should be a weak reference
@property (readwrite, nonatomic) id teamCategoriesViewDelegate;

- (id)initWithProgramConstants:(UUProgramConstants*)programConstants;
-(void) setSubViewDelegates:(id)delegate;
-(void) showPickerView;
-(void) hidePickerView;
-(void) pickerViewReloadData;

@end

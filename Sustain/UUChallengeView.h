//
//  UUChallengeView.h
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//
//  Displays the Challenge Image 
//
//

#import <UIKit/UIKit.h>
//#import "UUSustainModel.h"
#import "UUProgramConstants.h"

@class UUChallengeView;
@protocol UUChallengeViewDelegate <NSObject>

- (void)challengeButtonWasTapped:(id)sender;

@end

@interface UUChallengeView : UIImageView
{
    UUProgramConstants* _programConstants;
}

@property (readwrite, nonatomic) id<UIPickerViewDataSource> pickerDataSource;
@property (readwrite, nonatomic) id<UIPickerViewDelegate> pickerDelegate;
@property (readwrite, nonatomic) id<UUChallengeViewDelegate>delegate;

- (id) initWithProgramConstants: (UUProgramConstants*)programConstants andMonth: (int)month;


@end

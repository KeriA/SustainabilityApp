//
//  UUProfileView.h
//  Sustain
//
//  Created by Keri Anderson on 11/11/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUProgramConstants.h"

// we will have the view controller handle all the events of this view
@protocol UUProfileViewDelegate
@required
- (void) updateProfileButtonWasPressed;

@end // end protocol

@interface UUProfileView : UIView
{
    UUProgramConstants* _programConstants;
    UIImageView* _profileImageView;
    UIImage* _profileImage;
    UIButton* _updateProfileButton;
    
    id<UUProfileViewDelegate>profileViewDelegate;
    
}


// delegate should be a weak reference
@property (readwrite, nonatomic) id profileViewDelegate;






- (id)initWithProgramConstants:(UUProgramConstants*)programConstants andProfileImage:(UIImage*)profileImage;
- (void) updateDisplayValues:(NSMutableDictionary*)displayDictionary;

@end

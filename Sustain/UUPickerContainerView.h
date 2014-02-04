//
//  UUPickerContainerView.h
//  Sustain
//
//  Created by Keri Anderson on 1/11/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>

// we will have the view controller handle all the events of this view
@protocol UUPickerContainerViewDelegate
@required
- (void) cancelButtonWasPressed;
- (void) selectTeamButtonWasPressed;
@end // end protocol

@interface UUPickerContainerView : UIView
{
    
    id<UUPickerContainerViewDelegate>pickerContainerViewDelegate;
}

// delegate should be a weak reference
@property (readwrite, nonatomic) id pickerContainerViewDelegate;

-(void) setSubViewDelegates:(id)delegate;
-(void) reloadPickerData;

@end

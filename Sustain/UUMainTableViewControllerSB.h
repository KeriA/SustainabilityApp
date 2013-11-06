//
//  UUMainTableViewController.h
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UUMainTableCellOption) {
	UUMainTableCellOptionChallenges = 0,
	UUMainTableCellOptionTopUsers = 1,
    UUMainTableCellOptionTeams = 2,
    UUMainTableCellOptionAbout = 3,
    UUMainTableCellOptionSponsers = 4,
    UUMainTableCellOptionProfile = 5
};

@class UUMainTableViewController;
@protocol UUMainTableViewControllerDelegate <NSObject>
-(void)cellWasTapped:(NSInteger)cell;
@end


@interface UUMainTableViewController : UITableViewController

// Delegate
@property (nonatomic, strong) id<UUMainTableViewControllerDelegate> delegate;

@end

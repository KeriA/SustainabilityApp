//
//  UUViewController.m
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUMainViewControllerSB.h"
#import "UUMainTableViewControllerSB.h"

@interface UUMainViewController () <UUMainTableViewControllerDelegate>
{
    UUMainTableViewController *mainTableView;
}
@end

@implementation UUMainViewController 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Get the tableView with static cells from the container view
    mainTableView = (UUMainTableViewController *)[self.childViewControllers lastObject];
    mainTableView.delegate = self;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"challenges"]) {
        // Set challenge view controller properties here
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


#pragma mark - UUMainTableViewControllerDelegate
-(void)cellWasTapped:(NSInteger)cell
{
    switch (cell) {
        case UUMainTableCellOptionChallenges:
            [self performSegueWithIdentifier:@"challenges" sender:nil];
            break;
        case UUMainTableCellOptionTopUsers:
            [self performSegueWithIdentifier:@"topUsers" sender:nil];
            break;
        case UUMainTableCellOptionTeams:
            [self performSegueWithIdentifier:@"teams" sender:nil];
            break;
        case UUMainTableCellOptionAbout:
            [self performSegueWithIdentifier:@"about" sender:nil];
            break;
        case UUMainTableCellOptionSponsers:
            [self performSegueWithIdentifier:@"sponsers" sender:nil];
            break;
        case UUMainTableCellOptionProfile:
            [self performSegueWithIdentifier:@"profile" sender:nil];
            break;
            
        default:
            break;
    }
}

@end

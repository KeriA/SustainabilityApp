//
//  UUMainTableViewController.m
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUMainTableViewControllerSB.h"

@implementation UUMainTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
}




/*
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([TRSettings setupStatus] == TRSetupStatusPostInitial && indexPath.row == TRSetupTableSpecCellCalories) {
        cell.hidden = NO;
    }
    
    cell.textLabel.font = [TRFont bold];
    cell.textLabel.textColor = [TRColor darkGrayColor];
    cell.textLabel.highlightedTextColor = [TRColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.backgroundColor = [TRColor lightGrayColor];
    
    
    // change static cells text.
    if (indexPath.section == 0) {
        
    }
    
}*/





- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"did select row");
    [self.delegate cellWasTapped:indexPath.row];
}


- (void)viewDidUnload {
	[super viewDidUnload];
}








@end

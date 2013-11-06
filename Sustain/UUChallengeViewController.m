//
//  UUChallengeViewController.m
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUChallengeViewController.h"
#import "UUChallengeView.h"

#define UUChallengeViewCellIdentifier @"challengeCell"
#

//@interface UUChallengeViewController () <UITableViewDataSource, UITableViewDelegate, UUChallengeViewDelegate>
@interface UUChallengeViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UUChallengeViewDelegate>
{
    UIButton *_challengeButton;
    UITableView *_previousMonthTable;
    NSArray *monthness;
}

@end

@implementation UUChallengeViewController


/***
 *
 *      Constructor:  create a weak reference to the model
 */
- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        //fill in the data model to use - at this point, the data from the server
        // should already be loaded
        _model = model;
        
        _programConstants = programConstants;
        
        
        //In your UIViewController there is a title property and it is that property
        //that will be displayed by the NavigationController. So when pushing a new
        //UIViewController onto the navigation stack set the title of that UIViewController
        //to whatever is appropriate.
        self.title  = @"Challenges";
        
               


        
        
    }
    return self;
    
}// end contstructor

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
    
    // right now, hard coded to the month of january
    self.view = [[UUChallengeView alloc] initWithProgramConstants:_programConstants andMonth:1];
    
    //((UUChallengeView *)self.view).tableDataSource = self;
    //((UUChallengeView *)self.view).tableDelegate = self;
    
    ((UUChallengeView *)self.view).pickerDataSource = self;
    ((UUChallengeView *)self.view).pickerDelegate = self;

    ((UUChallengeView *)self.view).delegate = self;
    
    
    //monthness = @[@"Jan",@"Feb",@"Mar"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
   // [SVProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/***********************************************************************************************
 *
 *                          UIPickerViewDataSource methods
 *
 ***********************************************************************************************/
#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_model numberOfPreviousChallenges];
}



/***********************************************************************************************
 *
 *                          UIPickerViewDataSource methods
 *
 ***********************************************************************************************/
#pragma mark - UIPickerViewDelegate

// tell the picker which view to use for a given component and row, we have an array of views to show
/*- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view
{
	return [customPickerArray objectAtIndex:row];
}*/

/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //Hiding the first and the last subview totally removes the background.
    //The picker will not have subviews until it is fully loaded. If you try to do
    //this in the viewDidLoad or viewWillAppear it will not work. However, I moved mine into
    //one of the UIPickerView protocol methods and it worked.- (NSString *)pickerView:(UIPickerView *)
    //thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { . – Inturbidus Mar 9 '12 at 18:23
    [(UIView*)[[pickerView subviews] objectAtIndex:0] setHidden:YES];
    [(UIView*)[[pickerView subviews] objectAtIndex:[pickerView subviews].count - 1] setHidden:YES];
    
    
    return [_programConstants getPreviousMonthCaption:row];
    //return [_model previousTopicTitle:row];
    //cell.textLabel.text = [_model previousTopicTitle:indexPath.row];
    //cell.textLabel.font = [UIFont fontWithName:@"Gill Sans Regular" size:[UIFont labelFontSize]];
    //cell.textLabel.font = [UIFont fontWithName:@"GillSansMTPro-Book" size:16.0];

}
*/

/***
 *  This method is used to allow custom fonts and sizes
 *
 */

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerViewLabel = (id)view;
    if (!pickerViewLabel)
    {
        pickerViewLabel= [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    [(UIView*)[[pickerView subviews] objectAtIndex:0] setHidden:YES];
    [(UIView*)[[pickerView subviews] objectAtIndex:[pickerView subviews].count - 1] setHidden:YES];
    
    pickerViewLabel.text = [_programConstants getPreviousMonthCaption:row];
    pickerViewLabel.font = [_programConstants getBoldFontWithSize:16.0];
    return pickerViewLabel;
    
}// end viewForRow





/***********************************************************************************************
 *
 *                          UUChallengeViewDelegate methods
 *
 ***********************************************************************************************/
#pragma mark - UUChallengeViewDelegate
- (void)challengeButtonWasTapped:(id)sender
{
    [self quickHack];
}
- (void) quickHack
{
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    
    UIViewController * dummy1 = [[UIViewController alloc] init];
    UIViewController * dummy2 = [[UIViewController alloc] init];
    [[dummy1 view] setBackgroundColor:[UIColor orangeColor]];
    [[dummy2 view] setBackgroundColor:[UIColor yellowColor]];
    
    [dummy1 setTitle:@"Challenge"];
    [dummy2 setTitle:@"Topic"];
    
    [tabBarController setViewControllers:@[dummy1, dummy2]];
    
    [[self navigationController] pushViewController:tabBarController animated:TRUE];
}



@end

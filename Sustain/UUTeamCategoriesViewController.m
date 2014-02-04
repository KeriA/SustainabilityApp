//
//  UUTeamCategoriesViewController.m
//  Sustain
//
//  Created by Keri Anderson on 4/15/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUTeamCategoriesViewController.h"

@interface UUTeamCategoriesViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation UUTeamCategoriesViewController
{
    int _numOfCategories;
    NSMutableArray* _categoryNames;
    
    
    NSArray* _pickerInputArray;  // picker reads from this
    //these are used to switch _pickerInputArray pointer
    NSArray* _schoolTeamsArray;
    NSArray* _businessesTeamsArray;
    NSArray* _otherTeamsArray;

}

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
        
        //create a weak reference to the model
        _model = model;
        
        //create a weak reference to the program constants
        _programConstants = programConstants;
        
        
        // get team info from the server
        //model to send email to server
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        
        /// create data dictionary and send it to the model
        //NSLog(@"PASSWORD, EMAIL, and DISPLAY NAME ALL GOOD\n"); // for testing
        NSArray* objects = [NSArray arrayWithObjects: @"SCHOOL", nil];
        NSArray* keys    = [NSArray arrayWithObjects:@"teamCategory",nil];
        NSMutableDictionary* teamCategoryDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        [_model sendMessageToServer:getTeamsByType withDataDictionary:teamCategoryDictionary];
        
        //_schoolTeamsArray = [NSArray arrayWithObjects:@"School1", @"School2", @"School3", @"School4", nil];
        //_businessesTeamsArray = [NSArray arrayWithObjects:@"Business1", @"Business2", @"Business3", nil];
        //_otherTeamsArray = [NSArray arrayWithObjects:@"Other1", @"Other2", @"Other3", @"Other4", @"Other5", nil];
        
        
                
        
    }
    return self;
    
}// end contstructor


/********************************************************************************************************
 *
 *      UIView Controller Overrides
 *
 ********************************************************************************************************/

/***
 *  Add the 'loadView' method and create a table view here.
 *  Recall, the 'Grouped' style gives the pin-striped background
 *
 */
- (void) loadView
{
    self.view = [[UUTeamCategoriesView alloc] initWithProgramConstants:_programConstants];
        

    
}// end loadView


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // set the view's delegate to self (this controller)
    [(UUTeamCategoriesView*)self.view setTeamCategoriesViewDelegate:self];
    [(UUTeamCategoriesView*)self.view setSubViewDelegates:self];
    
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"TEAMS";
    // with iOS5 the navigation bar now has title text attributes set with a dictionary
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
} // end viewWillAppear


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**************************************************************************************************
 *
 *                          for easy access to view
 *
 **************************************************************************************************/
- (UUTeamCategoriesView*)getView
{
    return (UUTeamCategoriesView*)[self view];
}



/**********************************************************************************************************
 *
 *                          UUTeamCategoriesView Delegate Methdods
 *
 **********************************************************************************************************/
#pragma - mark UUTeamCategoriesViewDelegate Methods

-(void) schoolsButtonWasPressed
{
    //NSLog(@"Schools button pressed");
    //first, reload the correct data for picker and reload the data
    _pickerInputArray = _schoolTeamsArray;
    [(UUTeamCategoriesView*)[self view] pickerViewReloadData];
    
    [(UUTeamCategoriesView*)[self view] showPickerView];
}

-(void) businessesButtonWasPressed
{
    //NSLog(@"businesses button pressed");
    //first, reload the correct data for picker and reload the data
    _pickerInputArray = _businessesTeamsArray;
    [(UUTeamCategoriesView*)[self view] pickerViewReloadData];
    
    [(UUTeamCategoriesView*)[self view] showPickerView];
}

-(void) otherButtonWasPressed
{
    // NSLog(@"Other button pressed");
    //first, reload the correct data for picker and reload the data
    _pickerInputArray = _otherTeamsArray;
    [(UUTeamCategoriesView*)[self view] pickerViewReloadData];
    
    [(UUTeamCategoriesView*)[self view] showPickerView];

}

-(void) requestNewTeamButtonWasPressed
{
    
    NSLog(@"Request New Team button pressed");
    _createTeamViewController = [[UUCreateTeamViewController alloc] initWithModel:_model andProgramConstants:_programConstants];
    [[self navigationController] pushViewController:_createTeamViewController animated:TRUE];
}

/**********************************************************************************************************
 *
 *                          UUTeamPickerView Delegate Methods
 *
 **********************************************************************************************************/
#pragma mark -
#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    

}//end picker did Select row



/***
 *  This method is used to allow custom fonts and sizes
 *
 */

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerViewLabel = (id)view;    
    if (!pickerViewLabel)
    {
        pickerViewLabel= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    pickerViewLabel.backgroundColor = [UIColor clearColor];
    
    //this hides the outer frame of the picker so it looks like it is floating in space
    [(UIView*)[[pickerView subviews] objectAtIndex:0] setHidden:YES];
    [(UIView*)[[pickerView subviews] objectAtIndex:[pickerView subviews].count - 1] setHidden:YES];
    
    //kind of a clunky fix - the picker shows the text right on the left edge
    //the spacer string pushes it over a bit
    NSString* textString = [NSString stringWithFormat:@"   %@", [_pickerInputArray objectAtIndex:row]];
    pickerViewLabel.text = textString;
    pickerViewLabel.font = [_programConstants getBoldFontWithSize:16.0];
    return pickerViewLabel;
    
}// end viewForRow






/**********************************************************************************************************
 *
 *                          UUTeamPickerView DataSource Methods
 *
 **********************************************************************************************************/
#pragma mark -
#pragma mark UIPickerViewDataSource
/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
    
    returnStr = [_pickerInputArray objectAtIndex:row];
	
	// note: custom picker doesn't care about titles, it uses custom views
	if (pickerView == myPickerView)
	{
		if (component == 0)
		{
			returnStr = [pickerViewArray objectAtIndex:row];
		}
		else
		{
			returnStr = [[NSNumber numberWithInt:row] stringValue];
		}
	}
	
	return returnStr;
}*/

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 30.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [_pickerInputArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


/**********************************************************************************************************
 *
 *                          UUPickerViewContainerDelegate Methods
 *
 **********************************************************************************************************/
#pragma mark -
#pragma mark UUPickerViewContainerDelegate

-(void) cancelButtonWasPressed
{
    NSLog(@"cancel button was pressed");
    [(UUTeamCategoriesView*)[self view] hidePickerView];
}

-(void) selectTeamButtonWasPressed
{
    NSLog(@"select team button was pressed");
}




@end
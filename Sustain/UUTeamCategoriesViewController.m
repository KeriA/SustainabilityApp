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

}

/***
 *
 *      Constructor:  create a weak reference to the model
 */
- (id)initWithModel:(UUSustainModel*)model
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
        //fill in the data model to use
        _model = model;        
        
        [self.view setBackgroundColor:[_model tealColor]]; // for testing (sanity check)
        
        
        //fill in the list of categories
        _numOfCategories = [_model numberOfTeamCategories];
        _categoryNames = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < _numOfCategories; i++)
        {
            [_categoryNames addObject: [_model nameOfTeamCategory:i]];
        }
        
        // add in one more category at the end
        [_categoryNames addObject:@"Create New Team"];
        _numOfCategories++;  // increment to represent the actual count of categories
        
        
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
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self setView:tableView];
    
}// end loadView


/***
 *  In the viewDidLoad method we need to set the datasource and delegate to self.  Recall, we also need to implement the
 *  UITableViewDataSource and UITableViewDelegate interfaces at  the top of this file, next to
 *  @interface
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // set the background of the tableView
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenLoadingImage.jpeg"]];
    [tempImageView setFrame:self.view.frame];
    [self contentView].backgroundView = tempImageView;
    
    // Do any additional setup after loading the view.
    [[self contentView] setDataSource:self];
    [[self contentView] setDelegate:self];
    
    
}// end viewDidLoad

/***
 *  A getter for the content view.  We assigned this class's view to be a table view,
 *  and without this getter, we would always have to cast the view as a tableview first
 *  in order to access the tableview properties.  It is just easier to write a simple
 *  method to do that.
 *
 */
- (UITableView*)contentView
{
    return (UITableView*)[self view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/***********************************************************************************************
 *
 *                          UITableViewDataSource methods
 *
 ***********************************************************************************************/
#pragma mark - UITableViewDataSource methods

/***
 *
 *  get the number of top level rows from our data model
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;  // each section will only have one row in this table view
    
}// end numberOfRowsInSection


/***
 * This method is optional.  (How we create the number of sections needed)
 * Default is 1 if not implemented
 *
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _numOfCategories;
    
}// end numberOfSectionsInTableView


/***
 * Create the individual cells
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create table view cell
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString* text = [_categoryNames objectAtIndex:[indexPath section]];

    UIColor* textColor= [UIColor blackColor];
    
    [[cell textLabel] setText:text];
    cell.textLabel.textColor = textColor;
	
    return cell;
}

/***********************************************************************************************
 *
 *                          UITableViewDelegate methods
 *
 ***********************************************************************************************/

#pragma mark - UITableViewDelegate methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // step 12 - this just makes it look pretty
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    teamsViewController = [[UUTeamsViewController alloc]initWithModel:_model];
    [[self navigationController] pushViewController:teamsViewController animated:TRUE];

    
}// end didSelectRowAtIndexPath




@end

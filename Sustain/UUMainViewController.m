//
//  UUMainViewController.m
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//
/***
 *
 *  This controller manages the table view listing the main options for the app
 *
 */

#import "UUMainViewController.h"

@interface UUMainViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIColor* selectedCellColor;
    UIColor* unSelectedCellColor;
    
    UIImageView* _challengeImageView;
}

@end

@implementation UUMainViewController

/***
 *
 *      Constructor:  create a weak reference to the model
 */
- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants *)programConstants
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
        //fill in the data model to use
        _model = model;
        _programConstants = programConstants;
        
        
        //In your UIViewController there is a title property and it is that property
        //that will be displayed by the NavigationController. So when pushing a new
        //UIViewController onto the navigation stack set the title of that UIViewController
        //to whatever is appropriate.        
        self.title  = @"GreenU";
        
    
        
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
    
    //
    //  Note: the UITableView does not itself draw anything except the background. To customize the background of
    //  a UITableView, all you need to do is set its backgroundColor to [UIColor clearColor] and you can draw
    //  your own background in a view behind the UITableView.
    //
    
    // use an image behind the UITableView
   /* [self contentView].backgroundColor = [UIColor clearColor];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenLeaves.png"]];
    
    */
    
    
    // set the background of the tableView
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.view.frame];    
    [self contentView].backgroundView = tempImageView;
    
    // set the cell sizes and properties
    [self contentView].separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self contentView].rowHeight = 65;
    [self contentView].rowHeight = 100;
     
    
    
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
    return [_model numberOfMainMenuOptions];
    
}// end numberOfRowsInSection


/***
 * This method is optional.  (How we create the number of sections needed)
 * Default is 1 if not implemented
 *
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // first section lists the shapes to choose from, second, the shapes selected
    return 1;
    
}// end numberOfSectionsInTableView


/***
 *
 * Create the individual cells.  The cell background needs to incorporate the tops 
 * and bottoms of table "sections". For this reason, the backgroundView and 
 * selectedBackgroundView normally need to be set on a row-by-row basis.
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // begin practice code
	//const NSInteger TOP_LABEL_TAG = 1001;
	//const NSInteger BOTTOM_LABEL_TAG = 1002;
	//UILabel *topLabel;
	//UILabel *bottomLabel;

    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		//
		// Create the cell.
		//
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
      /*
		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
		cell.accessoryView =  [[UIImageView alloc] initWithImage:indicatorImage];
		
		const CGFloat LABEL_HEIGHT = 20;
		UIImage *image = [UIImage imageNamed:@"imageA.png"];*/
        
		//
		// Create the label for the top row of text
		//
		/*topLabel = [[UILabel alloc] initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT),
                     tableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)];*/
        
		//[cell.contentView addSubview:topLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		//topLabel.tag = TOP_LABEL_TAG;
        [cell textLabel].backgroundColor = [UIColor clearColor];
		//topLabel.backgroundColor = [UIColor clearColor];
        [cell textLabel].textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
		//topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		//topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        //[cell textLabel].font = [UIFont fontWithName:@"GillSansShadowedMTPro-Light" size:[UIFont labelFontSize]];
        //[cell textLabel].font = [UIFont fontWithName:@"GillSansShadowedMTPro-Light" size:30.0];
        //[cell textLabel].font = [UIFont fontWithName:@"GillSansMTPro-Book" size:30.0];
        [cell textLabel].font = [UIFont fontWithName:@"GillSansMTPro-BoldCondensed" size:30.0];
		//topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
                
		//
		// Create the label for the bottom row of text
		//
		/*bottomLabel =
        [[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
                     tableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)];
		[cell.contentView addSubview:bottomLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
        */
		//
		// Create a background image view.
		//
		cell.backgroundView = [[UIImageView alloc] init];
		cell.selectedBackgroundView = [[UIImageView alloc] init];

	}
    
	else
	{
		//topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		//bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
	
    [cell textLabel].text = [_model menuOptionTitle:[indexPath row]];
	//topLabel.text = [NSString stringWithFormat:@"Cell at row %d.", [indexPath row]];
    //bottomLabel.text = [NSString stringWithFormat:@"Some other information."];
//	bottomLabel.text = [NSString stringWithFormat:@"Some other information.", [indexPath row]];
	
	//
	// Set the background and selected background images for the text.
	// Since we will round the corners at the top and bottom of sections, we
	// need to conditionally choose the images based on the row index and the
	// number of rows in the section.
	//
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
    
    
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"topAndBottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	else if (row == 0)
	{
        rowBackground = [UIImage imageNamed:@"button.png"];
		//rowBackground = [UIImage imageNamed:@"topRow.png"];
		selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"bottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"middleRow.png"];
		selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
	/*if ((row % 3) == 0)
	{
		cell.imageView.image = [UIImage imageNamed:@"imageA.png"];
	}
	else if ((row % 3) == 1)
	{
		cell.imageView.image = [UIImage imageNamed:@"imageB.png"];
	}
	else
	{
		cell.imageView.image = [UIImage imageNamed:@"imageC.png"];
	}
	*/
	return cell;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // end practice code
    
    
    /*  original code
    // Create table view cell
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString* text = [_model menuOptionTitle:[indexPath row]];
    UIColor* textColor= [UIColor blackColor];
    
    [[cell textLabel] setText:text];
    cell.textLabel.textColor = textColor;
	
    return cell;
     
     */
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
    
    
    // Depending upon user selection, create a new view controller
    
   // controllers, animate it so it looks pretty
    switch ([indexPath row])
    {
        case 0: // Challenges
            challengeViewController = [[UUChallengeViewController alloc]initWithModel:_model andProgramConstants:_programConstants];
            [[self navigationController] pushViewController:challengeViewController animated:TRUE];
            break;
        case 1: // Top Users
            topUsersViewController = [[UUTopUsersViewController alloc]initWithModel:_model];
            [[self navigationController] pushViewController:topUsersViewController animated:TRUE];
            break;
        case 2: // Teams
            teamCategoriesViewController = [[UUTeamCategoriesViewController alloc] initWithModel:_model andProgramConstants:_programConstants];
            [[self navigationController] pushViewController:teamCategoriesViewController animated:TRUE];
            break;
        case 3: // About
            aboutViewController = [[UUAboutViewController alloc] initWithModel:_model];
            [[self navigationController] pushViewController:aboutViewController animated:TRUE];
            break;
        case 4: // Sponsors
            sponsorsViewController = [[UUSponsorsViewController alloc] initWithModel:_model];
            [[self navigationController] pushViewController:sponsorsViewController animated:TRUE];
            break;
        case 5: // Profile  FB/Twitter
            profileViewController = [[UUProfileViewController alloc] initWithModel:_model andProgramConstants:_programConstants];
            [[self navigationController] pushViewController:profileViewController animated:TRUE];
            break;
        default:
            break;
    }// end switch
     
}// end didSelectRowAtIndexPath

- (CGFloat) tableView:(UITableView*)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}




@end

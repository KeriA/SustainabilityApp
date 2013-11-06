//
//  UUAppDelegate.m
//  Sustain
//
//  Created by Dan Willoughby on 4/10/13.
//  Developed by Keri Anderson  April 2013 - 
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

/***
 *
  
 Prepare a PNG image. It should be either 320x460 (if you have the status bar visible in your app) or 320x480 (if you hide it).
 Drag it into XCode into the Resources folder and add to your project
 Load the NIB file containing your UITableView into Interface Builder
 Open the library (Tools> Library), switch to the Media tab, and drag the image to the View, create a new UIImageView.
 Use the inspector to move and resize the image so it's at X=0, Y=0, Width=320, Height=480
 Put the UIImageView behind the UITableView (Layout > Send to Back)
 Save, Build and Go!
 Disappointingly, you won't be able to see your background. The UITableView's background is blocking us from seeing the UIImageView. There are three changes you need to make:
 
 In the Attributes Inspector, make sure the UITableView's "opaque" checkbox is unchecked!
 Set the UITableView's background color to transparent:
 
 tableView.backgroundColor = [UIColor clearColor];
 
 I hope this helps and solves your problem. It has worked for me and I have yet to find a more elegant way to display a background image for a UITableView.
 
 The advantage of my solution, in comparison with setting a background image directly on the UITableView, is that you can indent the table's content. I often wanted to do this to just show two or three table cells at the bottom of the screen.
 */



/************************************************************************************************************************/
/************************************************************************************************************************/
/************************************************************************************************************************/
/*  Development Issues that need to be completed
 *
 *  1.  <open>
 *
 *  2.  <open>
 */
/************************************************************************************************************************/
/************************************************************************************************************************/
/************************************************************************************************************************/

/************************************************************************************************************************/
/************************************************************************************************************************/
/************************************************************************************************************************/
/*  stopping point notes
 *
 *  9/3/13:  Worked on UUCreateUserController and View.  Issues that need to be addressed:
 *     1.  make the fb and twitter button backdrops clear
 *     2.  center the GreenU Sign Up label - see if this needs to be done somewhere else in the app for all navigation
 *     3.  Add UITextFields to the table view cells in the controller (move these fields from the view to controller)
 *     4.  learn how to launch an agreement page from text field agreement label
 *     5.  error checking of user input, send all info to the model to be sent to server
 *     6.  in the Sign In View, update so that it references Program constants for background view, fonts, etc.
 *     7.  Learn how backup project in Git
 *
 *  
 */
/************************************************************************************************************************/
/************************************************************************************************************************/
/************************************************************************************************************************/



#import "UUAppDelegate.h"

@implementation UUAppDelegate
{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor]; // for testing - should never show 
    
    // create the model so it can be passed into the controllers
    _model = [[UUSustainModel alloc] init];
    
    // create the program constants object - controllers and views will reference this for colors, fonts, etc.
    _programConstants = [[UUProgramConstants alloc] init];
    
    // set 'self' for the model delegate  so the model can inform us when the data is here
    [_model setDataFinishedLoadingDelegate:self];
    
    
    /* At this point, we need to check that the user has already created a login.  If this is the case
     * then locally (in the plist data) there will already be a key received from the server.  We then
     * bring the user directly to the main menu.  
     * If a key does not exist, then we bring up the login view */
    //if (true)  // for testing
    if ([_model hasUserKey])
    {
        // get the web data  - this fills the local data structures in the model, and will alert
        // 'self' as the delegate when startup data has been received
        [_model getStartupDataFromServer];
        
               
        
        _mainViewController = [[UUMainViewController alloc] initWithModel:_model andProgramConstants:_programConstants];
        
        //The navigation controller gives the bar across the top
        UINavigationController* mainNavigationController = [[UINavigationController alloc] initWithRootViewController:_mainViewController];
        [mainNavigationController.navigationBar setTintColor:[UIColor groupTableViewBackgroundColor]];
        
        
        // make the mainNavigationController the root controller
        [self.window setRootViewController: mainNavigationController];
        
        [self.window makeKeyAndVisible];
        
        // SVProgressHUD is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call [SVProgressHUD <method>]).
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        


    }
    else // no user key found, prompt the login screen
    {
        
        _signInViewController = [[UUSignInViewController alloc] initWithModel:_model andProgramConstants:_programConstants];
        
        //The navigation controller gives the bar across the top
        UINavigationController* mainNavigationController = [[UINavigationController alloc] initWithRootViewController:_signInViewController];
        [mainNavigationController.navigationBar setTintColor:[UIColor groupTableViewBackgroundColor]];
        
            
        // make the mainNavigationController the root controller
        [self.window setRootViewController: mainNavigationController];
        
        [self.window makeKeyAndVisible];
        
    }// end if modelHasUserKey
    
    

    return YES;

    
}// end application



/******************************************************************************************************
 *
 *                Data Finished loading delegate method  - for asynchronous calls
 *
 ******************************************************************************************************/
/***
 *  This method is called when the model informs us that it has received startup data from the server
 *
 */
- (void) dataFinishedLoading
{
    /*
    _mainViewController = [[UUMainViewController alloc] initWithModel:_model];
    
    //The navigation controller gives the bar across the top
    UINavigationController* mainNavigationController = [[UINavigationController alloc] initWithRootViewController:_mainViewController];
    
    // make the mainNavigationController the root controller 
    [self.window setRootViewController: mainNavigationController];
    
    
    [self.window makeKeyAndVisible]; */
    
    [SVProgressHUD dismiss];
    
    
}// end dataFinishedLoading



/******************************************************************************************************
 *
 *                              Auto Generated Focus Handler Methods
 *
 ******************************************************************************************************/
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

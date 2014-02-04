//
//  UUSustainModel.m
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//
//TODO:  write comments describing the structure of the database

#import "UUSustainModel.h"

@implementation UUSustainModel
{
    NSMutableDictionary* requestDictionary;
    int outstandingGetRequests; // used to keep track of when we have received all of our data from the server
    
    int _userServerKey;
    NSString* _userDisplayName;
    NSString* _userEmail;
    NSString* _userPassword;
    UIImage*  _userProfileImage;


}

@synthesize dataFinishedLoadingDelegate;
@synthesize registerParticipantDataReceivedDelegate;
@synthesize participantLoginDataReceivedDelegate;
@synthesize updateProfileResponseReceivedDelegate;
@synthesize getProfileDataReceivedDelegate;

@synthesize responseForRequestNewTeamReceivedDelegate;



/***
 *
 *      Constructor:  In the constructor we wish to first go to the
 *                    server and pull down startup data, then
 *                    load that data to our local data structure, 
 *                    as well as writing data to our local disc (using _rawData).
 *
 *                    For the most part, the program will operate locally
 */
- (id)init
{
    self = [super init];
    if (self)
    {
                        
        // fill the main menu options array
        _mainMenuOptions = [[NSMutableArray alloc] init];
        [_mainMenuOptions addObject:@"Challenges"];
        [_mainMenuOptions addObject:@"Top Users"];
        [_mainMenuOptions addObject:@"Teams"];
        [_mainMenuOptions addObject:@"About"];
        [_mainMenuOptions addObject:@"Sponsors"];
        [_mainMenuOptions addObject:@"Profile  FB/Twitter"];
        
        
        
        //instantiate the color pallet - used by the graphics designers for the images
        // we use these colors for backgrounds, button colors, bars, etc
        _tealColor          = [UIColor colorWithRed:(  0.0/255.0) green:(132.0/255.0) blue:(134.0/255.0) alpha:1.0];
        _seaFoamColor       = [UIColor colorWithRed:(117.0/255.0) green:(214.0/255.0) blue:(153.0/255.0) alpha:1.0];
        _burntOrangeColor   = [UIColor colorWithRed:(255.0/255.0) green:(139.0/255.0) blue:( 40.0/255.0) alpha:1.0];
        _mustardYellowColor = [UIColor colorWithRed:(247.0/255.0) green:(206.0/255.0) blue:(  0.0/255.0) alpha:1.0];
        _brightGreenColor   = [UIColor colorWithRed:( 52.0/255.0) green:(202.0/255.0) blue:( 52.0/255.0) alpha:1.0];
        _cherryRedColor     = [UIColor colorWithRed:(231.0/255.0) green:( 51.0/255.0) blue:( 41.0/255.0) alpha:1.0];

        
        
        
        //
        //  Temporary Code:  fill data structures from pList
        //  or local disc.  Remove when server is finished
        //
        [self getDataFromLocalDisc];
        
    }
    else //no object
    {
        return nil;
    }
    return self;
}// end contstructor

/*************************************************************************************************************
 *
 *          PList/ Local disc  Methods
 *
 *************************************************************************************************************/
/***
 *  This method checks the documents path for a user key (received previously from the server)
 *  If found and valid, returns TRUE, otherwise, returns FALSE
 *
 */
- (BOOL) hasUserKey
{
    //The path to the NSDocuments directory in the user domain, ie this is our documents path
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
    NSLog(@"Documents Path is: %@", documentsPath); // for testing
    
    // next load the teams
    _modelDataFilePath = [documentsPath stringByAppendingPathComponent:@"SignInInfo.plist"];
    // verifyFileExists:@"SignInInfo.plist";
    if ([[NSFileManager defaultManager] fileExistsAtPath:_modelDataFilePath] == FALSE)
    {
        
        // If the data file doesn't exist, copy it from the bundle.
        NSString* seedDataPath = [[NSBundle mainBundle] pathForResource:@"SignInInfo" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:seedDataPath toPath:_modelDataFilePath error:NULL];
        
    }
    
    NSLog(@"\nThe path is:  %@\n", _modelDataFilePath); // for testing
    // now that we know the data file exists, load it from the documents directory
    NSMutableArray* _rawData = [[NSMutableArray alloc] initWithContentsOfFile:_modelDataFilePath];
    
    // now abstract the user login, password, and server key from the array
    //NSString* _userLogin     = [[_rawData objectAtIndex:0] objectForKey:@"UserLogin"];
    //NSLog(@"User Login is: %@\n", _userLogin);  // for testing
   // NSString* _userPassword  = [[_rawData objectAtIndex:1] objectForKey:@"UserPassword"];
   /// NSLog(@"User Password is: %@\n", _userPassword);  // for testing
   // NSNumber* _userServerKey = [[_rawData objectAtIndex:2] objectForKey:@"UserServerKey"];
   // NSLog(@"User ServerKey is: %@\n", _userServerKey);  // for testing
    
    
   // [_signInInfoArray addObject:_userLogin];
    //[_signInInfoArray addObject:_userPassword];
    //[_signInInfoArray addObject:_userServerKey];
    //NSLog(@"%@", [_signInInfoArray description]);   // for testing  - output what the sign in data is
    

    // check with the server to make sure user info is valid
    

    return FALSE;  // this needs to be changed, for now, always return false
    
}// end hasUserKey


- (void) getDataFromLocalDisc
{
    //
    // Copy data from resources if it has not been copied already
    //
    
    //The path to the NSDocuments directory in the user domain, ie this is our documents path
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
    NSLog(@"Documents Path is: %@", documentsPath); // for testing
    
    // load the topics and their associated 3 challenges into "topicsArray" local data structure
    [self loadTopicsAndChallenges:documentsPath];
    
    // load the team categories
    [self loadTeamCategories:documentsPath];
    
      
    // next load the teams
    _modelDataFilePath = [documentsPath stringByAppendingPathComponent:@"Teams.plist"];
    // verifyFileExists:@"Teams.plist";
    if ([[NSFileManager defaultManager] fileExistsAtPath:_modelDataFilePath] == FALSE)
    {
        
        // If the data file doesn't exist, copy it from the bundle.
        NSString* seedDataPath = [[NSBundle mainBundle] pathForResource:@"Teams" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:seedDataPath toPath:_modelDataFilePath error:NULL];
        
    }
    
    
    //NSLog(@"\nThe path is:  %@\n", _modelDataFilePath); // for testing
    // now that we know the data file exists, load it from the documents directory
    _teamsArray = [[NSMutableArray alloc] initWithContentsOfFile:_modelDataFilePath];
    //NSLog(@"%@", [_teamsArray description]);   // for testing  - output what the raw data is
    
    

    
    // fill the teams array
    //[self fillTeamsArray:_rawDataArray];
    

    //user display info  - THIS NEEDS TO BE CHANGED!!!!!!!
    _userProfileImage = [UIImage imageNamed:@"RedSkeleton.png"];
    
    
}// end getDataFromLocalDisc

/***
 *  Load the topics and their associated challenges into the 
 *  local data structure "topicsArray".
 *
 *  The topicsArray is laid out similarly as to the Topic.plist.
 *
 *
 */
- (void) loadTopicsAndChallenges:(NSString*)documentsPath
{
    /****NOTE  - this is currently hard-coded in.  Needs to be changed when server is written  *****/
    // for now, just load the  _previousTopicsArray, and _currentTopicDictionary
    
    //NSMutableArray* _previousTopicsArray;  // list of topics with their associated challenges
    //NSMutableDictionary* _currentTopic;    // a dicitonary of the current month's topic and its associated challenges
    

    _currentTopic = [[NSMutableDictionary alloc] init];
    [_currentTopic setObject:@"August" forKey:@"month"];
    [_currentTopic setObject:@"2013" forKey:@"year"];
    [_currentTopic setObject:@"Green Communities and Businesses" forKey:@"topic"];
    
    
    // add a dictionary for each of the past months and challenges to this array
    _previousTopicsArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary* janDict = [[NSMutableDictionary alloc] init];
    [janDict setObject:@"January" forKey:@"month"];
    [janDict setObject:@"2013" forKey:@"year"];
    [janDict setObject:@"Green New Year" forKey:@"topic"];
    [_previousTopicsArray addObject:janDict];

    NSMutableDictionary* febDict = [[NSMutableDictionary alloc] init];
    [febDict setObject:@"February" forKey:@"month"];
    [febDict setObject:@"2013" forKey:@"year"];
    [febDict setObject:@"Reusable Thinking" forKey:@"topic"];
    [_previousTopicsArray addObject:febDict];
    
    NSMutableDictionary* marDict = [[NSMutableDictionary alloc] init];
    [marDict setObject:@"March" forKey:@"month"];
    [marDict setObject:@"2013" forKey:@"year"];
    [marDict setObject:@"Green Products" forKey:@"topic"];
    [_previousTopicsArray addObject:marDict];

    NSMutableDictionary* aprDict = [[NSMutableDictionary alloc] init];
    [aprDict setObject:@"April" forKey:@"month"];
    [aprDict setObject:@"2013" forKey:@"year"];
    [aprDict setObject:@"Earth Day" forKey:@"topic"];
    [_previousTopicsArray addObject:aprDict];
    
    NSMutableDictionary* mayDict = [[NSMutableDictionary alloc] init];
    [mayDict setObject:@"May" forKey:@"month"];
    [mayDict setObject:@"2013" forKey:@"year"];
    [mayDict setObject:@"Water" forKey:@"topic"];
    [_previousTopicsArray addObject:mayDict];
    
    NSMutableDictionary* junDict = [[NSMutableDictionary alloc] init];
    [junDict setObject:@"June" forKey:@"month"];
    [junDict setObject:@"2013" forKey:@"year"];
    [junDict setObject:@"Power Down for Summer" forKey:@"topic"];
    [_previousTopicsArray addObject:junDict];

    NSMutableDictionary* julDict = [[NSMutableDictionary alloc] init];
    [julDict setObject:@"July" forKey:@"month"];
    [julDict setObject:@"2013" forKey:@"year"];
    [julDict setObject:@"Air Quality" forKey:@"topic"];
    [_previousTopicsArray addObject:julDict];
    
    /***  old code when using a local plist
    _modelDataFilePath = [documentsPath stringByAppendingPathComponent:@"Topic.plist"];
    
    //   verifyFileExists:@"TeamCategories.plist";
    if ([[NSFileManager defaultManager] fileExistsAtPath:_modelDataFilePath] == FALSE){        
        // If the data file doesn't exist, copy it from the bundle.
        NSString* seedDataPath = [[NSBundle mainBundle] pathForResource:@"Topic" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:seedDataPath toPath:_modelDataFilePath error:NULL];
        
    }
    
    // now that we know the data file exists, load it from the documents directory
    NSMutableArray* _rawData = [[NSMutableArray alloc] initWithContentsOfFile:_modelDataFilePath];
    
    // we want to make sure that the topics are stored in chronological order, meaning, the month furthest
    // back is the first month, and the most current month is the last in the list
    // we will put the current month in its own data structure for convenient access
    _previousTopicsArray = [[NSMutableArray alloc] init];
    _currentTopic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < ([_rawData count] - 1); i++){
        [_previousTopicsArray addObject: [_rawData objectAtIndex:i]];
    }
    
    _currentTopic = [_rawData objectAtIndex:[_rawData count] - 1];

    ****/
    
}// end loadTopicsAndChallenges

/***
 *  Load the team categories into the 
 *  local data structure "_teamCategoryArray".
 *
 */
- (void) loadTeamCategories:(NSString*)documentsPath
{
    _modelDataFilePath = [documentsPath stringByAppendingPathComponent:@"TeamCategories.plist"];
    
    //   verifyFileExists:@"Topic.plist";
    if ([[NSFileManager defaultManager] fileExistsAtPath:_modelDataFilePath] == FALSE)
    {
        
        // If the data file doesn't exist, copy it from the bundle.
        NSString* seedDataPath = [[NSBundle mainBundle] pathForResource:@"TeamCategories" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:seedDataPath toPath:_modelDataFilePath error:NULL];
        
    }
    
    // now that we know the data file exists, load it from the documents directory
     _teamsArray = [[NSMutableArray alloc] initWithContentsOfFile:_modelDataFilePath];

    
        
}// end loadTeamCategories



/*************************************************************************************************************
 *
 *          Server  Methods
 *
 *************************************************************************************************************/
/***
 *  This method attempts to get initial data from the Server, and alerts the
 *  appDelegate when all data has been received (releases the loading page)
 *
 */
- (void)getStartupDataFromServer
{    
    //
    // temporary:  used to simulate waiting for server data
    // TODO:  take this out
    //
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
    
    
    // alert the app delegate that the data has loaded
    //[[self dataFinishedLoadingDelegate]dataFinishedLoading];

    
}// end StartupDataFromServer


//
// temporary:  used to simulate waiting for server data
// TODO:  take this out
//
- (void)timerFired
{
    // alert the app delegate that the data has loaded
    [[self dataFinishedLoadingDelegate]dataFinishedLoading];
    

}




/******************************************************************************************************
 *
 *                              sendMessageToServer
 *
 ******************************************************************************************************/
/**
 *  This method sends both GET and POST messages to the server.  
 *
 *  Parameters:  serverMethod:   (int) this is an int that is #defined in the .h file for consistency
 *                               each method will need its own unique int
 *               action:  (int)  0 = POST, 1 = GET
 *
 *               dataDictionary:  the data that will be sent to the server
 *
 *       Note:  each method that calls this will have a specified call back function in the code
 *
 */
- (void) sendMessageToServer:(int)serverMethod withDataDictionary:(NSMutableDictionary*)dataDictionary
{
    // step 1:  create the url and url request - adding the index at the end specifies to the server what index we are accessing
    NSString* methodString = @"";
    NSString* dataString = @"";
   
    
    int action = POST; // default

    
    // set the request string
    switch (serverMethod)  //serverMethod constants declared in NetworkConstants.h
    {
        case (registerParticipant):
        {
            methodString = [NSString stringWithFormat:@"%@", registerParticipantRequest];
            action = POST;
            
            // set up the data to use
            NSString* username = [dataDictionary objectForKey:@"displayName"];
            NSString* email = [dataDictionary objectForKey:@"email"];
            NSString* password = [dataDictionary objectForKey:@"password"];
            
            dataString = [NSString stringWithFormat:@"{ 'UserName' : '%@', 'Email' : '%@', 'Password' : '%@' }", username, email, password];
                        
            break;
        }
        case (participantLogin):
        {
            methodString = [NSString stringWithFormat:@"%@", participantLoginRequest];
            action = POST;
            
            // set up the data to use
            NSString* email = [dataDictionary objectForKey:@"email"];
            NSString* password = [dataDictionary objectForKey:@"password"];
            
            dataString = [NSString stringWithFormat:@"{ 'Email' : '%@', 'Password' : '%@' }", email, password];
            
            break;
        }
        case (updateUserProfile):
        {
            
            methodString = [NSString stringWithFormat:@"%@", updateUserProfileRequest];
            action = POST;
            /*  how to encode decode an image into base64 string
            // This will load NeonSpark image &amp; *data* variable is holding data of image
            NSData *data = [NSData dataWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"Neon Spark" ofType:@"png"]
                            ];
            // using base64StringFromData method, we are able to convert data to string
            NSString *str = [NSString base64StringFromData:data length:[data length]];
            
            // log the base64 encoded string
            NSLog(@"Base64 Encoded string is %@",str);
            
            // using base64DataFromString
            NSData *dataFromBase64=[NSData base64DataFromString:str];
            
            // log the decoded NSData length
            NSLog(@"Data length is %i",[dataFromBase64 length]);*/
            
            //PUT THIS BACK IN!!!!!!!!!!!!!!!
            //int userKey = [self getUserKey];
            //NSString* userKeyString = @"10002";
            //UIImage* userImage = [dataDictionary objectForKey:@"userImage"];
            //NSString* password = [dataDictionary objectForKey:@"password"];
            //NSString* username = [dataDictionary objectForKey:@"displayName"];
            //int teamKey = [[dataDictionary objectForKey:@"teamKey"]intValue ];
            //NSString* teamKeyString = @"0";
            
            // tEMPORARY CODE  for testing
            //UIImage* userImage = [UIImage imageNamed:@"Oscar.png"];
            //UIImage*userImage = [UIImage imageNamed:@"Oscar300x300.png"];
            UIImage*userImage = [UIImage imageNamed:@"Oscar200x200.png"];
            //UIImage*userImage = [UIImage imageNamed:@"FacebookIconSmall.png"];
            //int userKey = 10004;
            
             //Update participant password only:
            //{“UserKey” : 10004,
            //“UserName” : “”,
            //“TeamKey” : 0,
            //“Password” : “YourNewPassword”,
            //“UserImage” : “” }
            NSString* userKeyString = @"10004";
            NSString* username = @"";
            NSString* teamKeyString = @"0";
            NSString* password = @"";
            //NSString* imageString = @"";
                        
            //convert the image to Base64 to be sent as JSON string
            NSData* dataImage = UIImagePNGRepresentation(userImage);
            NSString* imageString = [NSString base64StringFromData:dataImage length:[dataImage length]];
            //NSString*imageString = @"This is a test";
            dataString = [NSString stringWithFormat:@"{ 'UserKey' : '%@', 'UserName' : '%@', 'TeamKey' : '%@', 'Password' : '%@', 'UserImage' : '%@' }",
                          userKeyString, username, teamKeyString, password, imageString];
            
            
            
            NSLog(@"%@", dataString); //for testing
            
            break;
            
        }
        case (getUserProfile):
        {
            methodString = [NSString stringWithFormat:@"%@", getUserProfileRequest];
            action = GET;
            int userKey = [self getUserKey];
            dataString = [NSString stringWithFormat:@"{ 'UserKey' : '%d' }", userKey];

            break;
        }
        case (forgotPassword):
        {
            break;
        }
        case (getAllTeams):
        {
            break;
        }
        case (getTeamsByType):
        {
            methodString = [NSString stringWithFormat:@"%@", getTeamsByTypeRequest];
            action = GET;
            
            NSString* teamType = [dataDictionary objectForKey:@"teamCategory"];
            
            dataString = [NSString stringWithFormat:@"{ '%@' }", teamType];
            break;
        }
        case (requestNewTeam):
        {
            methodString = [NSString stringWithFormat:@"%@", requestNewTeamRequest];
            action = POST;
            
            // set up the data to use
            NSString* userKeyString = [NSString stringWithFormat:@"%d", _userServerKey];
            NSString* teamName = [dataDictionary objectForKey:@"newTeamName"];
            NSString* teamCategory = [dataDictionary objectForKey:@"newTeamType"];
            
            dataString = [NSString stringWithFormat:@"{ 'UserKey' : '%@', 'TeamName' : '%@', 'TeamCategory' : '%@' }", userKeyString, teamName, teamCategory];
            
            break;
        }
        default:
        {}
    }// end switch
    
    
    // we are using a mutable request so we can make changes to our request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[UUNetworkBaseUrl stringByAppendingString:methodString]]];
    
    // set the request method
    switch (action)
    {
        case (POST):
        {
            [request setHTTPMethod:@"POST"];
            break;
        }
        case (GET):
        {
            [request setHTTPMethod:@"GET"];
            break;
        }
       
        default:
        {}
    }// end switch
            
            
            
    // step 2:  encode thet data to send
    NSData* requestData = [NSData dataWithBytes:[dataString UTF8String] length:[dataString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    

    // STEP 2)  Create  PList Data so we can make a request with data
    // In order to send the dictionary, we have to encode it as well.  This server accepts PList data.
    // In order to turn the dictionary into a PLIST, use the class NSPropertyListSerialization,
    // and its static method that will turn data from a property list into an XML format property
    // list  (ignore errors)
    // This call returns NSData.
   // NSData* requestData = [NSPropertyListSerialization dataFromPropertyList:dataDictionary format:NSPropertyListXMLFormat_v1_0 errorDescription:NULL];
    
    // often times when we are making requests for server data, we need to specify the type of data
    // we are sending, because the server needs to interpret that data.  Without this next line of
    // code, the server gave an error "Invalid content type".  We specified JSON.    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:requestData];

    
    // STEP 3)  - make a connection - send the request asynchronously 
    // This is where we actually make the request.
    // By default, the request made will be a 'GET' request (should get "This server...POST requests" as shown
    // in the browser.
    // the "NSData* responseData gets the data out of the URL connection - Note: it is returned as "NSData"
     
    [request setTimeoutInterval:30.0f]; // if no interaction after 30 seconds, connection dies
    

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         // set the callback method
         switch (serverMethod)
         {
             case (registerParticipant):
             {
                 [self responseForRegisterParticipantReceived:data withError:error];
                 break;
             }
             case (participantLogin):
             {
                 [self responseForLoginParticipantReceived:data withError:error];
                 break;
             }
             case (updateUserProfile):
             {
                 [self responseForUpdateProfileReceived:data withError:error];
                 break;
             }
             case (getUserProfile):
             {
                 [self responseForGetProfileReceived:data withError:error];
                 break;
             }
             case (forgotPassword):
             {
                 [self responseForForgotPasswordReceived:data withError:error];
                 break;
             }
             case (getAllTeams):
             {
                 [self responseForGetAllTeamsReceived:data withError:error];
                 break;
             }
             case (getTeamsByType):
             {
                 [self responseForGetTeamsByTypeReceived:data withError:error];
                 break;
             }
             case (requestNewTeam):
             {
                 [self responseForRequestNewTeamReceived:data withError:error];
                 break;
             }
             default:
             {}
         }
         
     } // end completion handler
     ];
    
    
}// end sendMessageToServer



/******************************************************************************************************
 *
 *                              server response callback methods
 *
 ******************************************************************************************************/
-(void) responseForRegisterParticipantReceived: (NSData*)responseData withError:(NSError*)error
{
    //NSLog(@"Error:  %@", error); // for testing
    //NSLog(@"Response data:  %@", responseData); // for testing
    int responseType = 0;
    
    if(error == NULL) //everything ok
    {
        // the data sent back to us is a dictionary with two keys: Message and UseKey
        NSError* jsonError;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        
        int responseMessage = [[responseDictionary objectForKey:(@"Message")]intValue];
        int userKey         = [[responseDictionary objectForKey:(@"UserKey")]intValue];
        
        //NSLog(@"Response Dictionary is: %@\n", responseDictionary); // for testing
        //NSLog(@"responseMessage is: %d\n", responseMessage);        // for testing
        //NSLog(@"userKey         is: %d\n", userKey);                // for testing

        // notes:
        //   message values:
             //  1000:  success:  participant successfully logged in
             //  1001:  failure:  invalid email format
             //  1002:  failure:  invalid password format
             //  1003:  failure:  invalid username format
             //  1004:  failure:  email already exists in database≈ß
             //  9999:  failure:  general failure
        //   userkey values:
             //  100001:   some user key starting with 100001 if successful
             //  0:        0 upon failure
        
        
        if (responseMessage == 1000)//successful register  ??????? is this supposed to be responsemesage?
        {
            _userServerKey = userKey; //store the key
        }
        
        responseType = responseMessage;
        
    }
    else // error not null
    {
        responseType = 9999; // just set to general server error
    }
    
    // inform the CreateUserViewController that server has replied back
    [[self registerParticipantDataReceivedDelegate] registerParticipantServerDataReceived:responseType];
    
}// end responseForRegisterParticipantReceived


-(void) responseForLoginParticipantReceived:(NSData*)responseData withError:(NSError*)error
{
    int responseType = 0;
    
    if(error == NULL) //everything ok
    {
        // the data sent back to us is a dictionary with two keys: Message and UseKey
        NSError* jsonError;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        NSLog(@"Response Dictionary is: %@\n", responseDictionary); // for testing
        
        int responseMessage = [[responseDictionary objectForKey:(@"Message")]intValue];
        int userKey         = [[responseDictionary objectForKey:(@"UserKey")]intValue];
        NSString* userName  = [responseDictionary objectForKey:(@"UserName")];
        
       
        //NSLog(@"responseMessage is: %d\n", responseMessage);        // for testing
        //NSLog(@"userKey         is: %d\n", userKey);                // for testing
        //NSLog(@"userName        is: %d\n", userName);               // for testing
        
        // notes:
        //   message values:
        //  1000:  success:  participant successfully logged in
        //  1001:  failure:  invalid email format
        //  1005:  failure:  login failure
        //  9999:  failure:  general failure
        //   userkey values:
        //  100001:   some user key starting with 100001 if successful
        //  0:        0 upon failure
        
        
        if (responseMessage == 1000)//successful register
        {
            _userServerKey = userKey; //store the key
            _userDisplayName = userName;
        }
        
        responseType = responseMessage;
        
    }
    else // error not null
    {
        responseType = 9999; // just set to general server error
    }
    
    // inform the CreateUserViewController that server has replied back
    [[self participantLoginDataReceivedDelegate] ParticipantLoginServerDataReceived:responseType];
    
    
}// end responseForLoginParticipantReceived


-(void) responseForUpdateProfileReceived:(NSData*)responseData withError:(NSError*)error
{
    int responseType = 0;
    
    if(error == NULL) //everything ok
    {
        // the data sent back to us is a dictionary with two keys: Message and UseKey
        NSError* jsonError;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        NSLog(@"Response Dictionary for update profile is: %@\n", responseDictionary); // for testing
        
        int responseMessage = [[responseDictionary objectForKey:(@"Message")]intValue];
                
        
        //NSLog(@"responseMessage is: %d\n", responseMessage);        // for testing
        //NSLog(@"userKey         is: %d\n", userKey);                // for testing
        //NSLog(@"userName        is: %d\n", userName);               // for testing
        
        // notes:
        //   message values:
        //  1000:  success:  participant successfully logged in
        //  1001:  failure:  invalid email format
        //  1005:  failure:  login failure
        //  9999:  failure:  general failure
        //   userkey values:
        //  100001:   some user key starting with 100001 if successful
        //  0:        0 upon failure
        
        
        if (responseMessage == 1000)//successful register
        {
            //something here
        }
        
        responseType = responseMessage;
        
    }
    else // error not null
    {
        responseType = 9999; // just set to general server error
    }
    
    // inform the ProfileViewController that server has replied back
    [[self updateProfileResponseReceivedDelegate] UpdateProfileResponseReceived:responseType];
    
    
}// end responseForUpdateProfileReceived

-(void) responseForGetProfileReceived:(NSData*)responseData withError:(NSError*)error
{
    
    /*  how to encode decode an image into base64 string
     // This will load NeonSpark image &amp; *data* variable is holding data of image
     NSData *data = [NSData dataWithContentsOfFile:
     [[NSBundle mainBundle] pathForResource:@"Neon Spark" ofType:@"png"]
     ];
     // using base64StringFromData method, we are able to convert data to string
     NSString *str = [NSString base64StringFromData:data length:[data length]];
     
     // log the base64 encoded string
     NSLog(@"Base64 Encoded string is %@",str);
     
     // using base64DataFromString
     NSData *dataFromBase64=[NSData base64DataFromString:str];
     
     // log the decoded NSData length
     NSLog(@"Data length is %i",[dataFromBase64 length]);*/

    int responseType = 0;
    NSMutableDictionary* receivedDataDictionary;
    
    if(error == NULL) //everything ok
    {
        // the data sent back to us is a dictionary with two keys: Message and UseKey
        NSError* jsonError;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        NSLog(@"Response Dictionary for update profile is: %@\n", responseDictionary); // for testing
        
        int responseMessage = [[responseDictionary objectForKey:(@"Message")]intValue];
        NSString* userEmail = [responseDictionary objectForKey:(@"UserEmail")];
        NSString* userImage = [responseDictionary objectForKey:(@"UserImage")];
        NSString* userPass  = [responseDictionary objectForKey:(@"Password")];
        NSString* userName  = [responseDictionary objectForKey:(@"Username")];
        int  teamKey        = [[responseDictionary objectForKey:(@"TeamKey")]intValue];
        
          
        if (responseMessage == 1000)//successful register
        {
            //transfer the string image into a real image
            NSData* dataFromString = [NSData base64DataFromString:userImage];
            
            //convert the Base64 back to an image
            UIImage* newUserImage = [UIImage imageWithData:dataFromString];
            
            
            //NSLog(@"PASSWORD, EMAIL, and DISPLAY NAME ALL GOOD\n"); // for testing
            NSArray* objects = [NSArray arrayWithObjects:  newUserImage, nil];
            NSArray* keys    = [NSArray arrayWithObjects:@"profileImage", nil];
            receivedDataDictionary = [[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
            
        }
        
        responseType = responseMessage;
        
    }
    else // error not null
    {
        responseType = 9999; // just set to general server error
    }
    
    // inform the ProfileViewController that server has replied back
    [[self getProfileDataReceivedDelegate] GetProfileDataReceived:receivedDataDictionary];
    
    
}// end responseForGetProfileReceived


-(void) responseForForgotPasswordReceived:(NSData*)responseData withError:(NSError*)error
{
}//end response forgot password

-(void) responseForGetAllTeamsReceived:(NSData*)responseData withError:(NSError*)error
{
}//end response get all teams

-(void) responseForGetTeamsByTypeReceived:(NSData*)responseData withError:(NSError*)error
{
    
    int responseType = 0;
    
    if(error == NULL) //everything ok
    {
        // the data sent back to us is a dictionary with two keys: Message and UseKey
        NSError* jsonError;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        
        int responseMessage = [[responseDictionary objectForKey:(@"Message")]intValue];
        NSObject* responseArray         = [responseDictionary objectForKey:(@"TeamList")];
       
        responseType = responseMessage;
        
    }
    else // error not null
    {
        responseType = 9999; // just set to general server error
    }
    
    // inform the CreateUserViewController that server has replied back
    [[self responseForRequestNewTeamReceivedDelegate] responseDataForRequestNewTeamReceived:responseType];
}//end response get teams by type

-(void) responseForRequestNewTeamReceived:(NSData*)responseData withError:(NSError*)error
{
    int responseType = 0;
    
    if(error == NULL) //everything ok
    {
        // the data sent back to us is a dictionary with two keys: Message and UseKey
        NSError* jsonError;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        
        int responseMessage = [[responseDictionary objectForKey:(@"Message")]intValue];        
        responseType = responseMessage;
        
    }
    else // error not null
    {
        responseType = 9999; // just set to general server error
    }
    
    // inform the CreateUserViewController that server has replied back
    [[self responseForRequestNewTeamReceivedDelegate] responseDataForRequestNewTeamReceived:responseType];
    
}//end request new team





/******************************************************************************************************
 *
 *                              scale an image to fit the phone frame
 *
 ******************************************************************************************************/
- (UIImage*) scaleImage:(UIImage*)image toSize:(CGSize)newSize
{
    
    UIImage *newImage = nil;
    
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = newSize.width;
    CGFloat targetHeight = newSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, newSize) == NO)
    {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor < heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor > heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(newSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [image drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
    
}// end scaleImage



/******************************************************************************************************
 *
 *                     Custom Convenience Methods  (Mostly getters and setters)
 *
 ******************************************************************************************************/

- (int)numberOfMainMenuOptions
{
    return [_mainMenuOptions count];
}

- (NSString*) menuOptionTitle:(int)row
{
    return [_mainMenuOptions objectAtIndex:row];
}

- (int) numberOfTeamCategories
{
    return [_teamCategoryArray count];
}

- (NSString*) nameOfTeamCategory:(int)catKey
{
    NSDictionary* temp = [_teamCategoryArray objectAtIndex:catKey];
    NSString* catName = (NSString*)[temp objectForKey:@"TeamCategory_Name"];
    
    return catName;
}

- (NSString*) previousTopicTitle: (int)index
{
    NSDictionary* topicDic = [_previousTopicsArray objectAtIndex:index];    
    NSString* topic = [topicDic objectForKey:@"topic"];
    NSString* month = [topicDic objectForKey:@"month"];
    NSString* year  = [topicDic objectForKey:@"year"];
    
    NSString* title = [NSString stringWithFormat:@"%@ (%@ %@)", topic, month, year];
    
    return title;
    
}

- (int)numberOfPreviousChallenges
{
    return [_previousTopicsArray count];
}

//*****  color getters  ****//
- (UIColor*) tealColor          { return _tealColor; }
- (UIColor*) seaFoamColor       { return _seaFoamColor; }
- (UIColor*) burntOrangeColor   { return _burntOrangeColor; }
- (UIColor*) mustardYellowColor { return _mustardYellowColor; }
- (UIColor*) brightGreenColor   { return _brightGreenColor; }
- (UIColor*) cherryRedColor     { return _cherryRedColor; }

- (void) storeUserName: (NSString*)userName 
{
    _userDisplayName = userName;
    
}

- (void) storeEmail:(NSString*)email andPassword: (NSString*)password
{
    _userEmail = email;
    _userPassword = password;
    
}

- (NSString*) getUserName
{
    return _userDisplayName;
}

- (UIImage*) getProfileImage
{
    
    return _userProfileImage;
    
}

- (int) getUserKey
{
    return _userServerKey;
}


@end

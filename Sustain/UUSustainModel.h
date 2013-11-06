//
//  UUSustainModel.h
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkConstants.h"
#import "NSStrinAdditions.h"







@protocol UUDataFinishedLoadingDelegate
@required
-(void) dataFinishedLoading;
@end 

// Register Participant
@protocol UURegisterParticipantDataReceivedDelegate
@required
-(void) registerParticipantServerDataReceived:(int)responseCase;
@end

// Participant Login
@protocol UUParticipantLoginDataReceivedDelegate
@required
-(void) ParticipantLoginServerDataReceived:(int)responseCase;
@end



@interface UUSustainModel : NSObject
{
    NSString* _modelDataFilePath;
    
    NSMutableData* _responseData;  // used to hold the data returned from the server
    
    //
    // local data structures  - these will be arrays of dictionaries
    //
    NSMutableArray* _mainMenuOptions; // used to load the main menu options
    
    NSMutableArray* _rawDataArray;  // used to hold the initially pulled data from the server
    
    NSMutableArray* _signInInfoArray;      // holds the user login, password, and server key
    
    NSMutableArray* _teamCategoryArray;    // holds the list of category types  (ie schools, businesses, etc)
    NSMutableArray* _teamsArray;           // list of all the current avaiable teams
    NSMutableArray* _previousTopicsArray;  // list of topics with their associated challenges
    NSMutableDictionary* _currentTopic;    // a dicitonary of the current month's topic and its associated challenges
    
    
    
    
    
    UIColor* _tealColor;
    UIColor* _seaFoamColor;
    UIColor* _burntOrangeColor;
    UIColor* _mustardYellowColor;
    UIColor* _brightGreenColor;
    UIColor* _cherryRedColor;
    
}

//delegate should be a weak reference
@property (nonatomic, weak) id dataFinishedLoadingDelegate;
@property (nonatomic, weak) id registerParticipantDataReceivedDelegate;
@property (nonatomic, weak) id participantLoginDataReceivedDelegate;

// methods
- (void) getStartupDataFromServer;
- (void) getDataFromLocalDisc;
- (BOOL) hasUserKey;
- (UIImage*) scaleImage:(UIImage*)image toSize:(CGSize)newSize;

//- (void) fillTeamsArray:(NSMutableArray*)rawTeams;

- (void) sendMessageToServer:(int)serverMethod withDataDictionary:(NSMutableDictionary*)dataDictionary;



// convenience getters/setters
- (int) numberOfMainMenuOptions;
- (NSString*) menuOptionTitle:(int)row;
- (int) numberOfTeamCategories;
- (NSString*) nameOfTeamCategory:(int)catKey;
- (NSString*) previousTopicTitle: (int)index;
- (int)numberOfPreviousChallenges;
- (void) storeUserName: (NSString*)userName;
- (void) storeEmail:(NSString*)email andPassword: (NSString*)password;
- (NSString*) getUserName;


- (UIColor*) tealColor;
- (UIColor*) seaFoamColor;
- (UIColor*) burntOrangeColor;
- (UIColor*) mustardYellowColor;
- (UIColor*) brightGreenColor;
- (UIColor*) cherryRedColor;



@end

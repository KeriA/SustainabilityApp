//
//  NetworkConstants.h
//  Sustain
//
//  Created by Keri Anderson on 4/14/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//
/***
 *
 *  This header file is used to give easy access to network constants, as they
 *  are prone to change.  
 *
 */

#warning API key may be invalid
#define UUNetworkBaseUrl @"https://dotnet.slcgov.com/mayor/sustainabilitypledge/api/challenges" // this is for asynchronous calls

//  define the server method params here for ease and consistency of use
//  and ease in making server requests
#define POST 0
#define GET  1

#define registerParticipant 0
#define participantLogin 1
#define updateUserProfile 2
#define getUserProfile 3
#define forgotPassword 4
#define getAllTeams 5
#define getTeamsByType 6
#define requestNewTeam 7



// Request Types  (used in combination with the base url)
#define registerParticipantRequest @"/registerparticipant"
#define participantLoginRequest @"/participantlogin"
#define updateUserProfileRequest @"/updateprofile"
#define getUserProfileRequest @"/getprofile"
#define forgotPasswordRequest @"/forgotpassword"
#define getAllTeamsRequest @"/getallteams"
#define getTeamsByTypeRequest  @"/getteamsbytype"
#define requestNewTeamRequest @"/requestnewteam"


//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!take this out!!!!!!!!!!!!!!!!!!!!!!
#define CSNetworkInTheatersRequest @"/lists/movies/in_theaters.json"
#define CSNetworkOpeningRequest @"/lists/movies/opening.json"
#define CSNetworkUpcomingRequest @"/lists/movies/upcoming.json"


// URL Creation Macros  (helper macros)
// we want to return the entire string formatted nicely
// base url  followed by request type, followed by "?apikey=" and then the api key
// in this macro, we pass in the request type
// the final result is the entire url
#define CSNetworkGetRequestUrl(requestType) [NSString stringWithFormat:@"%@%@?apikey=%@", CSNetworkBaseUrl, requestType, CSNetworkApiKey]


// create a new macro.  Kevin went back to the RottenTomatoes API for movie clips to see what
// the reqeust was supposed to look like - see screenshot 8  (building a url here )
#define CSNetworkGetMovieClipsUrl(movieId) [NSString stringWithFormat:@"%@/movies/%@/clips.json?apikey=%@", CSNetworkBaseUrl, movieId, CSNetworkApiKey]
//
//  UUProgramConstants.m
//  Sustain
//
//  Created by Keri Anderson on 9/3/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUProgramConstants.h"


// currently used fonts
/**
 *  To use external fonts, the .otf files have to be brought into the project, 
 *  as well as the Sustain-Info.plist has to be updated to list the fonts
 *  under the 'Fonts provided by application' array
 *
 *  Update:  we switched back to system fonts at this looked better in the
 *  app
 */
//#define standardFontString @"GillSansMTPro-Book"
//#define boldFontString     @"GillSansMTPro-BoldCondensed"
//#define shadowedFontString @"GillSansShadowedMTPro-Light"



/// may have to taake this out
#define gillSansLightItalic @"GillSans-LightItalic"
#define gilSansBoldItalic @"GillSans-BoldItalic"
#define gillSansLight @"GillSans-Light"
#define gillSansBold @"GillSans-Bold"
#define gillSansItalic @"GillSans-Italic"
/// end take out


// background image
#define backgroundImageString @"background.png"

// button month images
#define januaryImageString   @"januaryChallengeImage.png"
#define februaryImageString  @"februaryChallengeImage.png"
#define marchImageString     @"marchChallengeImage.png"
#define aprilImageString     @"aprilChallengeImage.png"
#define mayImageString       @"mayChallengeImage.png"
#define juneImageString      @"juneChallengeImage.png"
#define julyImageString      @"julyChallengeImage.png"
#define augustImageString    @"augustChallengeImage.png"
#define septemberImageString @"septemberChallengeImage.png"
#define octoberImageString   @"octoberImageString.png"
#define novemberImageString  @"novemberImageString.png"
#define decemberImageString  @"decemberImageString.png"

#define janChallengeString @"Green New Year"
#define febChallengeString @"Reusable Thinking"
#define marChallengeString @"Green Products"
#define aprChallengeString @"Earth Day - Enjoy the Trees"
#define mayChallengeString @"Water"
#define junChallengeString @"Power Down for Summer"
#define julChallengeString @"Air Quality"
#define augChallengeString @"Green Communities & Businesses"
#define sepChallengeString @"Idle Free & Transportation"
#define octChallengeString @"Food for Thought"
#define novChallengeString @"Recycling"
#define decChallengeString @"Winterize Your Home"





#define january      1
#define february     2
#define march        3
#define april        4
#define may          5
#define june         6
#define july         7
#define august       8
#define septemenber  9
#define october     10
#define november    11
#define december    12

/**
 *  The purpose of this class is to have one central place that holds constants and
 *  objects repeatedly used by all of the controllers.   
 *
 *  Part of the motivtation for this is that the fonts this project will use could
 *  change as we experiment with what fonts we like best.  It is really easy
 *  to change them in one place for the entire project. 
 *
 *
 */

@implementation UUProgramConstants

- (id)init
{
    self = [super init];
    if (self)
    {
        
        //instantiate the color palet - used by the graphics designers for the images
        // we use these colors for backgrounds, button colors, bars, etc
        _tealColor          = [UIColor colorWithRed:(  0.0/255.0) green:(132.0/255.0) blue:(134.0/255.0) alpha:1.0];
        _seaFoamColor       = [UIColor colorWithRed:(117.0/255.0) green:(214.0/255.0) blue:(153.0/255.0) alpha:1.0];
        _burntOrangeColor   = [UIColor colorWithRed:(255.0/255.0) green:(139.0/255.0) blue:( 40.0/255.0) alpha:1.0];
        _mustardYellowColor = [UIColor colorWithRed:(247.0/255.0) green:(206.0/255.0) blue:(  0.0/255.0) alpha:1.0];
        _brightGreenColor   = [UIColor colorWithRed:( 52.0/255.0) green:(202.0/255.0) blue:( 52.0/255.0) alpha:1.0];
        _cherryRedColor     = [UIColor colorWithRed:(231.0/255.0) green:( 51.0/255.0) blue:( 41.0/255.0) alpha:1.0];
        
        // instantiate the background image
        _backgroundImage = [UIImage imageNamed:backgroundImageString];
        
        // instantiate the challenge images
        _janChallengeImage = [UIImage imageNamed:januaryImageString];
        _febChallengeImage = [UIImage imageNamed:februaryImageString];
        _marChallengeImage = [UIImage imageNamed:marchImageString];
        _aprChallengeImage = [UIImage imageNamed:aprilImageString];
        _mayChallengeImage = [UIImage imageNamed:mayImageString];
        _junChallengeImage = [UIImage imageNamed:juneImageString];
        _julChallengeImage = [UIImage imageNamed:julyImageString];
        _augChallengeImage = [UIImage imageNamed:augustImageString];
        _sepChallengeImage = [UIImage imageNamed:septemberImageString];
        _octChallengeImage = [UIImage imageNamed:octoberImageString];
        _novChallengeImage = [UIImage imageNamed:novemberImageString];
        _decChallengeImage = [UIImage imageNamed:decemberImageString];
        

        //NSLog(@"%@", [UIFont familyNames]);
        
        //NSLog(@"%@", [UIFont fontNamesForFamilyName:@"Gill Sans"]);  // lists the family names available
        
    }
    else //no object
    {
        return nil;
    }
    return self;
}// end contstructor


//Font getters

- (UIFont*) getStandardFontWithSize:(float)size
{

    //UIFont* newFont = [UIFont fontWithName:standardFontString size:size];
    UIFont* newFont = [UIFont systemFontOfSize: size];
    return newFont;


}// end getStandardFontWithSize

- (UIFont*) getBoldFontWithSize:(float)size
{
    
    //UIFont* newFont = [UIFont fontWithName:boldFontString size:size];
   // UIFont* newFont = [UIFont fontWithName:gillSansLight size:size];
    UIFont* newFont = [UIFont boldSystemFontOfSize:size];

    return newFont;
    
}// end getBoldFontWithSize

/*
- (UIFont*) getShadowedFontWithSize:(float)size
{
    
    UIFont* newFont = [UIFont fontWithName:shadowedFontString size:size];
    return newFont;

}// end getShadowedFontWithSize
*/
//***** current challenge image getter *****//
- (UIImage*) getCurrentMonthImage:(int) month
{
    UIImage* currentImage;
    
    switch(month)
    {
        case (january):
        {
            currentImage = _janChallengeImage;
            break;
        }
        case (february):
        {
            currentImage = _febChallengeImage;
            break;
        }
        case (march):
        {
            currentImage = _marChallengeImage;
            break;
        }
        case (april):
        {
            currentImage = _aprChallengeImage;
            break;
        }
        case (may):
        {
            currentImage = _mayChallengeImage;
            break;
        }
        case (june):
        {
            currentImage = _junChallengeImage;
            break;
        }
        case (july):
        {
            currentImage = _julChallengeImage;
            break;
        }
        case (august):
        {
            currentImage = _augChallengeImage;
            break;
        }
        case (septemenber):
        {
            currentImage = _sepChallengeImage;
            break;
        }
        case (october):
        {
            currentImage = _octChallengeImage;
            break;
        }
        case (november):
        {
            currentImage = _novChallengeImage;
            break;
        }
        case (december):
        {
            currentImage = _decChallengeImage;
            break;
        }
        default:
        {
            currentImage = _janChallengeImage;
        }            
    }//end switch
    
    
    return currentImage;
    
    
}// end getCurrentMonthImage

//***** current challenge caption getter *****//
- (NSString*) getCurrentMonthCaption:(int) month
{
    NSString* currentCaption = @"Take the Challenge: ";
    
    switch(month)
    {
        case (january):
        {
            currentCaption = [currentCaption stringByAppendingString:janChallengeString];
            break;
        }
        case (february):
        {
            currentCaption = [currentCaption stringByAppendingString:febChallengeString];
            break;
        }
        case (march):
        {
            currentCaption = [currentCaption stringByAppendingString:marChallengeString];
            break;
        }
        case (april):
        {
            currentCaption = [currentCaption stringByAppendingString:aprChallengeString];
            break;
        }
        case (may):
        {
            currentCaption = [currentCaption stringByAppendingString:mayChallengeString];
            break;
        }
        case (june):
        {
            currentCaption = [currentCaption stringByAppendingString:junChallengeString];
            break;
        }
        case (july):
        {
            currentCaption = [currentCaption stringByAppendingString:julChallengeString];
            break;
        }
        case (august):
        {
            currentCaption = [currentCaption stringByAppendingString:augChallengeString];
            break;
        }
        case (septemenber):
        {
            currentCaption = [currentCaption stringByAppendingString:sepChallengeString];
            break;
        }
        case (october):
        {
            currentCaption = [currentCaption stringByAppendingString:octChallengeString];
            break;
        }
        case (november):
        {
            currentCaption = [currentCaption stringByAppendingString:novChallengeString];
            break;
        }
        case (december):
        {
            currentCaption = [currentCaption stringByAppendingString:decChallengeString];
            break;
        }
        default:
        {
            currentCaption = [currentCaption stringByAppendingString:janChallengeString];
        }
    }//end switch
    
    
    return currentCaption;
    
    
}// end getCurrentMonthImage

//***** previous challenge caption getter *****//
- (NSString*) getPreviousMonthCaption:(int) month
{
    NSString* currentCaption = @"";
    
    switch(month)  //use -1 because rows start at '0', not '1'
    {
        case (january - 1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"January:   "];
            currentCaption = [currentCaption stringByAppendingString:janChallengeString];
            break;
        }
        case (february - 1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"February:  "];
            currentCaption = [currentCaption stringByAppendingString:febChallengeString];
            break;
        }
        case (march -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"March:     "];
            currentCaption = [currentCaption stringByAppendingString:marChallengeString];
            break;
        }
        case (april -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"April:     "];
            currentCaption = [currentCaption stringByAppendingString:aprChallengeString];
            break;
        }
        case (may - 1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"May:       "];
            currentCaption = [currentCaption stringByAppendingString:mayChallengeString];
            break;
        }
        case (june -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"June:      "];
            currentCaption = [currentCaption stringByAppendingString:junChallengeString];
            break;
        }
        case (july -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"July:      "];
            currentCaption = [currentCaption stringByAppendingString:julChallengeString];
            break;
        }
        case (august -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"August:    "];
            currentCaption = [currentCaption stringByAppendingString:augChallengeString];
            break;
        }
        case (septemenber -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"September: "];
            currentCaption = [currentCaption stringByAppendingString:sepChallengeString];
            break;
        }
        case (october -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"October:   "];
            currentCaption = [currentCaption stringByAppendingString:octChallengeString];
            break;
        }
        case (november -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"November:  "];
            currentCaption = [currentCaption stringByAppendingString:novChallengeString];
            break;
        }
        case (december -1):
        {
            currentCaption = [currentCaption stringByAppendingString:@"December:  "];
            currentCaption = [currentCaption stringByAppendingString:decChallengeString];
            break;
        }
        default:
        {
            currentCaption = [currentCaption stringByAppendingString:@"January:   "];
            currentCaption = [currentCaption stringByAppendingString:janChallengeString];
        }
    }//end switch
    
    
    return currentCaption;
    
    
}// end getPreviousMonthCaption






//***** background image getter *****//
- (UIImage*) getBackgroundImage  { return _backgroundImage; }


//*****  color getters  ****//
- (UIColor*) tealColor          { return _tealColor; }
- (UIColor*) seaFoamColor       { return _seaFoamColor; }
- (UIColor*) burntOrangeColor   { return _burntOrangeColor; }
- (UIColor*) mustardYellowColor { return _mustardYellowColor; }
- (UIColor*) brightGreenColor   { return _brightGreenColor; }
- (UIColor*) cherryRedColor     { return _cherryRedColor; }

@end

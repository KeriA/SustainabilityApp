//
//  UUProgramConstants.h
//  Sustain
//
//  Created by Keri Anderson on 9/3/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUProgramConstants : NSObject
{
    UIColor* _tealColor;
    UIColor* _seaFoamColor;
    UIColor* _burntOrangeColor;
    UIColor* _mustardYellowColor;
    UIColor* _brightGreenColor;
    UIColor* _cherryRedColor;
    
    UIImage* _backgroundImage;
    
    UIImage* _janChallengeImage;
    UIImage* _febChallengeImage;
    UIImage* _marChallengeImage;
    UIImage* _aprChallengeImage;
    UIImage* _mayChallengeImage;
    UIImage* _junChallengeImage;
    UIImage* _julChallengeImage;
    UIImage* _augChallengeImage;
    UIImage* _sepChallengeImage;
    UIImage* _octChallengeImage;
    UIImage* _novChallengeImage;
    UIImage* _decChallengeImage;

}


- (UIFont*) getStandardFontWithSize:(float)size;
- (UIFont*) getBoldFontWithSize:(float)size;



- (UIImage*) getBackgroundImage;
- (UIImage*) getCurrentMonthImage:(int) month;

- (NSString*) getCurrentMonthCaption:(int) month;
- (NSString*) getPreviousMonthCaption:(int) month;


- (UIColor*) tealColor;
- (UIColor*) seaFoamColor;
- (UIColor*) burntOrangeColor;
- (UIColor*) mustardYellowColor;
- (UIColor*) brightGreenColor;
- (UIColor*) cherryRedColor;

@end

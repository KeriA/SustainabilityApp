//
//  UUProfileViewController.h
//  Sustain
//
//  Created by Keri Anderson on 4/15/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUSustainModel.h"
#import "UUProgramConstants.h"
#import "UUProfileView.h"


//UURegisterParticipantDataReceivedDelegate
@interface UUProfileViewController : UIViewController<UUProfileViewDelegate, UUUpdateProfileResponseReceivedDelegate,
                                     UUGetProfileDataReceivedDelegate>
{
    UUSustainModel* _model;
    UUProgramConstants* _programConstants;
    UIImage* _profileImage;
}

- (id)initWithModel:(UUSustainModel*)model andProgramConstants:(UUProgramConstants*)programConstants;

@end

//
//  UUSponsorsViewController.m
//  Sustain
//
//  Created by Keri Anderson on 4/15/13.
//  Copyright (c) 2013 University of Utah. All rights reserved.
//

#import "UUSponsorsViewController.h"

@interface UUSponsorsViewController ()

@end

@implementation UUSponsorsViewController

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
        
        [self.view setBackgroundColor:[_model brightGreenColor]]; // for testing (sanity check)
    
        
    }
    return self;
    
}// end contstructor


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

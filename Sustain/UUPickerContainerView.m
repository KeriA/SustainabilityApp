//
//  UUPickerContainerView.m
//  Sustain
//
//  Created by Keri Anderson on 1/11/14.
//  Copyright (c) 2014 University of Utah. All rights reserved.
//

#import "UUPickerContainerView.h"

@interface UUPickerContainerView ()
{
    UIPickerView* _pickerView;
    UIToolbar* _toolBar;
    UIBarButtonItem* _cancelButton;
    UIBarButtonItem* _selectTeamButton;
    

}

@end

@implementation UUPickerContainerView
@synthesize pickerContainerViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];

        
        _toolBar = [[UIToolbar alloc]init];
        _toolBar.backgroundColor = [UIColor grayColor];
        _toolBar.barStyle = UIBarStyleBlack;
        
        _cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:pickerContainerViewDelegate action:@selector(cancelButtonWasPressed)];
        //this item is used to space the buttons so that "cancel" will be on the left, "select team" on the right
        UIBarButtonItem* flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:pickerContainerViewDelegate action:nil];
        _selectTeamButton = [[UIBarButtonItem alloc] initWithTitle:@"Select Team" style:UIBarButtonItemStyleBordered target:pickerContainerViewDelegate action:@selector(selectTeamButtonWasPressed)];
                                                 
        
        NSArray *items = [NSArray arrayWithObjects: _cancelButton, flexSpace, _selectTeamButton, nil];
        [_toolBar setItems:items animated:NO];
        
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor clearColor];


        
        
        
        
    [self addSubview:_toolBar];
    [self addSubview:_pickerView];
  
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*****************************************************************************************************************
 *
 *                              Layout Subviews
 *
 *****************************************************************************************************************/
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // Get the bounds of the current view. We will use this to dynamically calculate the frames of our subviews
    CGRect bounds = [self bounds];
        
    // the specific rects that will be used for subviews
    CGRect toolBarRect;
    CGRect pickerRect;
        
     //Now divide the bounds rect amongst all of the sub-rects
    // Notes on using CGRectDivide
    //    Parameters:
    //               rect:        the original rect to divide up
    //               slice:       the first slice that will be created - needs ADDRESS of rect
    //               remainder:   the remainder of the original rect will be placed in this rect  (use ADDRESS of rect)
    //               amount:      the float amount of how much to put in the first rect
    //               edge:        which edge to measure from
    //                           CGRectMinYEdge  :  will measuer from the top
    //                           CGRectMinXEdge  :  will measure from the left
    //                           CGRectMaxYedge  :  will measure from the bottom
    //                           CGRectMaxXedge  :  will measure from the right
    //
    // original rect, 1st slice,      remainder,   how much to put in slice, which edge to measure from
    
    CGRectDivide(bounds, &toolBarRect, &pickerRect, bounds.size.height/ 5.0, CGRectMinYEdge);
    
    // shrink the width of the picker a bit
    float pickerWidthShrinkAmount = .15;
    float newWidth = pickerRect.size.width * (1.0 - pickerWidthShrinkAmount);
    float newX = (pickerRect.size.width - newWidth) / 2.0;
    float newY = pickerRect.origin.y;
    float newHeight = pickerRect.size.height;
    CGRect newPickerRect = CGRectMake(newX, newY, newWidth, newHeight);
    pickerRect = CGRectIntegral(newPickerRect);
    //pickerRect = CGRectInset(pickerRect, .15, 0.0);
        
    // set the frames
    [_toolBar setFrame:CGRectIntegral(toolBarRect)];
    [_pickerView setFrame:CGRectIntegral(pickerRect)];
    
    
    
    
}// end layoutSubviews


/**************************************************************************************************
 *
 *                          Reload Picker Data
 *
 **************************************************************************************************/
-(void) reloadPickerData
{
    [_pickerView reloadAllComponents];
}


/**************************************************************************************************
 *
 *                          Set delegate for the subviews
 *
 **************************************************************************************************/
#pragma - mark setSubviewDelegates
/***
 *  This method is used for easy access to the subviews by the controller.
 *  The method is called by the controller in the 'view did load' method
 *
 */
-(void) setSubViewDelegates:(id)delegate
{
    [_pickerView setDataSource:delegate];
    [_pickerView setDelegate:delegate];
    [self setPickerContainerViewDelegate:delegate];
    
    
}// end set delegates


@end

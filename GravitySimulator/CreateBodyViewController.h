//
//  CreateBodyViewController.h
//  GravitySimulator
//
//  Created by Bram on 11/25/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Universe.h"

@interface CreateBodyViewController : UITableViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *massField;
@property (weak, nonatomic) IBOutlet UITextField *radiusField;
@property (weak, nonatomic) IBOutlet UIView *color;
@property (weak, nonatomic) IBOutlet UISlider *redChooser;
@property (weak, nonatomic) IBOutlet UISlider *greenChooser;
@property (weak, nonatomic) IBOutlet UISlider *blueChooser;

@property int mass;
@property int radius;
@property float red;
@property float green;
@property float blue;
@property Universe* universe;
@property BOOL paused;

- (void)updateColor;

@end

//
//  ViewController.h
//  SayIt
//
//  Created by Mike Silvers on 10/16/11.
//  Copyright (c) 2011 IggyCo, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenEarsEventsObserver.h"

@class FliteController;

@interface ViewController : UIViewController <OpenEarsEventsObserverDelegate> {

    UISegmentedControl *voices;
    UIButton *sayIt;
    UIButton *resetIt;
    UITextField *words;
    UISlider *pitch;
    UISlider *varience;
    UISlider *speed;
    UILabel *pitchVal;
    UILabel *varienceVal;
    UILabel *speedVal;
    
    FliteController *flite;
    
    float pitchActual;
    float varienceActual;
    float speedActual;
}

@property (nonatomic, strong) IBOutlet UISegmentedControl *voices;
@property (nonatomic, strong) IBOutlet UIButton *sayIt;
@property (nonatomic, strong) IBOutlet UIButton *resetIt;
@property (nonatomic, strong) IBOutlet UITextField *words;
@property (nonatomic, strong) IBOutlet UISlider *pitch;
@property (nonatomic, strong) IBOutlet UISlider *varience;
@property (nonatomic, strong) IBOutlet UISlider *speed;
@property (nonatomic, strong) IBOutlet UILabel *pitchVal;
@property (nonatomic, strong) IBOutlet UILabel *varienceVal;
@property (nonatomic, strong) IBOutlet UILabel *speedVal;

@property (nonatomic, strong) FliteController *flite;

-(IBAction)sayTheStuff:(id)sender;
-(IBAction)resetTheStuff:(id)sender;
-(IBAction)pitchSlider:(id)sender;
-(IBAction)varienceSlider:(id)sender;
-(IBAction)speedSlider:(id)sender;

@end

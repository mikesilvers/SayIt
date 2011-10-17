//
//  ViewController.m
//  SayIt
//
//  Created by Mike Silvers on 10/16/11.
//  Copyright (c) 2011 IggyCo, Inc. All rights reserved.
//

#import "ViewController.h"

#import "AudioSessionManager.h"
#import "PocketsphinxController.h"
#import "FliteController.h"
#import "OpenEarsEventsObserver.h"
#import "LanguageModelGenerator.h"

@implementation ViewController

@synthesize voices, sayIt, words;
@synthesize flite;
@synthesize pitch, pitchVal, varience, varienceVal, speed, speedVal;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)sayTheStuff:(id)sender {
    if (!flite) {
        flite = [[FliteController alloc] init];
    }
    
    NSString *v;
    
    switch ([voices selectedSegmentIndex]) {
        case 0:
            v = @"cmu_us_awb8k";
            break;
        case 1:
            v = @"cmu_us_rms8k";
            break;
        case 2:
            v = @"cmu_us_slt8k";
            break;
        case 3:
            v = @"cmu_time_awb";
            break;
        case 4:
            v = @"cmu_us_awb";
            break;
        case 5:
            v = @"cmu_us_kal";
            break;
        case 6:
            v = @"cmu_us_kal16";
            break;
        case 7:
            v = @"cmu_us_rms";
            break;
        case 8:
            v = @"cmu_us_slt";
            break;
            
        default:
            break;
    }
    
    // set the varience, speed, pitch

    @try {
        // finally say it!
        [flite say:[words text] withVoice:v];        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(IBAction)resetTheStuff:(id)sender {

    if (flite && [flite speechInProgress])
        [flite setSpeechInProgress:NO];
    
    [pitch setValue:1.0];
    [varience setValue:1.0];
    [speed setValue:1.0];
    [words setText:@""];
    [voices setSelectedSegmentIndex:0];
    
    pitchActual = 1.0;
    [pitchVal setText:[[NSNumber numberWithFloat:pitchActual] stringValue]];
    varienceActual = 1.0;
    [varienceVal setText:[[NSNumber numberWithFloat:varienceActual] stringValue]];
    speedActual = 1.0;
    [speedVal setText:[[NSNumber numberWithFloat:speedActual] stringValue]];

    flite.target_mean = pitchActual; // Change the pitch
    flite.target_stddev = varienceActual; // Change the variance
    flite.duration_stretch = speedActual; // Change the speed

}

-(IBAction)pitchSlider:(id)sender {

    flite.target_mean = pitchActual; // Change the pitch

    pitchActual = [pitch value];
    [pitchVal setText:[[NSNumber numberWithFloat:pitchActual] stringValue]];
}

-(IBAction)varienceSlider:(id)sender {

    flite.target_stddev = varienceActual; // Change the variance

    varienceActual = [varience value];
    [varienceVal setText:[[NSNumber numberWithFloat:varienceActual] stringValue]];

}

-(IBAction)speedSlider:(id)sender {

    flite.duration_stretch = speedActual; // Change the speed

    speedActual = [speed value];
    [speedVal setText:[[NSNumber numberWithFloat:speedActual] stringValue]];

}

#pragma mark - OpenEars Delegate
- (void) fliteDidStartSpeaking {
    [sayIt setEnabled:NO];
}

- (void) fliteDidFinishSpeaking {

    [sayIt setEnabled:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    pitchActual = [pitch value];
    [pitchVal setText:[[NSNumber numberWithFloat:pitchActual] stringValue]];
    varienceActual = [varience value];
    [varienceVal setText:[[NSNumber numberWithFloat:varienceActual] stringValue]];
    speedActual = [speed value];
    [speedVal setText:[[NSNumber numberWithFloat:speedActual] stringValue]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

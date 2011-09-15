//
//  BusInfoCellViewController.m
//  busStopBuddy
//
//  Created by Padma Daryanani on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//testing committing
#import "BusInfoCellViewController.h"


@implementation BusInfoCellViewController

@synthesize busTime;
@synthesize busSchedTime;
@synthesize busDest;
@synthesize busNumber;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Add Add to Favourite Button
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                   target:self action:@selector(doneSearching_Clicked:)] autorelease];
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    busNumberLabel.text = self.busNumber;
    busDestLabel.text = self.busDest;
    busTimeLabel.text = self.busTime;
    busSchedTimeLabel.text = self.busSchedTime;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

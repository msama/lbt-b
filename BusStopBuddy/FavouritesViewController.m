//
//  FavouritesViewController.m
//  BusStopBuddy
//
//  Created by Louis on 16/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavouritesViewController.h"
#import "BusInfoTableViewController.h"
#import "BusManager.h"


@implementation FavouritesViewController 

@synthesize favouriteStopTable = _favouriteStopTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    BusStop *stop = [favouriteItems objectAtIndex:indexPath.row];
    //NSLog(cellValue);
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (stop %@)", stop.stopName, stop.stopLetter];
    cell.textLabel.font = [UIFont boldSystemFontOfSize: 14.0]; 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BusStop *stop = [favouriteItems objectAtIndex:indexPath.row];
    BusStopStatus *ourBusStopStatus = [[busManager getCountDown:stop] retain];
    
    //[NSString stringWithFormat:@"%@ (stop %@)", stop.stopName, stop.stopLetter];
    //ourBusStopStatus.stopID;
    
    
    BusInfoTableViewController *dvController = [[BusInfoTableViewController alloc] initWithNibName:@"BusInfoTableViewController" bundle:[NSBundle mainBundle]];
    dvController.stopStatus = ourBusStopStatus;
    [self.navigationController pushViewController:dvController animated:YES];
    [dvController release];
    dvController = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowns -> filteredItems COUNT - %d",[favouriteItems count]);
    return [favouriteItems count];
    
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

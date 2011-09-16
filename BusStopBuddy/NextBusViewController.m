//
//  NextBusViewController.m
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//

#import "NextBusViewController.h"
#import "BusInfoTableViewController.h"
#import "BusStopBuddyAppDelegate_iPhone.h"
#import "BusManager.h"

@implementation NextBusViewController

@synthesize busStopTable = _busStopTable;



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
    [_busManager release];
    [_filteredItems release];
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
    _busManager = [[(BusStopBuddyAppDelegate_iPhone*)[[UIApplication sharedApplication] delegate] busManager] retain];

    self.title = @"Find Bus Stops";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"User Typed %@",searchText);
    if (_filteredItems != nil) {
        [_filteredItems release];
    }
    
    if([searchText isEqual:@""]){
        _filteredItems = [[NSArray array] retain];
    } else {
        _filteredItems = [[_busManager getStopByPrefix:searchText] retain];
    }
    [self.busStopTable reloadData];
}

 
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowns -> filteredItems COUNT - %d",[_filteredItems count]);
    return [_filteredItems count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    BusStop *stop = [_filteredItems objectAtIndex:indexPath.row];
    cell.textLabel.text = [stop verboseName];
    //cell.textLabel.font = [UIFont boldSystemFontOfSize: 14.0]; 
    cell.detailTextLabel.text = stop.stopId;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BusStop *stop = [_filteredItems objectAtIndex:indexPath.row];
    BusStopStatus *selectedStopStatus = [_busManager getCountDown:stop];

    
    BusInfoTableViewController *dvController = [[BusInfoTableViewController alloc] initWithNibName:@"BusInfoTableViewController" bundle:[NSBundle mainBundle]];
    dvController.stopStatus = selectedStopStatus;
    dvController.busManager = _busManager;
    [self.navigationController pushViewController:dvController animated:YES];
    [dvController release];
}

- (void)viewDidUnload
{
    [_filteredItems release];
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

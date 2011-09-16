//
//  FavouriteBusStopsController.m
//  BusStopBuddy
//
//  Created by Michele Sama on 16/09/11.
//  Copyright 2011 PuzzleDev s.n.c di Michele Sama e soci. All rights reserved.
//

#import "FavouriteBusStopsController.h"
#import "BusStopBuddyAppDelegate_iPhone.h"
#import "BusInfoTableViewController.h"

@implementation FavouriteBusStopsController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    _busManager = [(BusStopBuddyAppDelegate_iPhone*)[[UIApplication sharedApplication] delegate] busManager];
    _favouriteBus = [[_busManager getFavouriteBusStops] retain];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_busManager release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    _favouriteBus = [[_busManager getFavouriteBusStops] retain];
    [super viewWillAppear:animated];
    [(UITableView*)[self view] reloadData];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_favouriteBus count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    BusStop *stop = [_favouriteBus objectAtIndex:indexPath.row];
    cell.textLabel.text = [stop verboseName];
    //cell.textLabel.font = [UIFont boldSystemFontOfSize: 14.0]; 
    cell.detailTextLabel.text = stop.stopId;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_busManager unsetFavouriteBusStop:[_favouriteBus objectAtIndex:indexPath.row]];
        _favouriteBus = [[_busManager getFavouriteBusStops] retain];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusStop *stop = [_favouriteBus objectAtIndex:indexPath.row];
    BusStopStatus *selectedStopStatus = [_busManager getCountDown:stop];
    
    
    BusInfoTableViewController *dvController = [[BusInfoTableViewController alloc] initWithNibName:@"BusInfoTableViewController" bundle:[NSBundle mainBundle]];
    dvController.stopStatus = selectedStopStatus;
    dvController.busManager = _busManager;
    [self.navigationController pushViewController:dvController animated:YES];
    [dvController release];
}

@end

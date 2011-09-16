//
//  BusInfoTableViewController.m
//  busStopBuddy
//
//  Created by Padma Daryanani on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusInfoTableViewController.h"
#import "BusManager.h"

@implementation BusInfoTableViewController

@synthesize stopStatus = _stopStatus;
@synthesize busManager = _busManager;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (BOOL)hidesBottomBarWhenPushed{
	return TRUE;
}


- (void)dealloc
{
    [_busManager release];
    [_stopStatus release];
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
    //self.title = [_stopStatus.busStop verboseName];
    
    if ([[_busManager getFavouriteBusStops] containsObject:_stopStatus.busStop]) {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                    target:self action:@selector(removeFromFavourites:)] autorelease];

    } else {   
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                    target:self action:@selector(addToFavourites:)] autorelease];
    
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
    // stopStatusTextView.text = @"ID: %@ \nLastUpdated: %@ \n _stopStatus.stopID
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
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.

    switch (section) {
        //section0 should just have 1 cell for BusStop Name
        case 0:
            return 1;  
        //section1 should Have one cell per bus coming
        case 1:
            return [_stopStatus.arrivals count];  
        //section2 should Have 4 cells, 1 for each info message
        case 2:
            return 4;  
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Adding the logic for indexPath.section == 0
    //So that it only shows bus Stop name and uses a Cell
    //containing only the busStopName and Add to Favorites
    if(indexPath.section == 0) {
         //Uncommented because it crashes...
        static NSString *CellIdentifier = @"InfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            
        }    
        cell.detailTextLabel.text = @"Bus Stop Name";
        cell.textLabel.text = [self.stopStatus.busStop verboseName];
        return cell;
    } else if (indexPath.section == 1) {
        BusInfoCellViewController *controller = [[[BusInfoCellViewController alloc] initWithNibName:@"BusInfoCellViewController" bundle:[NSBundle mainBundle]] autorelease];
        BusInfo *info = [_stopStatus.arrivals objectAtIndex:indexPath.row];
        controller.busNumber = info.routeID;
        controller.busDest = info.destination;
        controller.busTime = info.estimatedWait;    
        controller.busSchedTime = info.scheduledTime; 
        
        return (UITableViewCell*)controller.view;    
    } else if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"InfoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        switch (indexPath.row) {
            case 0: {
                cell.detailTextLabel.text = @"Bus Stop ID";
                cell.textLabel.text = self.stopStatus.busStop.verboseName;
                break;
            }
            case 1: {
                cell.detailTextLabel.text = @"last updated";
                cell.textLabel.text = self.stopStatus.lastUpdated;
                break;
            }
            case 2: {
                cell.detailTextLabel.text = @"Info message";
                cell.textLabel.text = self.stopStatus.infoMessages;
                break;
            }
            case 3: {
                cell.detailTextLabel.text = @"Important Mesage";
                cell.textLabel.text = self.stopStatus.importantMessages;
                break;
            }
        }
        
        return cell;
    }
    
    return nil;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch(section){
        case 0: {
            return @"Bus Stop Name";
        }
        case 1: {
            return @"Buses Coming";
        }
        case 2: {
            return @"Bus Stop Info";
        }
    }
    return nil;
}

- (void) addToFavourites:(id)sender {
    [_busManager setFavouriteBusStop:_stopStatus.busStop];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                               target:self action:@selector(removeFromFavourites:)] autorelease];
}

- (void) removeFromFavourites:(id)sender {
    [_busManager unsetFavouriteBusStop:_stopStatus.busStop];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self action:@selector(addToFavourites:)] autorelease];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

@end

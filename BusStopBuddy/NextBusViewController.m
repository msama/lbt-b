//
//  NextBusViewController.m
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NextBusViewController.h"
#import "BusInfoTableViewController.h"
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
    [super dealloc];
    [listOfItems release];
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
    
    busManager = [[BusManager alloc] init];
    filteredItems = [[NSArray array] retain];
    /*
    
    listOfItems = [[NSMutableArray alloc] init];
    filteredItems = [[NSArray alloc] init];
    
    [listOfItems addObject:@"Wimbledon stop X"];
    [listOfItems addObject:@"Wimbleson stop Y"];
    [listOfItems addObject:@"The Burrough stop D"];
    [listOfItems addObject:@"Hendon Town Gall Stop P"];
    [listOfItems addObject:@"Hendon Town Gall Stop O"];
    
  */
  
    self.navigationItem.title = @"Find Bus Stop";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"User Typed %@",searchText);
    
    filteredItems = [[NSArray alloc] init];
    if([searchText isEqual:@""]){
        //[filteredItems removeAllObjects];
        filteredItems = [[NSArray array] retain];
    } else {
        if (filteredItems != nil) {
            [filteredItems release];
        }
        filteredItems = [[busManager getStopByPrefix:searchText] retain];
        /*
        //[listOfItems removeAllObjects];
        //[listOfItems addObject:searchText];
        
        NSPredicate *searchPredicate =
        [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
   
        NSArray *tempArray;
        tempArray = [listOfItems filteredArrayUsingPredicate:searchPredicate];
        
//        listOfItems = filteredItems
        
        filteredItems = [tempArray copy];
        
        NSLog(@"tempArray COUNT ->%d",[tempArray count]);
        
        //[listOfItems addObject:filteredItems];
        // beginWithB contains { @"Bill", @"Ben" }.
 
         */
    }
    [self.busStopTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowns -> filteredItems COUNT - %d",[filteredItems count]);
    //return [listOfItems count];
    return [filteredItems count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    BusStop *stop = [filteredItems objectAtIndex:indexPath.row];
    //NSLog(cellValue);
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (stop %@)", stop.stopName, stop.stopLetter];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BusStop *stop = [filteredItems objectAtIndex:indexPath.row];
    BusStopStatus *ourBusStopStatus = [[busManager getCountDown:stop] retain];
        
    //[NSString stringWithFormat:@"%@ (stop %@)", stop.stopName, stop.stopLetter];
//ourBusStopStatus.stopID;
    
    
    BusInfoTableViewController *dvController = [[BusInfoTableViewController alloc] initWithNibName:@"BusInfoTableViewController" bundle:[NSBundle mainBundle]];
    dvController.stopStatus = ourBusStopStatus;
    [self.navigationController pushViewController:dvController animated:YES];
    [dvController release];
    dvController = nil;
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

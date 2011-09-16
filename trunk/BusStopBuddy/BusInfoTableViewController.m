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
    BusManager *bm = [[BusManager alloc ] init];
    BusStop *myBusStop = [bm getStopWithID:self.stopStatus.stopID];
    self.title = myBusStop.stopName;
    
    //self.title = self.stopStatus.stopName;
    
    

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
    return 3;// number of sections here is one
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.

    switch (section) {
        //section0 should just have 1 cell for BusStop Name
        case 0:
            return 1;  
            break;
        //section1 should Have one cell per bus coming
        case 1:
            return [_stopStatus.arrivals count];  
            break;
        //section2 should Have 4 cells, 1 for each info message
        case 2:
            return 4;  
            break;
            
        default:
            return 4;
            break;
    }
    /*
    if(section == 1){
    return [_stopStatus.arrivals count];            
    }else{
        return 4;
    }
    */    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Adding the logic for indexPath.section == 0
    //So that it only shows bus Stop name and uses a Cell
    //containing only the busStopName and Add to Favorites
    if(indexPath.section == 0){
        
         //Uncommented because it crashes...
         static NSString *CellIdentifier = @"InfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Bus Stop Name";
                    cell.detailTextLabel.text = self.stopStatus.stopID;
                    break;
                default:
                    break;
                     return cell;
            }    
        }
        
    } 
    else if (indexPath.section == 1){
        
        BusInfoCellViewController *controller = [[[BusInfoCellViewController alloc] initWithNibName:@"BusInfoCellViewController" bundle:[NSBundle mainBundle]] autorelease];
        BusInfo *info = [_stopStatus.arrivals objectAtIndex:indexPath.row];
        controller.busNumber = info.routeID;
        controller.busDest = info.destination;
        controller.busTime = info.estimatedWait;    
        controller.busSchedTime = info.scheduledTime; 
        
        return (UITableViewCell*)controller.view;    
    }
    else if (indexPath.section == 2)
    {
        static NSString *CellIdentifier = @"InfoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Bus Stop ID";
                cell.detailTextLabel.text = self.stopStatus.stopID;
                break;
            case 1:
                cell.textLabel.text = @"last updated";
                cell.detailTextLabel.text = self.stopStatus.lastUpdated;
                break;
            case 2:
                cell.textLabel.text = @"Info message";
                cell.detailTextLabel.text = self.stopStatus.infoMessages;
                break;
            case 3:
                cell.textLabel.text = @"Important Mesage";
                cell.detailTextLabel.text = self.stopStatus.importantMessages;
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    
    //If it's NOT section 0, 1 or 2
    static NSString *CellIdentifier = @"InfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease]; 
    
    
            return cell;
}
    
}

//--------------------put method here

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch(section){
        case 0:
            return @"Bus Stop Name";
            break;
        case 1:
     return @"Busses Coming";
    break;
        case 2:
        return @"Bus Stop Info";
    break;
default:
    return @"not a section";
            break;
    }
    
}


/*- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+10 ,0, 50, 50);
    busNumberLabel.frame = frame;
    
    frame= CGRectMake(boundsX+70 ,5, 200, 25);
    busDestLabel.frame = frame;
    
    frame= CGRectMake(boundsX+70 ,30, 100, 15);
    busTimeLabel.frame = frame;
}*/
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) { return; }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end

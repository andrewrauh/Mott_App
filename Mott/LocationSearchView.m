//
//  LocationSearchView.m
//  Mott
//
//  Created by Chris Wendel on 10/28/11.
//  Copyright (c) 2011 University of Michigan. All rights reserved.
//

#import "LocationSearchView.h"
#import "JSON.h"
#import "AppDelegate.h"
@implementation LocationSearchView
@synthesize tbView, rooms;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Location", @"Location");
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Location" image:[UIImage imageNamed:@"07-map-marker.png"] tag:2];
        self.tabBarItem.title = @"Locations";
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 11;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    
    
    //
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        //000A93 
        
        //FFFF88
        cell = 
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor yellowColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;    
    }    
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Level %i",indexPath.row+2]];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getItemsForLevel:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void) getItemsForLevel:(NSInteger) intRow
{
    
    //NSMutableArray*  firstNames = [[NSMutableArray alloc]init];
    //NSMutableArray* lastNames = [[NSMutableArray alloc]init];
    //NSMutableArray* picLoc = [[NSMutableArray alloc]init];
    //NSMutableArray* levels = [[NSMutableArray alloc]init];
    //NSMutableArray* rooms = [[NSMutableArray alloc]init];
    NSMutableArray *roomsArray = [[NSMutableArray alloc]init];
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    int level = intRow + 2;
    NSLog(@"Level: %i",level);
    switch (level) {
        case 2:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Family Center Greet Desk"];
            [roomsArray addObject:@"Connector"];
            [roomsArray addObject:@"ED Reception"];
            [roomsArray addObject:@"Triage Station"];
            break;
        case 3:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Greet Desk"];
            break;
        case 4:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Greet Desk"];
            break;
        case 5:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            break;
        case 6:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Business Office"];
            break;
        case 7:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Greet Desk"];
            break;
        case 8:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Greet Desk"];
            break;
        case 10:
            [roomsArray addObject:@"Greet Desk"];
            break;
        case 11:
            [roomsArray addObject:@"Check-In"];
            [roomsArray addObject:@"Check-Out"];
            [roomsArray addObject:@"Greet Desk"];
            [roomsArray addObject:@"ADP Reception"];
            break;
        case 12:
            [roomsArray addObject:@"Greet Desk"];
            break;
        default:
            break;
    }
    /*
    NSString *levelString = [NSString stringWithFormat:@"Level %i",intRow+2];
    
    for(int i =0;i<[appDelegate.locations count];i++)
    {
        NSString *stringToSearch = [appDelegate.locations objectAtIndex:i];
        if([[stringToSearch lowercaseString] rangeOfString:[levelString lowercaseString]].location==NSNotFound)
        {
            NSLog(@"Did not find current level in levels object at index %i",i);
        }
        else
        {
            NSLog(@"Adding to arrays, found level");
            //Add to arrays
            
    
            
            //[roomsArray addObject:[appDelegate.rooms objectAtIndex:i]];
        }
    }
*/
    
    
    
    if(self.rooms==nil)
    {
        Rooms *rvc = [[Rooms alloc]initWithNibName:@"Rooms" bundle:[NSBundle mainBundle]];
        self.rooms = rvc;
        [rvc release];
    }    
    [self.rooms setRoomsArray:roomsArray];
    [self.rooms setLevel:level];
    //[rooms setRoomsArr];

    [roomsArray release];;

    [[self.tabBarController.viewControllers objectAtIndex:1]pushViewController:self.rooms animated:YES]; 
    //[self presentModalViewController:self.namesView  animated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    tbView.dataSource = self;
    tbView.delegate = self;
    // Do any additional setup after loading the view from its nib.
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

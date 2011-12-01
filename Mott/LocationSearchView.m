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
@synthesize tbView, namesView;

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
    
    NSMutableArray*  firstNames = [[NSMutableArray alloc]init];
    NSMutableArray* lastNames = [[NSMutableArray alloc]init];
    NSMutableArray* picLoc = [[NSMutableArray alloc]init];
    NSMutableArray* levels = [[NSMutableArray alloc]init];
    NSMutableArray* rooms = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSString *levelString = [NSString stringWithFormat:@"Level %i",intRow+2];
    
    for(int i =0;i<[appDelegate.levels count];i++)
    {
        NSString *stringToSearch = [appDelegate.levels objectAtIndex:i];
        if([[stringToSearch lowercaseString] rangeOfString:[levelString lowercaseString]].location==NSNotFound)
        {
            NSLog(@"Did not find current level in levels object at index %i",i);
        }
        else
        {
            NSLog(@"Adding to arrays");
            //Add to arrays
            [firstNames addObject:[appDelegate.firstNames objectAtIndex:i]];
            [lastNames addObject:[appDelegate.lastNames objectAtIndex:i]];
            [picLoc addObject:[appDelegate.imagePaths objectAtIndex:i]];
            [levels addObject:[appDelegate.levels objectAtIndex:i]];
            [rooms addObject:[appDelegate.rooms objectAtIndex:i]];
        }
    }
    
    
    
    if(self.namesView==nil)
    {
        NamesViewController *nvc = [[NamesViewController alloc]initWithNibName:@"NamesViewController" bundle:[NSBundle mainBundle]];
        self.namesView = nvc;
        [nvc release];
        
    }

    [namesView setFirstNames:firstNames];
    [namesView setLastNames:lastNames];
    [namesView setPicLoc:picLoc];
    [namesView setLevels:levels];
    [namesView setRooms:rooms];
    
    [firstNames release];
    [lastNames release];
    [picLoc release];
    [levels release];
    [rooms release];

    [[self.tabBarController.viewControllers objectAtIndex:1]pushViewController:self.namesView animated:YES]; 
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

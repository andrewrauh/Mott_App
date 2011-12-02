//
//  Rooms.m
//  Mott
//
//  Created by Chris Wendel on 12/1/11.
//  Copyright (c) 2011 University of Michigan. All rights reserved.
//

#import "Rooms.h"
#import "AppDelegate.h"

@implementation Rooms
@synthesize tbView, roomsArray, namesView, level;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [tbView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tbView.dataSource = self;
    self.tbView.delegate = self;
    self.title = @"Rooms";
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [roomsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *room = [roomsArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:room];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *firstNames = [[NSMutableArray alloc]init];
    NSMutableArray *lastNames = [[NSMutableArray alloc]init];
    NSMutableArray *locations = [[NSMutableArray alloc]init];
    NSMutableArray *databaseImages = [[NSMutableArray alloc]init];
    NSMutableArray *thumbnailImages = [[NSMutableArray alloc]init];
    NSString *roomString = [roomsArray objectAtIndex:indexPath.row];
    NSString *levelString = [NSString stringWithFormat:@"Level %i",level];
    
    NSLog(@"Room string: %@",roomString);
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    for(int i = 0;i<[appDelegate.locations count];i++)
    {
        NSString *stringToSearch = [appDelegate.locations objectAtIndex:i];
        if([[stringToSearch lowercaseString] rangeOfString:[levelString lowercaseString]].location==NSNotFound)
        {
            NSLog(@"Level was not found in this row");
        }
        else
        {
            if([[stringToSearch lowercaseString] rangeOfString:[roomString lowercaseString]].location==NSNotFound)
            {
                NSLog(@"Location was not found in this row's level");
            }
            else
            {
                NSLog(@"Location and level were found in this row");
                [firstNames addObject:[appDelegate.firstNames objectAtIndex:i]];
                [lastNames addObject:[appDelegate.lastNames objectAtIndex:i]];
                [locations addObject:[appDelegate.locations objectAtIndex:i]];
                [databaseImages addObject:[appDelegate.databaseImages objectAtIndex:i]];
                [thumbnailImages addObject:[appDelegate.thumbnailImages objectAtIndex:i]];
            }
        }
    }
   
    if(self.namesView==nil)
    {
        NamesViewController *nvc = [[NamesViewController alloc]initWithNibName:@"NamesViewController" bundle:[NSBundle mainBundle]];
        self.namesView = nvc;
        [nvc release];
    }
    
    [self.namesView setFirstNames:firstNames];
    [self.namesView setLastNames:lastNames];
    [self.namesView setLocations:locations];
    [self.namesView setDatabaseImages:databaseImages];
    [self.namesView setThumbnailImages:thumbnailImages];
    
    [[self.tabBarController.viewControllers objectAtIndex:1] pushViewController:self.namesView animated:YES];
    
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

//
//  NamesViewController.m
//  Mott
//
//  Created by Andrew Rauh on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NamesViewController.h"
#import "ViewController.h"
#import "TileDisplayView.h"
@implementation NamesViewController
@synthesize  tbView;
@synthesize  firstNames, lastNames, tileDisplayView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tbView.dataSource = self;
    self.tbView.delegate = self;
    self.tbView.rowHeight = 90;
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"FIRST NAMES: ");
    for(int i =0;i<[firstNames count];i++)
    {
        NSLog(@"%@ ",[firstNames objectAtIndex:i]);
    }
    
    NSLog(@"LAST NAMES: ");
    for(int i =0;i<[lastNames count];i++)
    {
        NSLog(@"%@ ",[lastNames objectAtIndex:i]);
    }
    [tbView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [firstNames count];
}

// Customize the <span id="IL_AD9" class="IL_AD">appearance</span> of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    /*
    NSDictionary *nameResult = [nameResults objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[NSString stringWithFormat:[nameResult objectForKey:@"FIRST"]]];
     */
    
    NSString *firstName = [firstNames objectAtIndex:indexPath.row];
    NSLog(@"First Name of cell: %@",firstName);
    NSString *lastName = [lastNames objectAtIndex:indexPath.row];
     NSLog(@"Last Name of cell: %@",lastName);
   
    [[cell imageView] setImage:[UIImage imageNamed:@"football.jpg"]];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@",firstName, lastName]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.tileDisplayView==nil)
    {
        TileDisplayView *tvc = [[TileDisplayView alloc]initWithNibName:@"TileDisplayView" bundle:[NSBundle mainBundle]];
        self.tileDisplayView = tvc;
        [tvc release];
    }
    [self.tileDisplayView setFirstName:[firstNames objectAtIndex:indexPath.row]];
    [self.tileDisplayView setLastName:[lastNames objectAtIndex:indexPath.row]];
       
    [self presentModalViewController:self.tileDisplayView animated:YES];
    
} 

-(IBAction)dismissModal:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
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

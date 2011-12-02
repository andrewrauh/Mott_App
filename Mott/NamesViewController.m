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
#import "AppDelegate.h"
@implementation NamesViewController
@synthesize  tbView;
@synthesize  firstNames, lastNames, tileDisplayView, locations,thumbnailImages,databaseImages;
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
    self.title = @"Tiles";
    //[[[self.tabBarController.viewControllers objectAtIndex:0] navigationItem] setTitle:@"Tiles"];
    
    //[[self.tabBarController.viewControllers objectAtIndex:0] navigationBar] setTitleView
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
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
    NSString *picturePath = [thumbnailImages objectAtIndex:indexPath.row];
    NSString *location = [locations objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageNamed:picturePath];
    
    UIGraphicsBeginImageContext(CGSizeMake(90, 90));
    [image drawInRect:CGRectMake(0, 0, 90, 90)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[cell imageView] setImage:scaledImage];


    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@",firstName, lastName]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",location]];
   // NSLog(level, room);
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.tileDisplayView==nil)
    {
        TileDisplayView *tvc = [[TileDisplayView alloc]initWithNibName:@"TileDisplayView" bundle:[NSBundle mainBundle]];
        self.tileDisplayView = tvc;
        [tvc release];
    }
    
    //Get image data from server
    NSString *baseUrl;
    baseUrl = @"http://www.givetomott.org/tiles/albums/userpics/10002/";
    NSString *encodedString =  [[databaseImages objectAtIndex:indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *fullUrl = [baseUrl stringByAppendingString:encodedString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSData *namesResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //NSString *responseString = [[NSString alloc]initWithData:namesResponse encoding:NSUTF8StringEncoding];
    
    UIImage *image = [UIImage imageWithData:namesResponse];
    
    [self.tileDisplayView setFirstName:[firstNames objectAtIndex:indexPath.row]];
    [self.tileDisplayView setLastName:[lastNames objectAtIndex:indexPath.row]];
    [self.tileDisplayView setFullSizeTile:image];
    [self.tileDisplayView setLocation:[locations objectAtIndex:indexPath.row]];
    
    if(self.tabBarController.selectedIndex==0)
    {
        [[self.tabBarController.viewControllers objectAtIndex:0] pushViewController:self.tileDisplayView animated:YES];
    }else
    {
        [[self.tabBarController.viewControllers objectAtIndex:1] pushViewController:self.tileDisplayView animated:YES];
    }
    
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

//
//  LocationSearch.m
//  Mott
//
//  Created by Andrew Rauh on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationSearch.h"

@implementation LocationSearch
@synthesize namesResultsLoc, levelNamesTableViewController;

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
    
    return 12;

}
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
    [[cell textLabel]setText:[NSString stringWithFormat:@"Level %i",indexPath.row+1]];
    
    
    return cell;
    
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self getItemsForLevel:indexPath.row];
    
                
}
 

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    tbView.delegate = self;
    tbView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}


-(void) getItemsForLevel:(NSInteger *)rowInt {
    NSMutableArray*  firstNames = [[NSMutableArray alloc]init];
    NSMutableArray* lastNames = [[NSMutableArray alloc]init];
    NSMutableArray* picLoc = [[NSMutableArray alloc]init];
    NSMutableArray* levels = [[NSMutableArray alloc]init];
    NSMutableArray* rooms = [[NSMutableArray alloc]init];

    
    
    //http://macmini2.eecs.umich.edu/Mott_Tiles/select_location.php?location=Level%208,%20Check-In
    NSString *locationUrl = @"http://macmini2.eecs.umich.edu/Mott_Tiles/select_location.php?location=";
   // Level%208,%20Check-In";
    
    rowInt = rowInt +1;
    NSString *locationRequestString = [NSString stringWithFormat:@"Level %i, Check-In", rowInt];
    
    NSString *fullLocationUrl = [locationUrl stringByAppendingString:locationRequestString];
    NSString* escapedUrlString =
    [fullLocationUrl stringByAddingPercentEscapesUsingEncoding:
     NSASCIIStringEncoding];
    NSData *requestData = [escapedUrlString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:escapedUrlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: requestData];
    NSURLResponse *response;
    NSData *namesResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *responseString = [[NSString alloc]initWithData:namesResponse encoding:NSUTF8StringEncoding];
    namesResultsLoc = [responseString JSONValue];

    for(NSDictionary *names in namesResultsLoc)
    {
        //NSLog(@"First name is %@",[names objectForKey:@"FIRST"]);
        [firstNames addObject:[names objectForKey:@"FIRST"]];
        [lastNames addObject:[names objectForKey:@"LAST"]];
        [picLoc addObject:[names objectForKey:@"IMAGE"]];
        [levels addObject:[names objectForKey:@"LEVEL"]];
        [rooms addObject:[names objectForKey:@"ROOM"]];
    }
    if(self.levelNamesTableViewController==nil)
    {
        LevelNamesTableViewController *abv = [[LevelNamesTableViewController alloc]initWithNibName:@"LevelNamesTableViewController" bundle:[NSBundle mainBundle]];
        self.levelNamesTableViewController = abv;
        [self presentModalViewController:abv animated:YES];
        [abv release];
        
        
    }
    int count = [picLoc count];
    
    for(int i = 0;i<count;i++)
    {
        NSString *baseUrl;
        baseUrl = @"http://macmini2.eecs.umich.edu/Mott_Tiles/images/";
        NSString *encodedString =  [[picLoc objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *fullUrl = [baseUrl stringByAppendingString:encodedString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
        [request setHTTPMethod:@"GET"];
        NSURLResponse *response;
        NSData *namesResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        //NSString *responseString = [[NSString alloc]initWithData:namesResponse encoding:NSUTF8StringEncoding];
        
        [self cacheImage:namesResponse withString:[picLoc objectAtIndex:i]];
    }

    
    [levelNamesTableViewController setFirstNamesL:firstNames];
    [levelNamesTableViewController setLastNamesL:lastNames];
    [levelNamesTableViewController setPicLocL:picLoc];
    [levelNamesTableViewController setLevelsL:levels];
    [levelNamesTableViewController setRoomsL:rooms];





}


- (void) cacheImage:(NSData*)imageData withString:(NSString *) ImageURLString
{
    //NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    UIImage *image = [UIImage imageWithData:imageData];
    
    imageData = UIImageJPEGRepresentation(image, 100);
    NSString *uniquePath = ImageURLString;
    NSLog(@"Checking for cashed image at url %@",uniquePath);
        
    //NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", ImageURLString]]; //add our image to the path
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the 
    
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

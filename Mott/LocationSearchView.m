//
//  LocationSearchView.m
//  Mott
//
//  Created by Chris Wendel on 10/28/11.
//  Copyright (c) 2011 University of Michigan. All rights reserved.
//

#import "LocationSearchView.h"
#import "JSON.h"
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
    
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
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
    
    
    
    //http://macmini2.eecs.umich.edu/Mott_Tiles/select_location.php?location=Level%208,%20Check-In
    NSString *locationUrl = @"http://macmini2.eecs.umich.edu/Mott_Tiles/select_location.php?location=";
    // Level%208,%20Check-In";
    
    NSString *locationRequestString = [NSString stringWithFormat:@"Level %i, Check-In", intRow+2];
    
    NSString *fullLocationUrl = [locationUrl stringByAppendingString:locationRequestString];
    NSString* escapedUrlString =
    [fullLocationUrl stringByAddingPercentEscapesUsingEncoding:
     NSASCIIStringEncoding];
    NSLog(@"Escaped URL String: %@",escapedUrlString);
    
    NSData *requestData = [escapedUrlString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:escapedUrlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: requestData];
    NSURLResponse *response;
    NSData *namesResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *responseString = [[NSString alloc]initWithData:namesResponse encoding:NSUTF8StringEncoding];
    NSDictionary *namesResultsLoc = [responseString JSONValue];
    
    for(NSDictionary *names in namesResultsLoc)
    {
        [firstNames addObject:[names objectForKey:@"FIRST"]];
        [lastNames addObject:[names objectForKey:@"LAST"]];
        [picLoc addObject:[names objectForKey:@"IMAGE"]];
        [levels addObject:[names objectForKey:@"LEVEL"]];
        [rooms addObject:[names objectForKey:@"ROOM"]];
    }
    
    for(int i = 0;i<[picLoc count];i++)
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

    [self presentModalViewController:self.namesView  animated:YES];
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
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
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

//
//  ViewController.m
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "JSON.h"
#import "NamesViewController.h"
@implementation ViewController 
@synthesize enterName, namesView;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction) parseQuery {
    //enterName.text = 
    NSArray *names = [enterName.text componentsSeparatedByString:@" "];
   
     
    //NSLog(names);
   // NSLog(@"first word: %@, second word: %@",firstName, lastName);
    
//    NSString *urlString = [NSString stringWithFormat:@"http://mott-app.comule.com/selectO.php?first=%@&last=%@", firstName, lastName];
//    NSLog(urlString);
    [self getDataWithUrlNamesArray: names];
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


-(void) getDataWithUrlNamesArray:(NSArray*)namesArray {
    //NSURLRequest *request = 
    //NSString *firstName = [namesArray objectAtIndex:0];
    //NSLog(names);
    firstNames = [[NSMutableArray alloc]init];
    lastNames = [[NSMutableArray alloc]init];
    picLoc = [[NSMutableArray alloc]init];
    NSString *requestString;
    if([namesArray count]==1){
        NSLog(@"OBJECT AT INDEX 1 WAS NIL");
        requestString = [NSString stringWithFormat:@"firstName=%@",[namesArray objectAtIndex:0]];
    }else{
        requestString = [NSString stringWithFormat:@"firstName=%@&lastName=%@",[namesArray objectAtIndex:0],[namesArray objectAtIndex:1]];  
    }
    NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://macmini2.eecs.umich.edu/Mott_Tiles/select.php"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: requestData];
    NSURLResponse *response;
    NSData *namesResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *responseString = [[NSString alloc]initWithData:namesResponse encoding:NSUTF8StringEncoding];
    //NSLog(@"Response string is %@",responseString);
    namesResults = [responseString JSONValue];
    //NSLog(@"Dictionary is: %@",namesResults);
    
    for(NSDictionary *names in namesResults)
    {
        //NSLog(@"First name is %@",[names objectForKey:@"FIRST"]);
        [firstNames addObject:[names objectForKey:@"FIRST"]];
        [lastNames addObject:[names objectForKey:@"LAST"]];
        [picLoc addObject:[names objectForKey:@"IMAGE"]];
    }
    NSLog(@"CHECKPOINT...");
    
    //NSLog(@"Count of first names is %@",[firstNames count]);
    //NSLog(@"Count of last names is %@",[lastNames count]);
    /*
    for (int i = 0; i < [namesResults count]; i++) {
        NSLog(@"print %i", i);
    }
     */
    //Present Modal View controller
    NSLog(@"PICK LOCK COUNT %i",[picLoc count]);
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
    
    
    if(self.namesView==nil)
    {
        NamesViewController *nvc = [[NamesViewController alloc]initWithNibName:@"NamesViewController" bundle:[NSBundle mainBundle]];
        self.namesView = nvc;
        [nvc release];
    }
    [namesView setFirstNames:firstNames];
    [namesView setLastNames:lastNames];
    [namesView setPicLoc:picLoc];
    
    firstNames = nil;
    [firstNames release];
    lastNames = nil;
    [lastNames release];
    
    [self presentModalViewController:self.namesView animated:YES];
     

}

- (void) cacheImage:(NSData*)imageData withString:(NSString *) ImageURLString
{
    //NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    UIImage *image = [UIImage imageWithData:imageData];
    
    imageData = UIImageJPEGRepresentation(image, 100);
    NSString *uniquePath = ImageURLString;
    NSLog(@"Checking for cashed image at url %@",uniquePath);
    //UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:uniquePath]]];

    //NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", ImageURLString]]; //add our image to the path
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
    
    // Check for file existence
//    NSArray *dirPath;
//    NSString *docsDir;
//    dirPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
//                                                   NSUserDomainMask, YES);
//    docsDir = [dirPath objectAtIndex:0];
    
    
    
//    [[NSFileManager defaultManager] fileExistsAtPath: docsDir];
//    
//        NSLog(@"Making an image....");
//        // The file doesn't exist, we should get a copy of it
//        
//        // Fetch image
//        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:uniquePath]]];
//        NSLog(@"image getting cashed is %@",image);
//        
//        // Is it PNG or JPG/JPEG?
//        // Running the image representation function writes the data from the image to a file
//        if([ImageURLString rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
//        {
//            [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
//        }
//        else if(
//                [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound || 
//                [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
//                )
//        {
//            [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
//        }
    
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

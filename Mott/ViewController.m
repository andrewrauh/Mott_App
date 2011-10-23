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
    firstNames = [[NSMutableArray alloc]init];
    lastNames = [[NSMutableArray alloc]init];
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
    NSLog(@"Response string is %@",responseString);
    namesResults = [responseString JSONValue];
    NSLog(@"Dictionary is: %@",namesResults);
    
    for(NSDictionary *names in namesResults)
    {
        //NSLog(@"First name is %@",[names objectForKey:@"FIRST"]);
        [firstNames addObject:[names objectForKey:@"FIRST"]];
        [lastNames addObject:[names objectForKey:@"LAST"]];
    }
    
    //NSLog(@"Count of first names is %@",[firstNames count]);
    //NSLog(@"Count of last names is %@",[lastNames count]);
    /*
    for (int i = 0; i < [namesResults count]; i++) {
        NSLog(@"print %i", i);
    }
     */
    //Present Modal View controller
    
    if(self.namesView==nil)
    {
        NamesViewController *nvc = [[NamesViewController alloc]initWithNibName:@"NamesViewController" bundle:[NSBundle mainBundle]];
        self.namesView = nvc;
        [nvc release];
    }
    [namesView setFirstNames:firstNames];
    [namesView setLastNames:lastNames];
    [self presentModalViewController:self.namesView animated:YES];
     

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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

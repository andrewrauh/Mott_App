
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
#import "AppDelegate.h"
@implementation ViewController 
@synthesize enterName, namesView, navBar, aboutView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Search", @"Search");
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"06-magnify.png"] tag:0];
        //self.tabBarItem.title = @"Search";
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"tile_projectED.png"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    /*UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"tile_project.png"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];*/
//    [self.textField setDelegate:self];
//    [self.textField setReturnKeyType:UIReturnKeyDone];
//    [self.textField addTarget:self
//                       action:@selector(textFieldFinished:)
//             forControlEvents:UIControlEventEditingDidEndOnExit];
     
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction) parseQuery {
    NSString *trimmedString = [enterName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"Trimmed string: %@, count is %i",trimmedString, [trimmedString length]);

    NSArray *names = [trimmedString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for(int i =0;i<[names count];i++)
    {
        NSLog(@"Object at index %i is %@",i,[names objectAtIndex:i]);
    }
     
    //NSLog(names);
   // NSLog(@"first word: %@, second word: %@",firstName, lastName);
    
//    NSString *urlString = [NSString stringWithFormat:@"http://mott-app.comule.com/selectO.php?first=%@&last=%@", firstName, lastName];
//    NSLog(urlString);
    [self getDataWithUrlNamesArray: names];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

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
    NSMutableArray*  firstNames = [[NSMutableArray alloc]init];
    NSMutableArray* lastNames = [[NSMutableArray alloc]init];
    NSMutableArray* picLoc = [[NSMutableArray alloc]init];
    NSMutableArray* levels = [[NSMutableArray alloc]init];
    NSMutableArray* rooms = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    
    if([namesArray count] == 2)
    {
        NSLog(@"names array count was %@ and %@",[namesArray objectAtIndex:0],[namesArray objectAtIndex:1]);
        for(int i =0;i<[appDelegate.firstNames count];i++)
        {
            NSString *stringToSearch = [appDelegate.firstNames objectAtIndex:i];
            if(([[stringToSearch lowercaseString]  rangeOfString:[[namesArray objectAtIndex:0]lowercaseString]].location == NSNotFound) && ([[stringToSearch lowercaseString] rangeOfString:[[namesArray objectAtIndex:1]lowercaseString]].location == NSNotFound))
            {
                NSLog(@"Both words from text field were not found in first names array");
                stringToSearch = [appDelegate.lastNames objectAtIndex:i];
                if(([[stringToSearch lowercaseString] rangeOfString:[[namesArray objectAtIndex:0]lowercaseString]].location == NSNotFound) && ([[stringToSearch lowercaseString] rangeOfString:[[namesArray objectAtIndex:1]lowercaseString]].location == NSNotFound))
                {
                    NSLog(@"Both words from text field were not found in last names array");
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
                      
    }
    else
    {
        NSLog(@"names array count was 1");
        for(int i =0;i<[appDelegate.firstNames count];i++)
        {
            NSString *stringToSearch = [appDelegate.firstNames objectAtIndex:i];
            if(([[stringToSearch lowercaseString] rangeOfString:[[namesArray objectAtIndex:0]lowercaseString]].location == NSNotFound))
            {
                NSLog(@"Both words from text field were not found in first names array");
                stringToSearch = [appDelegate.lastNames objectAtIndex:i];
                if(([[stringToSearch lowercaseString] rangeOfString:[[namesArray objectAtIndex:0]lowercaseString]].location == NSNotFound))
                {
                    NSLog(@"Both words from text field were not found in last names array");
                }
                else
                {
                    //Add to arrays
                    [firstNames addObject:[appDelegate.firstNames objectAtIndex:i]];
                    [lastNames addObject:[appDelegate.lastNames objectAtIndex:i]];
                    [picLoc addObject:[appDelegate.imagePaths objectAtIndex:i]];
                    [levels addObject:[appDelegate.levels objectAtIndex:i]];
                    [rooms addObject:[appDelegate.rooms objectAtIndex:i]];
                }
            }
            else
            {
                //Add to arrays
                [firstNames addObject:[appDelegate.firstNames objectAtIndex:i]];
                [lastNames addObject:[appDelegate.lastNames objectAtIndex:i]];
                [picLoc addObject:[appDelegate.imagePaths objectAtIndex:i]];
                [levels addObject:[appDelegate.levels objectAtIndex:i]];
                [rooms addObject:[appDelegate.rooms objectAtIndex:i]];
            }
            
        }
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
    [namesView setPicLoc:picLoc];
    [namesView setLevels:levels];
    [namesView setRooms:rooms];
    
    firstNames = nil;
    [firstNames release];
    lastNames = nil;
    [lastNames release];
    picLoc = nil;
    [picLoc release];
    levels = nil;
    [levels release];
    rooms = nil;
    [rooms release];
    
    //[self presentModalViewController:self.namesView animated:YES];
    [self.enterName resignFirstResponder];
    [self.enterName setText:@""];
    [[self.tabBarController.viewControllers objectAtIndex:0] pushViewController:namesView animated:YES];
    //[self presentModalViewController:self.namesView animated:YES];
    
}
/*
-(IBAction)openAboutUs:(id)sender {
    
    if(self.aboutView==nil)
    {
        aboutViewController *abv = [[aboutViewController alloc]initWithNibName:@"aboutViewController" bundle:[NSBundle mainBundle]];
        self.aboutView = abv;
        [self presentModalViewController:abv animated:YES];
        [abv release];
    }
    
    
}
 */

- (void)textFieldDidEndEditing:(UITextField *)textFieldd
{
    NSLog(@"Text field did end ediitng..");

}

- (BOOL)textFieldShouldReturn:(UITextField *)textF
{
    NSString *trimmedString = [enterName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"Trimmed string: %@, count is %i",trimmedString, [trimmedString length]);
    
    NSArray *names = [trimmedString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for(int i =0;i<[names count];i++)
    {
        NSLog(@"Object at index %i is %@",i,[names objectAtIndex:i]);
    }
    
    //NSLog(names);
    // NSLog(@"first word: %@, second word: %@",firstName, lastName);
    
    //    NSString *urlString = [NSString stringWithFormat:@"http://mott-app.comule.com/selectO.php?first=%@&last=%@", firstName, lastName];
    //    NSLog(urlString);
    [self getDataWithUrlNamesArray: names];
   
    return NO;
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

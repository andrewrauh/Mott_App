//
//  ViewController.m
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
@implementation ViewController 
@synthesize enterName;



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
    NSString *firstName = [names objectAtIndex:0];
    //NSLog(names);
    NSString *lastName = [names objectAtIndex:1];
    /*for (int i = 0; i < 2; i++) {
        NSString *name = [names objectAtIndex:i];
        NSLog(@"%@", name);
                        
    }
     */
    NSLog(@"first word: %@, second word: %@",firstName, lastName);
    
//    NSString *urlString = [NSString stringWithFormat:@"http://mott-app.comule.com/selectO.php?first=%@&last=%@", firstName, lastName];
//    NSLog(urlString);
    
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


-(void) getDataWithUrlString:(NSString*)urlString {
    
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

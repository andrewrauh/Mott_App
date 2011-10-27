//
//  TileDisplayView.m
//  Mott
//
//  Created by Andrew Rauh on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TileDisplayView.h"

@implementation TileDisplayView
@synthesize firstName, lastName, fullName, firstNameLabel, lastNameLabel, picLoc, imageView, navBar1, level, room, secondLabel;


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
    //UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bgE.png"]];
    self.navBar1.topItem.title = @"Test";

    //self.view.backgroundColor = background;

    
    // Do any additional setup after loading the view from its nib.
}
- (UIImage *) getCachedImage: (NSString *) ImageURLString 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", ImageURLString]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    fullName = [[firstName stringByAppendingString:@" "] stringByAppendingString:lastName];

    
    NSString *secondLabelContent = [[level stringByAppendingString:@", "]stringByAppendingString:room];
    firstNameLabel.text = fullName;
    
    imageView.image = [self getCachedImage:picLoc];
    firstNameLabel.textAlignment = UITextAlignmentCenter;
    secondLabel.text = secondLabelContent;
    secondLabel.textAlignment = UITextAlignmentCenter;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)dismissModal:(id)sender{
    firstNameLabel.text = @" ";
    //lastNameLabel.text = @" ";
    [self dismissModalViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

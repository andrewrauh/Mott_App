//
//  AppDelegate.m
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "LocationSearchView.h"
#import "aboutViewController.h"
#import <sqlite3.h>
@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize firstNames, lastNames, locations, databaseImages, thumbnailImages;

- (void)dealloc
{
    [firstNames release];
    [lastNames release];
    [locations release];
    [databaseImages release];
    [thumbnailImages release];
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    /*
    UINavigationController *navigationController = nil;
    navigationController = [[UINavigationController alloc] initWithRootViewController:<Your View controller1>];
    [tabBarViewControllers addObject:navigationController];
    [navigationController release];
    navigationController = nil;
    */
    
    UIViewController *viewController1 = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];    
    UINavigationController *navigationController1 = [[[UINavigationController alloc]initWithRootViewController:viewController1]autorelease];
    //navigationController1.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navigationController1.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:2.0f/255.0f blue:94.0f/255.0f alpha:1.0f];

    //navigationController1.navigationBar.tintC[UIColor blueColor];:1.0f];


    UIViewController *viewController2 = [[[LocationSearchView alloc]initWithNibName:@"LocationSearchView" bundle:nil]autorelease];
    UINavigationController *navigationController2 = [[[UINavigationController alloc]initWithRootViewController:viewController2]autorelease];
    navigationController2.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:2.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    
    UIViewController *viewController3 = [[[aboutViewController alloc] initWithNibName:@"aboutViewController" bundle:nil] autorelease];
    UINavigationController *navigationController3 = [[[UINavigationController alloc]initWithRootViewController:viewController3]autorelease];
    navigationController3.navigationBar.tintColor = [UIColor colorWithRed:0.0f/255.0f green:2.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    
    //UIViewController *viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController1,navigationController2, navigationController3, nil];
    self.window.rootViewController = self.tabBarController;
    
    //Set up SQlite Database
    databaseName = @"data.db";
    
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
	// Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
    
	// Query the database for all animal records and construct the "animals" array
	[self readKidsFromDatabase];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) checkAndCreateDatabase
{
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
	[fileManager release];
}

-(void) readKidsFromDatabase
{
    // Setup the database object
	sqlite3 *database;
    
	// Init the animals Array
	firstNames  = [[NSMutableArray alloc] init];
    lastNames = [[NSMutableArray alloc]init];
    locations = [[NSMutableArray alloc]init];
    databaseImages = [[NSMutableArray alloc]init];
    thumbnailImages = [[NSMutableArray alloc]init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from children";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *lastName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *firstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *location = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString *image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSString *thumbnail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                NSLog(@"Location: %@",location);
                
                [firstNames addObject:firstName];
                [lastNames addObject:lastName];
                [locations addObject:location];
                [databaseImages addObject:image];
                [thumbnailImages addObject:thumbnail];
                
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end

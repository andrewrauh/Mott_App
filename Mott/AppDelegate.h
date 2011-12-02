//
//  AppDelegate.h
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    // Database variables
	NSString *databaseName;
	NSString *databasePath;
    
	// Array to store the animal objects
	NSMutableArray *firstNames;
    NSMutableArray *lastNames;
    NSMutableArray *locations;
    NSMutableArray *databaseImages;
    NSMutableArray *thumbnailImages;
    /*
        firstNames
        lastNames
        locations
        databaseImages
        thumbnailImages
     */
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSMutableArray *firstNames;
@property (nonatomic,retain) NSMutableArray *lastNames;
@property (nonatomic,retain) NSMutableArray *locations;
@property (nonatomic,retain) NSMutableArray *databaseImages;
@property (nonatomic,retain) NSMutableArray *thumbnailImages;

@property (strong, nonatomic) UITabBarController *tabBarController;

-(void) checkAndCreateDatabase;
-(void) readKidsFromDatabase;

@end

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
    NSMutableArray *levels;
    NSMutableArray *rooms;
    NSMutableArray *imagePaths;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSMutableArray *firstNames;
@property (nonatomic,retain) NSMutableArray *lastNames;
@property (nonatomic,retain) NSMutableArray *levels;
@property (nonatomic,retain) NSMutableArray *rooms;
@property (nonatomic,retain) NSMutableArray *imagePaths;

@property (strong, nonatomic) UITabBarController *tabBarController;

-(void) checkAndCreateDatabase;
-(void) readKidsFromDatabase;

@end

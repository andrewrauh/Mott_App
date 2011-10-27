//
//  LevelNamesTableViewController.h
//  Mott
//
//  Created by Andrew Rauh on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileDisplayView.h"

@interface LevelNamesTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource > {
    NSMutableArray *firstNamesL;
    NSMutableArray *lastNamesL;
    TileDisplayView *tileDisplayView;
    UITableView *tView;
    NSMutableArray *picLocL;
    NSMutableArray *levelsL;
    NSMutableArray *roomsL;
}

@property (nonatomic,retain) IBOutlet UITableView *tView;
@property (nonatomic, retain) NSMutableArray *firstNamesL;
@property (nonatomic,retain)NSMutableArray *lastNamesL;
@property (nonatomic, retain) NSMutableArray *picLocL;
@property (nonatomic,retain)NSMutableArray *levelsL;
@property (nonatomic,retain)NSMutableArray *roomsL;
@property (nonatomic,retain)TileDisplayView *tileDisplayView;
-(IBAction)dismissThis:(id)sender;
- (UIImage *) getCachedImage: (NSString *) ImageURLString;
@end
//TODO: pass data from Location view controller to this. 
//fill content 
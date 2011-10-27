//
//  LocationSearch.h
//  Mott
//
//  Created by Andrew Rauh on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "LevelNamesTableViewController.h"

@interface LocationSearch : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSDictionary  *namesResultsLoc;
    LevelNamesTableViewController *levelNamesTableViewController;
    
    
    IBOutlet UITableView *tbView;
}
-(void) getItemsForLevel:(NSInteger *) intRow;
@property (nonatomic, retain) NSDictionary *namesResultsLoc;
@property (nonatomic, retain ) LevelNamesTableViewController *levelNamesTableViewController;
- (void) cacheImage:(NSData*)imageData withString:(NSString *) ImageURLString;

@end

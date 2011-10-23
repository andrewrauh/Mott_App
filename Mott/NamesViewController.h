//
//  NamesViewController.h
//  Mott
//
//  Created by Andrew Rauh on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileDisplayView.h"
@interface NamesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource >{
    IBOutlet UITableView *tbView; 
    NSMutableArray *firstNames;
    NSMutableArray *lastNames;
    TileDisplayView *tileDisplayView;
}
@property (nonatomic,retain) IBOutlet UITableView *tbView;
@property (nonatomic, retain) NSMutableArray *firstNames;
@property (nonatomic,retain)NSMutableArray *lastNames;
@property (nonatomic,retain)TileDisplayView *tileDisplayView;
-(IBAction)dismissModal:(id)sender;
@end

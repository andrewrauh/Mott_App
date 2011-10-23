//
//  NamesViewController.h
//  Mott
//
//  Created by Andrew Rauh on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource >{
    IBOutlet UITableView *tbView; 
    NSMutableArray *firstNames;
    NSMutableArray *lastNames;
}
@property (nonatomic,retain) IBOutlet UITableView *tbView;
@property (nonatomic, retain) NSMutableArray *firstNames;
@property (nonatomic,retain)NSMutableArray *lastNames;
@end

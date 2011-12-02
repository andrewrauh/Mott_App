//
//  Rooms.h
//  Mott
//
//  Created by Chris Wendel on 12/1/11.
//  Copyright (c) 2011 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NamesViewController.h"
@interface Rooms : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tbView;
    NSMutableArray *roomsArray;
    int level;
    NamesViewController *namesView;
}
@property (nonatomic,retain) IBOutlet UITableView *tbView;
@property (nonatomic,retain) NSMutableArray *roomsArray;
@property (nonatomic) int level;
@property (nonatomic,retain) NamesViewController *namesView; 
@end

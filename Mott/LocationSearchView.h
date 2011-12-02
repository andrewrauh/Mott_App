//
//  LocationSearchView.h
//  Mott
//
//  Created by Chris Wendel on 10/28/11.
//  Copyright (c) 2011 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rooms.h"
@interface LocationSearchView : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tbView;
    Rooms *rooms;
}
@property(nonatomic,retain)IBOutlet UITableView *tbView;
@property(nonatomic,retain)Rooms *rooms;

-(void) getItemsForLevel:(NSInteger) intRow;

@end

//
//  TileDisplayView.h
//  Mott
//
//  Created by Andrew Rauh on 10/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TileDisplayView : UIViewController{
    NSString *firstName;
    NSString *lastName;
    IBOutlet    UILabel *firstNameLabel;
    IBOutlet    UILabel *lastNameLabel;
}
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastNameLabel;


-(IBAction)dismissModal:(id)sender;

@end

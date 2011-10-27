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
    NSString *picLoc;
    NSString *level;
    NSString *room;
    NSString *fullName;
    IBOutlet    UILabel *firstNameLabel;
    IBOutlet    UILabel *lastNameLabel;
    IBOutlet    UILabel *secondLabel;
    IBOutlet    UIImageView *imageView;
    IBOutlet UINavigationBar *navBar1;
}
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *picLoc;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *room;
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (UIImage *) getCachedImage: (NSString *) ImageURLString;
@property(nonatomic, retain) IBOutlet UINavigationBar *navBar1;


-(IBAction)dismissModal:(id)sender;

@end

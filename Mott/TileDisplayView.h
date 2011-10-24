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
    IBOutlet    UILabel *firstNameLabel;
    IBOutlet    UILabel *lastNameLabel;
    IBOutlet    UIImageView *imageView;
}
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *picLoc;
@property (nonatomic, retain) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (UIImage *) getCachedImage: (NSString *) ImageURLString;


-(IBAction)dismissModal:(id)sender;

@end

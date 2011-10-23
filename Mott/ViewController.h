//
//  ViewController.h
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NamesViewController.h"
@protocol NSCoding;

@interface ViewController : UIViewController{
    IBOutlet UITextField *enterName;
    IBOutlet UIButton *enter;
    NSDictionary  *namesResults;
    NSMutableArray *firstNames;
    NSMutableArray *lastNames;
    NamesViewController *namesView;

}

-(IBAction)parseQuery:(id)sender;

@property(nonatomic, retain) UITextField *enterName;
@property(nonatomic, retain) NamesViewController *namesView;

-(void) getDataWithUrlNamesArray:(NSArray*)namesArray;
@end

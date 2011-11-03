//
//  ViewController.h
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NamesViewController.h"
#import "aboutViewController.h"
@protocol NSCoding;

@interface ViewController : UIViewController{
    IBOutlet UITextField *enterName;
    IBOutlet UIButton *enter;
    NSDictionary  *namesResults;
    NamesViewController *namesView;

    IBOutlet UINavigationBar *navBar;
    aboutViewController *aboutView;

}

-(IBAction)parseQuery:(id)sender;
-(IBAction)openAboutUs:(id)sender;

@property(nonatomic, retain) UITextField *enterName;
@property(nonatomic, retain) NamesViewController *namesView;
@property(nonatomic, retain) UINavigationBar *navBar;
@property(nonatomic, retain) aboutViewController *aboutView;

-(void) getDataWithUrlNamesArray:(NSArray*)namesArray;

@end

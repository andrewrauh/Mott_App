//
//  ViewController.h
//  Mott
//
//  Created by Andrew Rauh on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UITextField *enterName;
    IBOutlet UIButton *enter;

}

-(IBAction)parseQuery:(id)sender;

@property(nonatomic, retain) UITextField *enterName;

@end

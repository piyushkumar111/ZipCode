//
//  LocationVC.h
//  zipCoder
//
//  Created by Pradip Moradiya on 9/10/15.
//  Copyright (c) 2015 Pradip Moradiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationVC : UIViewController

@property (nonatomic,retain) IBOutlet UIButton *btnGet;
@property (nonatomic,retain) IBOutlet UIButton *btnZipcode;
@property (nonatomic,retain) IBOutlet UIButton *btnAddress;

-(IBAction)btnZipcodeClicked:(id)sender;

@end

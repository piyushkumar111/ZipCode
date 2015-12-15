//
//  HomeVC.h
//  zipCoder
//
//  Created by Piyush Kachariya on 9/21/15.
//  Copyright © 2015 Pradip Moradiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,retain) IBOutlet UITextField *txtPassword;
@property (nonatomic,retain) IBOutlet UIButton *btnVerify;


@end

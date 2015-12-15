//
//  HomeVC.m
//  zipCoder
//
//  Created by Piyush Kachariya on 9/21/15.
//  Copyright © 2015 Pradip Moradiya. All rights reserved.
//

#import "HomeVC.h"
#import "LocationVC.h"

@interface HomeVC ()

@end

AppDelegate *app;

@implementation HomeVC


- (void)viewDidLoad {
    app = APP_DELEGATE;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
        _txtPassword.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnVerifyClicked:(id)sender
{
    [self.view endEditing:YES];
    if ([app.strPassword isEqualToString:_txtPassword.text])
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Logged in successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        errorAlert.tag = 1;
        [errorAlert show];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        errorAlert.tag = 2;
        [errorAlert show];
    }
}

#pragma mark - Alertview delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            [self.view endEditing:YES];
            LocationVC *LocationVC = loadViewController(TMStoryboard_Main,@"LocationVC");
            self.navigationController.navigationBar.hidden=YES;
            [self.navigationController pushViewController:LocationVC animated:YES];
        }
    }
}

#pragma mark - Textfield delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}

@end

//
//  LoginSuccessViewController.m
//  ReactiveCocoaMVVMDemo
//
//  Created by Apple on 15/11/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "LoginSuccessViewController.h"

@interface LoginSuccessViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (strong, nonatomic) IBOutlet UIButton *goBack;

@end

@implementation LoginSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setFrame];
}

- (void)setFrame
{
    CGRect all = [UIScreen mainScreen].bounds;
    _userInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, all.size.width, 25)];
    _userInfoLabel.text = [NSString stringWithFormat:@"用户名：%@,  密码：%@", _userName, _password];
    _userInfoLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:_userInfoLabel];
}


- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

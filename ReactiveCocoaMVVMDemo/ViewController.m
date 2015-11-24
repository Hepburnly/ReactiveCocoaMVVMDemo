//
//  ViewController.m
//  ReactiveCocoaMVVMDemo
//
//  Created by Apple on 15/11/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "viewModel.h"
#import "LoginSuccessViewController.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "UITextField+RACSignalSupport.h"
#import "RACEXTScope.h"
#import "RACSignal.h"
#import "RACSubject.h"

#import "UIControl+RACSignalSupport.h"


typedef void(^SignInRespongse)(BOOL result);

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) viewModel *viewModel;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect all = [UIScreen mainScreen].bounds;
    _userNameTextField.frame = CGRectMake(10, 100, all.size.width - 20, 30);
    _passwordTextField.frame = CGRectMake(10, 150, all.size.width - 20, 30);
    _loginBtn.frame = CGRectMake(all.size.width - 15, 180, 30, 30);
    [self.view addSubview:_userNameTextField];
    [self.view addSubview:_passwordTextField];
    [self.view addSubview:_loginBtn];
    [self contactModel];
    [self onClick];
}

//关联ViewModel
- (void)contactModel
{
    _viewModel = [[viewModel alloc] init];
    
    RAC(self.viewModel,userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginBtn, enabled) = [_viewModel buttonIsValid];
    
    @weakify(self);
    
    [self.viewModel.successObject subscribeNext:^(NSArray * x) {
        @strongify(self);
        LoginSuccessViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginSuccessViewController"];
        vc.userName = x[0];
        vc.password = x[1];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }];
    
    //fail
    [self.viewModel.failureObject subscribeNext:^(id x) {
        
    }];
    
    //error
    [self.viewModel.errorObject subscribeNext:^(id x) {
        
    }];
    
}

- (void)onClick {
    //按钮点击事件
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [_viewModel login];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  viewModel.m
//  ReactiveCocoaMVVMDemo
//
//  Created by Apple on 15/11/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "viewModel.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSubject.h"
#import "RACSignal+Operations.h"

@interface viewModel ()
@property (nonatomic, strong) RACSignal *userNameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) NSArray *requestData;

@end

@implementation viewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _userNameSignal = RACObserve(self, userName);
    _passwordSignal = RACObserve(self, password);
    _successObject = [RACSubject subject];
    _failureObject = [RACSubject subject];
    _errorObject = [RACSubject subject];
}


- (id) buttonIsValid
{
    RACSignal *isValid = [RACSignal combineLatest:@[_userNameSignal,_passwordSignal] reduce:^id(NSString *userName, NSString *password){
        return @(userName.length >= 3 && password.length >= 3);
    }];
    return isValid;
}

- (void)login
{
    //网络请求进行登录
    _requestData = @[_userName,_password];
    //成功发送成功的信号
    [_successObject sendNext:_requestData];
    //业务逻辑失败和网络请求失败
    NSString *str = [NSString stringWithFormat:@"网络不好，请稍后再试"];
    [_failureObject sendNext:str];
    [_errorObject sendNext:str];
}
@end

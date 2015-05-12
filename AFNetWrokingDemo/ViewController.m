//
//  ViewController.m
//  AFNetWrokingDemo
//
//  Created by zhangyafeng on 15/5/12.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
/**
    AFNetWorking的使用
 1、get请求  2. post请求  3、上传图片  4、下载 5、判断当前网络的情况
 */

#define Kuaishou_URL @"http://api.gifshow.com/rest/n/feed/list?type=7&c=MYAPP&device_id=ANDROID_6662b7697026605f&ver=3.98&sys=19&ud=14274390"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

-(void)requestData
{
    
//    NSDictionary*parameters=@{@"type":@"7",@"page":@"1",@"token":@"0c0e9a6e25d947fcaf7488d45b1ffea5-14274390",@"count":@"20",@"last":@"589328",@"mtype":@"2",@"vtype":@"1",@"pcursor":@"",@"os":@"android",@"client_key":@"6bcc9821",@"network":@"WIFI",@"sig":@"3e20376180f73316e0e6e4acdfd6c85d"};

    
    
    NSDictionary *parameters = @{@"type":@"7",@"page":@"1",@"token":@"0c0e9a6e25d947fcaf7488d45b1ffea5-14274390",@"count":@"20",@"last":@"589328",@"mtype":@"2",@"vtype":@"1",@"pcursor":@"",@"os":@"android",@"client_key":@"6bcc9821",@"network":@"WIFI",@"sig":@"3e20376180f73316e0e6e4acdfd6c85d"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:Kuaishou_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error.description);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

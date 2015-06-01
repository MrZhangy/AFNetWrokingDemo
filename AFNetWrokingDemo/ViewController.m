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
    NSDictionary *parameters = @{@"type":@"7",@"page":@"1",@"token":@"0c0e9a6e25d947fcaf7488d45b1ffea5-14274390",@"count":@"20",@"last":@"589328",@"mtype":@"2",@"vtype":@"1",@"pcursor":@"",@"os":@"android",@"client_key":@"6bcc9821",@"network":@"WIFI",@"sig":@"3e20376180f73316e0e6e4acdfd6c85d"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

 //通过post请求数据
    [manager POST:Kuaishou_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error.description);
    }];
}


- (IBAction)uploadMoreImage:(id)sender {
    UIImage *image = [UIImage imageNamed:@"0.png"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username": @"zhangcheng0111",@"password":@"123456"};
    [manager POST:@"http://10.0.8.8/sns/my/upload_photo.php" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:imageData name:@"attach"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

#define kMP4URL @"http://ws.a.yximgs.com/upic/2015/05/11/21/BMjAxNTA1MTEyMTA1MDlfNjk2MDMzM18yMjE3NjA0NjZfMV8z.mp4"
- (IBAction)downLoadMP4File:(id)sender {
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kMP4URL]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //设置存储路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:kMP4URL.lastPathComponent];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    //设置下载进度检测
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"bytesRead: %u, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
    
    //检测是否下载成功
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
    
}


@end

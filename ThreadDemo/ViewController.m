//
//  ViewController.m
//  ThreadDemo
//
//  Created by CSMBP on 2018/7/18.
//  Copyright © 2018年 josh. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadDemo.h"
#import "GCDDemo.h"
#import "NSOperationDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSThreadDemo *threadDemo = [[NSThreadDemo alloc] init];
//    [threadDemo createFourThread_safe_model];
    
    //GCD
//    GCDDemo *gcdDemo = [[GCDDemo alloc] init];
//    [gcdDemo createGCDThread];
    
//    NSOperation
    NSOperationDemo *operationDemo = [NSOperationDemo new];
    [operationDemo createOperation];
}


@end

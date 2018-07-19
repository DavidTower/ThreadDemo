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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSThreadDemo *threadDemo = [[NSThreadDemo alloc] init];
//    [threadDemo createFourThread_safe_model];
    
    //GCD
    GCDDemo *gcdDemo = [[GCDDemo alloc] init];
    [gcdDemo createGCDThread];
}


@end

//
//  NSOperationDemo.m
//  ThreadDemo
//
//  Created by CSMBP on 2018/7/19.
//  Copyright © 2018年 josh. All rights reserved.
//

#import "NSOperationDemo.h"

@implementation NSOperationDemo
- (void)createOperation{
//    [self testInvocationOperation];
//    [self testBlockOperation];
//    [self testDepenceyOperation];
    [self testMacConcurrentOperationCount];
}
#pragma mark -- NSInvocationOperation operation
- (void)testInvocationOperation {
    //创建一个NSInvocationOperation
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationTest) object:nil];
    //调用start方法执行，此执行方式在主线程中执行，没有开辟新的线程
//    ThreadDemo[20397:12090175] ------------<NSThread: 0x60400007da00>{number = 1, name = main}-----
//        [operation start];
    
    //加入到队列中去执行，此种方式会开辟线程，在新的线程中执行代码
//    ThreadDemo[20432:12091400] ------------<NSThread: 0x600000273240>{number = 3, name = (null)}-----
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
- (void)invocationTest {
    NSLog(@"------------%@-----", [NSThread currentThread]);
}
#pragma mark -- NSBlockOperation operation
- (void)testBlockOperation {
    //创建NSBlockOperation线程方式1
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"------operation------%@-----", [NSThread currentThread]);
//    }];
//    [operation start];
    //创建NSBlockOperation线程方式2
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    //添加任务
    [operation addExecutionBlock:^{
        NSLog(@"------block1------%@-----", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"------block2------%@-----", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"------block3------%@-----", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"------block4------%@-----", [NSThread currentThread]);
    }];
    //创建queue队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
//    [operation1 start];
}
#pragma mark -- NSOperationQueue operation
/**
 使用queue队列来自己添加任务并执行
 */
- (void)testOperationQueue {
    //创建queue队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //添加任务
    [queue addOperationWithBlock:^{
        NSLog(@"------block1------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block2------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block3------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block4------%@-----", [NSThread currentThread]);
    }];
}
#pragma mark --  使用场景介绍
/**
 使用场景一：任务的依赖执行
 */
- (void)testDepenceyOperation {
    //创建要执行的任务
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"------operation1------%@-----", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"------operation2------%@-----", [NSThread currentThread]);
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"------operation3------%@-----", [NSThread currentThread]);
    }];
    //给任务添加依赖，任务3依赖任务2，任务2依赖任务1
    [operation3 addDependency:operation2];
    [operation2 addDependency:operation1];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
}

/**
 使用场景二：设置最大并发数量，为了保证app的整个生命周期不会占用过多的资源，在有大量并发线程执行的时候，一定要进行设置，不然可能会造成app闪退
 */
- (void)testMacConcurrentOperationCount {
    //创建queue队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置线程的最大并发数量
    queue.maxConcurrentOperationCount = 3;
    //添加任务
    [queue addOperationWithBlock:^{
        NSLog(@"------block1------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block2------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block3------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block4------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block5------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block6------%@-----", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"------block7------%@-----", [NSThread currentThread]);
    }];
}
@end

//
//  NSThreadDemo.m
//  ThreadDemo
//
//  Created by CSMBP on 2018/7/18.
//  Copyright © 2018年 josh. All rights reserved.
//

#import "NSThreadDemo.h"
@interface NSThreadDemo()
@property (nonatomic, assign) NSInteger  ticket_counts;
@property (nonatomic, strong) NSThread   *thread1;
@property (nonatomic, strong) NSThread   *thread2;
@property (nonatomic, strong) NSThread   *thread3;
@property (nonatomic, strong) NSThread   *thread4;
@property (nonatomic, strong) NSLock   *lock;
@end
@implementation NSThreadDemo
#pragma mark -- 创建线程的方式
- (void) createNSThread1 {
    //创建线程的第一种方法，此种方式创建的线程不会自启动，需要调用start来启动线程
//    NSThread *thread = [[NSThread alloc] initWithBlock:<#^(void)block#>];这种方式创建的线程的执行代码直接放在代码块里面执行
    
    //先创建对象，然后调用perform的一系列方法，也能执行线程的执行
//    NSThread *thread = [[NSThread alloc] init];
//    [thread performSelectorInBackground:<#(nonnull SEL)#> withObject:<#(nullable id)#>];
//    [thread performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>];
//    [thread performSelector:<#(SEL)#> withObject:<#(id)#>];
//    [thread performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>];
//    [thread performSelector:<#(nonnull SEL)#> onThread:<#(nonnull NSThread *)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    [thread start];//启动线程
}
- (void) createNSThread2 {
    //创建线程的第二种方法，使用此种方法创建的线程会自启动
//    [NSThread detachNewThreadWithBlock:<#^(void)block#>];
    [NSThread detachNewThreadSelector:@selector(threadRun) toTarget:self withObject:nil];
}
- (void) createNSThread3 {
    //创建线程的第三种方式，隐试的创建线程
//    [self performSelector:@selector(threadRun) withObject:self afterDelay:0];afterDelay表示可以延时多长时间执行线程
//    [self performSelectorOnMainThread:@selector(threadRun) withObject:self waitUntilDone:<#(BOOL)#>];waitUntilDone表示是否等待线程执行完再往下进行,会阻塞当前程序运行
//    [self performSelectorInBackground:<#(nonnull SEL)#> withObject:<#(nullable id)#>];在后台运行线程，意味着开辟新线程
    [self performSelector:@selector(threadRun) withObject:self];
}
- (void)threadRun {
    NSLog(@"=========%@", [NSThread currentThread]);
}

#pragma mark -- 线程通信和设置线程名称
- (void)setThreadName:(NSString *)threadName {
    //创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun1:) object:@"https://xxxx.png"];//object中存放的对象，可以通过传递给threadRun1，来完成通信
    thread.name = threadName;//设置线程名称
    [thread start];//启动线程
}
- (void)threadRun1:(NSString *)url {
    NSLog(@"==========%@===========%@", [NSThread currentThread], url);
    for (NSUInteger i = 1; i < 10000; i ++) {
        if (100 == i) {
            //在线程执行的过程中，遇到某个条件需要推出线程，可以使用return或者[NSThread exit]来推出线程的执行
//            [NSThread exit];
            return;
        }
    }
    [NSThread exit];
}
#pragma mark -- 线程安全问题
- (void)createFourThread_notsafe_model {
    self.ticket_counts = 100;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_notsafe_model) object:nil];
    self.thread1.name = @"thread1";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_notsafe_model) object:nil];
    self.thread2.name = @"thread2";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_notsafe_model) object:nil];
    self.thread3.name = @"thread3";
    
    self.thread4 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_notsafe_model) object:nil];
    self.thread4.name = @"thread4";
    
    //开启线程
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
    [self.thread4 start];
}
- (void)saleTicket_notsafe_model{
    while (true) {
        if (self.ticket_counts > 0) {
            self.ticket_counts -= 1;
            NSLog(@"thread.name----%@       tickets_left-------%d",[NSThread currentThread].name, self.ticket_counts);
        } else {
            return;
        }
    }
}
- (void)createFourThread_safe_model {
    self.ticket_counts = 100;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_safe_model) object:nil];
    self.thread1.name = @"thread1";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_safe_model) object:nil];
    self.thread2.name = @"thread2";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_safe_model) object:nil];
    self.thread3.name = @"thread3";
    
    self.thread4 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket_safe_model) object:nil];
    self.thread4.name = @"thread4";
    
    //开启线程
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
    [self.thread4 start];
}
- (void)saleTicket_safe_model{
    while (true) {
        if (self.ticket_counts > 0) {
            self.ticket_counts -= 1;
            NSLog(@"thread.name----%@       tickets_left-------%d",[NSThread currentThread].name, self.ticket_counts);
        } else {
            return;
        }
    }
}
@end

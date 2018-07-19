//
//  GCDDemo.m
//  ThreadDemo
//
//  Created by CSMBP on 2018/7/18.
//  Copyright © 2018年 josh. All rights reserved.
//

#import "GCDDemo.h"
#import <UIKit/UIKit.h>

@interface GCDDemo()
@property (nonatomic, strong) dispatch_source_t timer;
@end
@implementation GCDDemo
- (void)createGCDThread {
//    [self createAsyncSerialThread];
//    [self createAsyncConcurrentThread];
//    [self createSyncSerialThread];
//    [self createSyncConcurrentThread];
//    [self createAsyncMainQueue];
//    [self createSyncMainQueue];
//    [self createTimerWithGCD];
//    [self delayGCD];
//    [self createGCDWithSignal];
    [self createGCDWithDispatch_group];
}

/**
 创建异步串行队列，会开辟新的线程，执行方式是按照顺序依次执行
 */
- (void)createAsyncSerialThread {
//    DISPATCH_QUEUE_CONCURRENT并行队列
//    DISPATCH_QUEUE_SERIAL串行队列
    dispatch_queue_t queue = dispatch_queue_create("DISPATCH_QUEUE", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"----------GCD1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD3----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD4----%@", [NSThread currentThread]);
    });
}

/**
 创建异步并行队列,会创建新的线程执行任务，执行任务的顺序随机
 */
- (void)createAsyncConcurrentThread {
    //队列优先级
    //#define DISPATCH_QUEUE_PRIORITY_HIGH 2
    //#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
    //#define DISPATCH_QUEUE_PRIORITY_LOW (-2)
    //#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
    
    //    DISPATCH_QUEUE_CONCURRENT并行队列
    dispatch_queue_t queue = dispatch_queue_create("DISPATCH_QUEUE", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"----------GCD1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD3----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD4----%@", [NSThread currentThread]);
    });
}

/**
 同步串行队列，不会开辟新的线程，在主线程中运行，执行方式是按照顺序依次执行
 */
- (void)createSyncSerialThread {
    dispatch_queue_t queue = dispatch_queue_create("DISPATCH_QUEUE", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD3----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD4----%@", [NSThread currentThread]);
    });
}
/**
 同步并行队列，不会开辟新的线程，在主线程中运行，执行方式是按照顺序依次执行
 */
- (void)createSyncConcurrentThread {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD3----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD4----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD5----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD6----%@", [NSThread currentThread]);
    });
}
- (void)createAsyncMainQueue {
    //获取主队列线程
    dispatch_queue_t queue = dispatch_get_main_queue();
    //下面添加的任务都会放到主队列中去执行
    dispatch_async(queue, ^{
        NSLog(@"----------GCD1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD3----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD4----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD5----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----------GCD6----%@", [NSThread currentThread]);
    });
}

/**
 同步主队列,项目中千万不能用，会直接卡死
 */
- (void)createSyncMainQueue {
    //获取主队列线程
    dispatch_queue_t queue = dispatch_get_main_queue();
    //下面添加的任务都会放到主队列中去执行
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD3----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD4----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD5----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"----------GCD6----%@", [NSThread currentThread]);
    });
}

/**
 GCD简单实用1、异步加载图标，然后在主线程中刷新UI
 */
- (void)downImageAndRefreshUI {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://xxxxx.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
        });
    });
}
- (void)createTimerWithGCD {
    //这种方式创建的定时器只能执行一次
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"11111");
    });
    
    //来看看另外一种定时器的实现方式
    dispatch_queue_t queue = dispatch_queue_create("timer", NULL);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    int64_t interval = (int64_t)(1 * NSEC_PER_SEC);//每秒执行一次
    //DISPATCH_TIME_NOW，dispatch_walltime(NULL, 0)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"xxxxxx");
//        dispatch_source_cancel(self.timer);
        dispatch_suspend(timer);
    });
    dispatch_resume(timer);
}

/**
 GCD延迟执行程序
 */
- (void)delayGCD {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"122");
    });
}
static GCDDemo *demo;
+ (instancetype)gcdDemo {
    if (nil == demo) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            demo = [[GCDDemo alloc] init];
        });
    }
    return demo;
}

/**
 信号量的使用
 */
- (void)createGCDWithSignal {
    dispatch_semaphore_t sema = dispatch_semaphore_create(2);//2代表并发个数为2
    for (NSInteger index = 0; index < 50; index++) {
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //在此处实现需要的代码逻辑
            dispatch_semaphore_signal(sema);//让信号量增加，执行下一次的操作
        });
    }
}
- (void)createGCDWithDispatch_group {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"----------group1----%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"----------group2----%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"----------group3----%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"----------group4----%@", [NSThread currentThread]);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"----------group_notify----%@", [NSThread currentThread]);
    });
    NSLog(@"----------wait------");
    dispatch_group_wait(group, (int64_t)(5 * NSEC_PER_SEC));
//ThreadDemo[13231:11689884] ----------group2----<NSThread: 0x60400027d900>{number = 3, name = (null)}
//ThreadDemo[13231:11689887] ----------group4----<NSThread: 0x60400027dbc0>{number = 6, name = (null)}
//ThreadDemo[13231:11689883] ----------group3----<NSThread: 0x600000267ec0>{number = 5, name = (null)}
//ThreadDemo[13231:11689885] ----------group1----<NSThread: 0x60400027d8c0>{number = 4, name = (null)}
    
}
@end

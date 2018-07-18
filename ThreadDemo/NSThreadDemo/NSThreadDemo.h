//
//  NSThreadDemo.h
//  ThreadDemo
//
//  Created by CSMBP on 2018/7/18.
//  Copyright © 2018年 josh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThreadDemo : NSObject
- (void) createNSThread1;
- (void) createNSThread2;
- (void) createNSThread3;
- (void)createFourThread_notsafe_model;
- (void)createFourThread_safe_model;
@end

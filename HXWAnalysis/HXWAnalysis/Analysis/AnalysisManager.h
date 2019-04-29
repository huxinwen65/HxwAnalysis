//
//  AnalysisManager.h
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/26.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@protocol AnalysisDelegate;
@interface AnalysisManager : NSObject
///单例，建议在AppDelegate的- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法中调用[AnalysisManager shareInstance].或者用户登录后调用
+ (AnalysisManager*)shareInstance;
///设置处理埋点逻辑代理
- (void)setDelegate:(id<AnalysisDelegate>)delegate;
///释放
+ (void)releasferAnalysisManager;
///其他创建方法不让调用
+ (instancetype) new __attribute__((unavailable("AnalysisManager类只能初始化一次")));
- (instancetype) copy __attribute__((unavailable("AnalysisManager类只能初始化一次")));
- (instancetype) mutableCopy  __attribute__((unavailable("AnalysisManager类只能初始化一次")));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable("AnalysisManager类只能初始化一次")));
@end

NS_ASSUME_NONNULL_END

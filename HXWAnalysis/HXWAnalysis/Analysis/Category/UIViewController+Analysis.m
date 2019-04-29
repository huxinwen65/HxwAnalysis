//
//  UIViewController+Analysis.m
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import "UIViewController+Analysis.h"
#import "SwizzManager.h"

static id<AnalysisDelegate> __analysisDelegateUIViewController = nil;
@implementation UIViewController (Analysis)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSel = @selector(viewDidLoad);
        SEL newSel = @selector(hxw_viewDidLoad);
        [SwizzManager swizzMethodForClass:[self class] originSel:originSel newSel:newSel];
        
        SEL originSel1 = @selector(viewWillAppear:);
        SEL newSel1 = @selector(hxw_viewWillAppear:);
        [SwizzManager swizzMethodForClass:[self class] originSel:originSel1 newSel:newSel1];
        
        SEL originSel2 = @selector(viewDidDisappear:);
        SEL newSel2 = @selector(hxw_viewDidDisappear:);
        [SwizzManager swizzMethodForClass:[self class] originSel:originSel2 newSel:newSel2];
    });
}

- (void)hxw_viewDidLoad{
    [self hxw_viewDidLoad];
    [__analysisDelegateUIViewController hxw_viewDidLoad:self];
}
- (void)hxw_viewWillAppear:(BOOL)animated{
    [self hxw_viewWillAppear:animated];
    [__analysisDelegateUIViewController hxw_viewWillAppear:animated viewController:self];
}
- (void)hxw_viewDidDisappear:(BOOL)animated{
    [self hxw_viewDidDisappear:animated];
    [__analysisDelegateUIViewController hxw_viewWillDisappear:animated viewController:self];
}

+(void)hxw_setActionTargetDelegate:(id<AnalysisDelegate>)analysisDelegate{
    __analysisDelegateUIViewController = analysisDelegate;
}
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}
@end

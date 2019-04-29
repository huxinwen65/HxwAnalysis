//
//  UIControl+Analysis.m
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/26.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import "UIControl+Analysis.h"
#import "SwizzManager.h"

static id<AnalysisDelegate> __analysisDelegateUIControl = nil;
@implementation UIControl (Analysis)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class clazz = [self class];
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL newSelector = @selector(hxw_sendAction:to:forEvent:);
        [SwizzManager swizzMethodForClass:clazz originSel:originalSelector newSel:newSelector];
        
    });
    
}
///自定义发送点击响应方法
-(void)hxw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self hxw_sendAction:action to:target forEvent:event];
    [__analysisDelegateUIControl hxw_UIControlSendAction:action target:target forEvent:event];
    
}

+(void)hxw_setActionTargetDelegate:(id<AnalysisDelegate>)analysisDelegate{
    __analysisDelegateUIControl = analysisDelegate;
}
@end

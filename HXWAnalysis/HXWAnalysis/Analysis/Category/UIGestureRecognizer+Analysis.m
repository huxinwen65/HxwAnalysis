//
//  UIGestureRecognizer+Analysis.m
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import "UIGestureRecognizer+Analysis.h"
#import "SwizzManager.h"

static id<AnalysisDelegate> __analysisDelegateUIGesture = nil;
@implementation UIGestureRecognizer (Analysis)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSel = @selector(initWithTarget:action:);
        SEL newSel = @selector(hxw_initWithTarget:action:);
        [SwizzManager swizzMethodForClass:[self class] originSel:originSel newSel:newSel];
        
        SEL originSel1 = @selector(addTarget:action:);
        SEL newSel1 = @selector(hxw_addTarget:action:);
        [SwizzManager swizzMethodForClass:[self class] originSel:originSel1 newSel:newSel1];
    });
   
}
-(instancetype)hxw_initWithTarget:(id)target action:(SEL)action{
    UIGestureRecognizer* gestureRecognize = [self hxw_initWithTarget:target action:action];
    if (!target && !action) {
        return gestureRecognize;
    }
    if ([target isKindOfClass:[UIScrollView class]]) {
        return gestureRecognize;
    }
    [self handleTarget:target action:action];
    
    return gestureRecognize;
}
-(void)hxw_addTarget:(id)target action:(SEL)action{
    [self hxw_addTarget:target action:action];
    [self handleTarget:target action:action];
}
- (void)handleTarget:(id)target action:(SEL)action{
    
    Class clazz = [target class];
    NSString* newMethodName = [NSString stringWithFormat:@"hxw_%@_%@",NSStringFromClass(clazz),NSStringFromSelector(action)];
    SEL newSel = NSSelectorFromString(newMethodName);
    SEL impSel = @selector(respondActionForGestureRecognize:);
    // 向类身上添加方法并交换
    [SwizzManager swizzMethodForClass:clazz newSelImpClass:[self class] impSel:impSel originSel:action newSel:newSel];
    
    self.name = newMethodName;
}
- (void)respondActionForGestureRecognize:(UIGestureRecognizer*)gestureRecognize{
    ///调用原始action，self为target
    NSString * identifier = gestureRecognize.name;
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self,sel,gestureRecognize);
    }
    
    [__analysisDelegateUIGesture hxw_UIGestureCognizedRespondAction:gestureRecognize];
}

+(void)hxw_setActionTargetDelegate:(id<AnalysisDelegate>)analysisDelegate{
    __analysisDelegateUIGesture = analysisDelegate;
}
@end

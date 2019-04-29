//
//  UITableView+Analysis.m
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import "UITableView+Analysis.h"
#import "SwizzManager.h"

static id<AnalysisDelegate> __analysisDelegateUITableView = nil;
@implementation UITableView (Analysis)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSel = @selector(setDelegate:);
        SEL newSel = @selector(hxw_setDelegate:);
        [SwizzManager swizzMethodForClass:[self class] originSel:originSel newSel:newSel];
    });
}

- (void)hxw_setDelegate:(id<UITableViewDelegate>)delegate{
    [self hxw_setDelegate:delegate];
    Class delegateClass = [delegate class];
    SEL originSel = @selector(tableView:didSelectRowAtIndexPath:);
    NSString* newSelName = [NSString stringWithFormat:@"hxw_%ld_%@",self.tag,NSStringFromSelector(originSel)];
    SEL newSel = NSSelectorFromString(newSelName);
    SEL impSel = @selector(hxw_tableView:didSelectRowAtIndexPath:);
    ///动态添加方法并交换
    [SwizzManager swizzMethodForClass:delegateClass newSelImpClass:[self class] impSel:impSel originSel:originSel newSel:newSel];
}
- (void)hxw_tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    ///执行原始方法，交换后为hxw_tag_tableView:didSelectRowAtIndexPath:,指向原始方法- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath这个的IMP
    ///这里的self实际上为delegate
    NSString* selName = [NSString stringWithFormat:@"hxw_%ld_%@",tableView.tag,NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:))];
    SEL swizzSel = NSSelectorFromString(selName);
    if ([self respondsToSelector:swizzSel]) {
        IMP imp = [self methodForSelector:swizzSel];
        void(*func)(id,SEL,id,id) = (void*)imp;
        func(self, swizzSel, tableView, indexPath);
    }
    [__analysisDelegateUITableView hxw_tableView:tableView didSelectRowAtIndexPath:indexPath delagete:(id<UITableViewDelegate>)self];
    
}

+(void)hxw_setActionTargetDelegate:(id<AnalysisDelegate>)analysisDelegate{
    __analysisDelegateUITableView = analysisDelegate;
}
@end

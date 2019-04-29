//
//  AnalysisManager.m
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/26.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import "AnalysisManager.h"
#import "UIControl+Analysis.h"
#import "UIGestureRecognizer+Analysis.h"
#import "UIViewController+Analysis.h"
#import "UITableView+Analysis.h"

@interface AnalysisManager()<AnalysisDelegate>
/**
 数据埋点处理接口
 */
@property (nonatomic, weak) id<AnalysisDelegate> delegate;
@end
static AnalysisManager* instance = nil;
static dispatch_once_t onceToken;
@implementation AnalysisManager
+(AnalysisManager*)shareInstance{
    dispatch_once(&onceToken, ^{
        instance = [[AnalysisManager alloc]init];
        [UIControl hxw_setActionTargetDelegate:instance];
        [UIGestureRecognizer hxw_setActionTargetDelegate:instance];
        [UIViewController hxw_setActionTargetDelegate:instance];
        [UITableView hxw_setActionTargetDelegate:instance];
    });
    return instance;
}
+ (instancetype)alloc
{
    if(instance)
    {
        return  instance;
    }
    return [super alloc];
}
-(void)hxw_UIControlSendAction:(SEL)action target:(id)target forEvent:(UIEvent *)event{
    NSLog(@"___action:%@ ___target:%@ ___evnent:%@",NSStringFromSelector(action),NSStringFromClass([target class]),event);
    if([self.delegate respondsToSelector:@selector(hxw_UIControlSendAction:target:forEvent:)]){
        [self.delegate hxw_UIControlSendAction:action target:target forEvent:event];
    }
}
-(void)hxw_UIGestureCognizedRespondAction:(UIGestureRecognizer *)gestureCognized{
    NSLog(@"___action___target:%@ " ,gestureCognized.name);
    if([self.delegate respondsToSelector:@selector(hxw_UIGestureCognizedRespondAction:)]){
        [self.delegate hxw_UIGestureCognizedRespondAction:gestureCognized];
    }
}

-(void)hxw_viewWillDisappear:(BOOL)animated viewController:(UIViewController *)viewController{
    NSLog(@"hxw_viewWillDisappear:%@",[viewController class]);
    if([self.delegate respondsToSelector:@selector(hxw_viewWillDisappear:viewController:)]){
        [self.delegate hxw_viewWillDisappear:animated viewController:viewController];
    }
}
-(void)hxw_viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController{
    NSLog(@"hxw_viewWillAppear:%@",[viewController class]);
    if([self.delegate respondsToSelector:@selector(hxw_viewWillAppear:viewController:)]){
        [self.delegate hxw_viewWillAppear:animated viewController:viewController];
    }
}

-(void)hxw_viewDidLoad:(UIViewController *)viewController{
    NSLog(@"hxw_viewDidLoad:%@",[viewController class]);
    if([self.delegate respondsToSelector:@selector(hxw_viewDidLoad:)]){
        [self.delegate hxw_viewDidLoad:viewController];
    }
}

-(void)hxw_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath delagete:(id<UITableViewDelegate>)delegate{
    NSLog(@"hxw_tableView:%ld,indexPath:%@ delegate:%@",[tableView tag],indexPath,delegate.class);
    if ([self.delegate respondsToSelector:@selector(hxw_tableView:didSelectRowAtIndexPath:delagete:)]) {
        [self.delegate hxw_tableView:tableView didSelectRowAtIndexPath:indexPath delagete:delegate];
    }
}
///释放
+ (void)releasferAnalysisManager{
    onceToken = 0;
    instance.delegate = nil;
    instance = nil;
}
@end

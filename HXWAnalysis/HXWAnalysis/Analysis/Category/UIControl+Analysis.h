//
//  UIControl+Analysis.h
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/26.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalysisDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Analysis)
+ (void)hxw_setActionTargetDelegate:(id<AnalysisDelegate>)analysisDelegate;
@end

NS_ASSUME_NONNULL_END

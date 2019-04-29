//
//  SwizzManager.h
//  HXWAnalysis
//
//  Created by BTI-HXW on 2019/4/28.
//  Copyright © 2019 BTI-HXW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwizzManager : NSObject
/**
 *方法交换
 *@param clazz 交换的类
 *@param originSel 需要交换的原始方法sel
 *@param newSel 动态方法sel
 */
+ (void)swizzMethodForClass:(Class)clazz originSel:(SEL)originSel newSel:(SEL)newSel;
/**
 *动态添加方法并交换
 *@param clazz 交换的类
 *@param impClass 动态方法的imp所在类
 *@param impSel 动态方法的imp对应的sel
 *@param originSel 需要交换的原始方法sel
 *@param newSel 动态方法sel
 */
+ (void)swizzMethodForClass:(Class)clazz newSelImpClass:(Class)impClass impSel:(SEL)impSel originSel:(SEL)originSel newSel:(SEL)newSel;
@end

NS_ASSUME_NONNULL_END

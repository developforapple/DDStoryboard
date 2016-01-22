//
//  UIViewController+Storyboard.h
//  
//
//  Created by Normal on 15/11/17.
//  Copyright © 2015年 Bo Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Storyboard)

+ (nullable instancetype)dd_instanceFromStoryboardWithIdentifier:(nonnull NSString *)identifier;

/**
 *  @brief UIViewController instance create from storyboard. UIViewController'identifier must be the same as it's class name
 *  
 *  or simple [[UIViewController alloc] init]
 *
 *  @return instance
 */
+ (instancetype)dd_instanceFromStoryboard;

@end

NS_ASSUME_NONNULL_END
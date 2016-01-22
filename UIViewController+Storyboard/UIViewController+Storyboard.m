//
//  UIViewController+Storyboard.m
//
//
//  Created by Normal on 15/11/17.
//  Copyright © 2015年 Bo Wang. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

+ (nonnull NSArray<NSString *> *)storyboardList
{
    static NSArray *kBundleStoryboardNameList;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *tmp = [NSMutableArray array];
        
        /**
         *  list all storyboard files
         *  @warning ignore ~iphone ~ipad
         */
        NSArray *list = [NSBundle pathsForResourcesOfType:@"storyboardc" inDirectory:[NSBundle mainBundle].resourcePath];
        
        for (NSString *path in list) {
            NSString *ext = [path lastPathComponent];
            NSString *name = [ext stringByDeletingPathExtension];
            if ([name rangeOfString:@"~"].location == NSNotFound) {
                [tmp addObject:name];
            }
        }
        kBundleStoryboardNameList = [NSArray arrayWithArray:tmp];
    });
    return kBundleStoryboardNameList;
}

+ (NSCache *)cache
{
    static NSCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}

+ (nullable instancetype)tryTakeOutInstanceFromStoryboardNamed:(nonnull NSString *)storyboardName identifier:(nonnull NSString *)identifier
{
    if (!storyboardName || !identifier) {
        return nil;
    }
    
    @try {
        
#if DEBUG
        UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
        
        NSString *selStr = @"identifierToNibNameMap";
        SEL sel = NSSelectorFromString(selStr);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        if ([sb respondsToSelector:sel]) {
            id obj = [sb performSelector:sel];
            if (obj && [obj isKindOfClass:[NSDictionary class]] && [[(NSDictionary *)obj allValues] containsObject:identifier]) {
                UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
                return vc;
            }else{
                return nil;
            }
        }else{
            NSAssert(NO, @"unsupport Selector: identifierToNibNameMap");
        }
#pragma clang diagnostic pop

#else
        UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
        return vc;
#endif
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        
    }
}

+ (nullable instancetype)dd_instanceFromStoryboardWithIdentifier:(nonnull NSString  *)identifier
{
    NSAssert(identifier, @"identifier is nil!!!!");
    if (!identifier) return nil;
    
    NSCache *cache = [self cache];
    NSString *cacheStoryboardName = [cache objectForKey:identifier];
    if (cacheStoryboardName) {
        return [self tryTakeOutInstanceFromStoryboardNamed:cacheStoryboardName identifier:identifier];
    }
    
    for (NSString *name in [self storyboardList]) {
        UIViewController *instance = [self tryTakeOutInstanceFromStoryboardNamed:name identifier:identifier];
        if (instance) {
            [cache setObject:name forKey:identifier];
            return instance;
        }
    }
    return nil;
}

+ (instancetype)dd_instanceFromStoryboard
{
    NSString *identifier = NSStringFromClass([self class]);
    UIViewController *vc = [self dd_instanceFromStoryboardWithIdentifier:identifier];
    if (!vc) {
        vc = [[[self class] alloc] init];
    }
    return vc;
}

@end

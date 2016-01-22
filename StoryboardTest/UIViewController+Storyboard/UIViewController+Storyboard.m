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
         *  找到所有storyboard文件。
         *  @warning 会忽略带有 ~iphone(iPhone应用)或 ~ipad(iPad应用)标志的 storyboard文件名
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

/**
 *  尝试从以storyboardName为名的storyboard中取
 *
 *  @param storyboardName storyboard文件名
 *  @param identifier     查找的对象id
 *
 *  @return 查找到的UIViewController实例。如果没有找到，返回nil
 */
+ (nullable instancetype)tryTakeOutInstanceFromStoryboardNamed:(nonnull NSString *)storyboardName identifier:(nonnull NSString *)identifier
{
    if (!storyboardName || !identifier) {
        return nil;
    }
    
    /**
     *  这里需要捕获异常，否则程序会crash
     
     */
    
    @try {
#ifdef DD_STORYDEBUG
        UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
        NSString *selStr = [NSString stringWithFormat:@"%@%@%@%@%@",@"identifier",@"To",@"Nib",@"Name",@"Map"];
        SEL sel = NSSelectorFromString(selStr);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id obj = [sb performSelector:sel];
#pragma clang diagnostic pop
        if (obj && [obj isKindOfClass:[NSDictionary class]] && [[(NSDictionary *)obj allValues] containsObject:identifier]) {
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
            return vc;
        }else{
            return nil;
        }
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

+ (nullable instancetype)instanceFromStoryboardWithIdentifier:(nonnull NSString  *)identifier
{
    NSAssert(identifier, @"identifier不能为空！");
    if (!identifier) return nil;
    
    // 取缓存的storyboard名
    NSCache *cache = [self cache];
    NSString *cacheStoryboardName = [cache objectForKey:identifier];
    if (cacheStoryboardName) {
        return [self tryTakeOutInstanceFromStoryboardNamed:cacheStoryboardName identifier:identifier];
    }
    
    // 未缓存，遍历storyboard文件名列表，开始尝试取出实例。
    for (NSString *name in [self storyboardList]) {
        UIViewController *instance = [self tryTakeOutInstanceFromStoryboardNamed:name identifier:identifier];
        if (instance) {
            // 成功获取实例后，对storyboard名进行缓存
            [cache setObject:name forKey:identifier];
            return instance;
        }
    }
    return nil;
}

+ (nullable instancetype)instanceFromStoryboard
{
    NSString *identifier = NSStringFromClass([self class]);
    return [self instanceFromStoryboardWithIdentifier:identifier];
}

@end

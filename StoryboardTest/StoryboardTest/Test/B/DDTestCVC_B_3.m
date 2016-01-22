//
//  DDTestCVC_B_3.m
//  StoryboardTest
//
//  Created by Normal on 16/1/22.
//  Copyright © 2016年 wwwbbat. All rights reserved.
//

#import "DDTestCVC_B_3.h"

@interface DDTestCVC_B_3 ()

@end

@implementation DDTestCVC_B_3

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

@end

//
//  ViewController.m
//  StoryboardTest
//
//  Created by Normal on 16/1/22.
//  Copyright © 2016年 wwwbbat. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Storyboard.h"

#import "DDTestVC_A_1.h"
#import "DDTestVC_A_2.h"
#import "DDTestVC_B_1.h"
#import "DDTestTVC_B_2.h"
#import "DDTestCVC_B_3.h"
#import "DDTestNC_C_1.h"
#import "DDTestVC_C_2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnAction:(id)sender
{
    //UIViewController in storyboardA
    DDTestVC_A_1 *a1 = [DDTestVC_A_1 dd_instanceFromStoryboard];
    [self.navigationController pushViewController:a1 animated:YES];
    
//    //UIViewController in storyboardA
//    DDTestVC_A_2 *a2 = [DDTestVC_A_2 dd_instanceFromStoryboard];
//    [self.navigationController pushViewController:a2 animated:YES];
//
//    //UIViewController in storyboardB
//    DDTestVC_B_1 *b1 = [DDTestVC_B_1 dd_instanceFromStoryboard];
//    [self.navigationController pushViewController:b1 animated:YES];
//
//    //UITableViewController in storyboardB
//    DDTestTVC_B_2 *b2 = [DDTestTVC_B_2 dd_instanceFromStoryboard];
//    [self.navigationController pushViewController:b2 animated:YES];
//
//    //UICollectionViewController in storyboardB
//    DDTestCVC_B_3 *b3 = [DDTestCVC_B_3 dd_instanceFromStoryboard];
//    [self.navigationController pushViewController:b3 animated:YES];
//
//    //UINavigationController in storyboardC
//    DDTestNC_C_1 *c1 = [DDTestNC_C_1 dd_instanceFromStoryboard];
//    [self.navigationController presentViewController:c1 animated:YES completion:nil];
//
//    //UIViewController in storyboardC
//    DDTestVC_C_2 *c2 = [DDTestVC_C_2 dd_instanceFromStoryboard];
//    [self.navigationController pushViewController:c2 animated:YES];

}

@end

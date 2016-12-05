//
//  ViewController.m
//  coding协议
//
//  Created by 周旭斌 on 2016/12/5.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import "ViewController.h"
#import "XBPerson.h"
#import "XBCat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < 3; ++i) {
        XBPerson *person1 = [[XBPerson alloc] init];
        person1.name = @"123";
        person1.age = @"aaaa";
        
        XBDog *dog = [[XBDog alloc] init];
        dog.dogName = @"哈哈哈";
        dog.dogAge = @"111";
        person1.dog = dog;
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:3];
        for (int i = 0; i < 3; ++i) {
            XBCat *cat = [[XBCat alloc] init];
            cat.catName = @"444";
            cat.catAge = @"555";
            [tempArray addObject:cat];
        }
        person1.cats = tempArray;
        
        [array addObject:person1];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@", arr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

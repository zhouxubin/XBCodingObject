//
//  XBPerson.h
//  coding协议
//
//  Created by 周旭斌 on 2016/12/5.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import "XBCodingObject.h"
#import "XBDog.h"

@interface XBPerson : XBCodingObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

/**
 狗类
 */
@property (nonatomic, strong) XBDog *dog;

/**
 数组里面装的是猫类
 */
@property (nonatomic, strong) NSArray *cats;

@end

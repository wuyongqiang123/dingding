//
//  dingdingHelper.m
//  dingding
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 wyq. All rights reserved.
//

#import "dingdingHelper.h"

@implementation dingdingHelper

+(dingdingHelper *)shareHelper
{
    static dingdingHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [dingdingHelper new];
        helper.titleList = @[].mutableCopy;
    });
    return helper;
}

@end

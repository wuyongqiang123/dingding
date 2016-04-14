//
//  dataModel.h
//  dingding
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModel : NSObject

@property(copy,nonatomic) NSString *EasemoName;
@property(copy,nonatomic) NSString *EasemobPwd;
@property(copy,nonatomic) NSString *bm_mc;
@property(copy,nonatomic) NSString *ssoid;
@property(copy,nonatomic) NSString *ui_desc;
@property(copy,nonatomic) NSString *ui_id;
@property(copy,nonatomic) NSString *ui_yddh;
@property(copy,nonatomic) NSString *zpurl;
@property(copy,nonatomic) NSString *zwmc;

@end

@interface dataModelID : NSObject

@property(copy,nonatomic) NSString *BM_ID;
@property(copy,nonatomic) NSString *BM_MC;

@end

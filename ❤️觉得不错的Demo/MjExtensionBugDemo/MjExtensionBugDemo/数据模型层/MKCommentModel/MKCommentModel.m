//
//  MKCommentModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKCommentModel.h"

@implementation MKChildCommentModel

#pragma mark —— YYModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
        @"ID" : @"id"
    };
}
#pragma mark —— MJExtention
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

//@property(nonatomic,strong)NSString *headImage;
//@property(nonatomic,strong)NSURL *headImage;
- (id)mj_newValueFromOldValue:(id)oldValue
                     property:(MJProperty *)property{
    if ([property.name isEqualToString:@"headImg"]) {
        return [NSURL URLWithString:oldValue];
    }return oldValue;
}

@end

@implementation MKFirstCommentModel

#pragma mark —— YYModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
        @"ID" : @"id",
        @"childMutArr":@"child"
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"childMutArr" : MKChildCommentModel.class
    };
}
#pragma mark —— MJExtention
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id",
        @"childMutArr":@"child"
    };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"childMutArr" : MKChildCommentModel.class
    };
}

//@property(nonatomic,strong)NSString *headImage;
//@property(nonatomic,strong)NSURL *headImage;
- (id)mj_newValueFromOldValue:(id)oldValue
                     property:(MJProperty *)property{
    if ([property.name isEqualToString:@"headImage"]) {
        return [NSURL URLWithString:oldValue];
    }return oldValue;
}

@end

@implementation MKCommentModel

#pragma mark —— YYModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
        @"listMutArr": @"list"
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"list" : MKFirstCommentModel.class
    };
}
#pragma mark —— MJExtention
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"listMutArr" : @"list",
    };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"listMutArr" : MKFirstCommentModel.class,
    };
}

@end

@implementation MKFirstCommentCustomCofigModel
#pragma mark —— 自定义属性
-(NSInteger)preMax{
    if (_preMax == 0) {
        _preMax = 3;
    }return _preMax;
}

-(NSInteger)loadMoreDataNum{
    if (_loadMoreDataNum == 0) {
        if (self.childMutArr) {
            return self.childMutArr.count - self.firstShonNum;//全加载 = 数据库有的 - 默认已经显示的
        }
    }return _loadMoreDataNum;
}

-(NSInteger)firstShonNum{
    return self.childMutArr.count > self.preMax ? self.preMax : self.childMutArr.count;
}

@end

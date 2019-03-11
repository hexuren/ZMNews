//
//  SweepUserModel.m
//  CoolNews
//
//  Created by Zhimi on 2018/3/13.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import "SweepUserModel.h"

@implementation SweepUserModel

- (instancetype)initWithName:(NSString *)name Time:(NSInteger)time ID:(NSInteger)ID Difficulty:(KindOfUserDifficulty)difficulty RandomNum:(NSInteger)randomNum{
    self = [super init];
    if (self) {
        _name = name;
        
        _time = time;
        
        _id_vierfy = ID;
        
        _difficulty = difficulty;
        
        _randomNum = randomNum;
    }
    return self;
}

+ (UserModel *)modelWithName:(NSString *)name Time:(NSInteger)time ID:(NSInteger)ID Difficulty:(KindOfUserDifficulty)difficulty RandomNum:(NSInteger)randomNum{
    return [[super alloc] initWithName:name Time:time ID:ID Difficulty:difficulty RandomNum:randomNum];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@,time:%ld,difficulty:%ld",self.name,self.time,self.difficulty];
}


@end

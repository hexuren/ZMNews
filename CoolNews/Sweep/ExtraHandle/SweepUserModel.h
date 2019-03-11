//
//  SweepUserModel.h
//  CoolNews
//
//  Created by Zhimi on 2018/3/13.
//  Copyright © 2018年 com.coolnews.zm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KindOfUserDifficulty) {
    KindOfUserDifficultyEasy,
    KindOfUserDifficultyNormal
};

@interface SweepUserModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) NSInteger time;

@property (nonatomic,assign) NSInteger id_vierfy;

@property (nonatomic,assign) NSInteger randomNum;

@property (nonatomic,assign) KindOfUserDifficulty difficulty;

+ (UserModel *)modelWithName:(NSString *)name Time:(NSInteger)time ID:(NSInteger)ID Difficulty:(KindOfUserDifficulty)difficulty RandomNum:(NSInteger)randomNum;

@end

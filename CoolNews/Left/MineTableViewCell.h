//
//  MineTableViewCell.h
//  ElectricityPatrolSystem
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 KevinWu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MineTableViewCell : UITableViewCell

- (void)setvalueForcellWithDictionary:(NSDictionary *)dict;

- (void)setSelectedValueForcellWithDictionary:(NSDictionary *)dict;

- (void)setUnreadMessageCountValue:(NSInteger)count;

- (void)setNoUnreadMessageCount;

- (void)setsyncDataCountValue:(NSInteger)count;

- (void)setNosyncData;

@end

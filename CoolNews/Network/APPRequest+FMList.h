//
//  APPRequest+FMList.h
//  KdFM
//
//  Created by Zhimi on 17/6/20.
//  Copyright © 2017年 Zhimi. All rights reserved.
//

#import "APPRequest.h"

@interface APPRequest (FMList)


/**
 *  获取电台列表
 *
 *  @param tagName //综合台、文艺台、音乐台、新闻台、故事台
 *  @param success 成功信息
 *  @param error   错误信息
 *
 *  @return
 */

+ (id)getCategoryListWithtagName:(NSString *)tagName
                    successBlock:(CommonSuccessResponse)success
                      errorBlock:(CommonErrorResponse)error;

/**
 *  
 *
 *  @param albumId
 *  @param title
 *  @param success     成功
 *  @param error       错误信息
 *
 *  @return
 */
+ (NSURLSessionDataTask *)getTracksForAlbumId:(NSInteger )albumId
                                    mainTitle:(NSString *)title
                                        idAsc:(BOOL )asc
                                 successBlock:(CommonSuccessResponse)success
                                   errorBlock:(CommonErrorResponse)error;

/**
 *  获得该日期的万年历
 *
 *  @param day     指定日期,格式为YYYY-MM-DD,如月份和日期小于10,则取个位,如:2012-1-1
 *  @param success success description
 *  @param error   error description
 *
 *  @return 
 */
+ (NSURLSessionDataTask *)getCalendarday:(NSString *)day
                            successBlock:(CommonSuccessResponse)success
                              errorBlock:(CommonErrorResponse)error;

/**
 *  查询城市天气
 *
 *  @param cityName 城市名
 *  @param success  success description
 *  @param error    error description
 *
 *  @return
 */
+ (NSURLSessionDataTask *)getWeathercityName:(NSString *)cityName
                            successBlock:(CommonSuccessResponse)success
                              errorBlock:(CommonErrorResponse)error;

/**
 *  查询城市天气
 *
 *  @param cityName 城市名
 *  @param success  success description
 *  @param error    error description
 *
 *  @return
 */
+ (NSURLSessionDataTask *)getPayWeathercityName:(NSString *)cityName
                                   successBlock:(CommonSuccessResponse)success
                                     errorBlock:(CommonErrorResponse)error;

@end

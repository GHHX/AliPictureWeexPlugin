//
//  JarvisViewDelegate.h
//  MoviePro
//
//  Created by Erik on 17/4/10.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JarvisViewDelegate <NSObject>
@optional
- (void)renderView:(id)model;//TODO：多个主体的标识
- (void)renderView:(id)model extraData:(id)data;

//UI
- (void)loading;
- (void)finishLoading;
- (void)endLoading:(id)error;
@end

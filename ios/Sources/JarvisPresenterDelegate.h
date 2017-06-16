//
//  JarvisPresenterDelegate.h
//  MoviePro
//
//  Created by Erik on 17/4/10.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JarvisViewDelegate.h"

@protocol JarvisPresenterDelegate <NSObject>
@optional
- (void)attachViewDelegate:(id<JarvisViewDelegate>)delegate;
- (void)detachViewDelete;
@end

//
//  JarvisBasePresenter.h
//  MoviePro
//
//  Created by Erik on 17/4/10.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JarvisPresenterDelegate.h"

@interface JarvisBasePresenter : NSObject<JarvisPresenterDelegate>

@property (nonatomic,weak)id<JarvisViewDelegate>viewDelegate;
@end

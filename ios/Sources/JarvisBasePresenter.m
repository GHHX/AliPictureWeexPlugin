//
//  JarvisBasePresenter.m
//  MoviePro
//
//  Created by Erik on 17/4/10.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "JarvisBasePresenter.h"

@implementation JarvisBasePresenter

- (void)attachViewDelegate:(id<JarvisViewDelegate>)delegate{
    self.viewDelegate = delegate;
}
- (void)detachViewDelete{
    self.viewDelegate = nil;
}
@end

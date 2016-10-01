//
//  BlockBackground.h
//
//  Created by Zhao Fei on 16/9/28.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockBackground : UIWindow {
@private
    UIWindow *_previousKeyWindow;
}

+ (BlockBackground *) sharedInstance;

- (void)addToMainWindow:(UIView *)view;
- (void)reduceAlphaIfEmpty;
- (void)removeView:(UIView *)view;

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, readwrite) BOOL vignetteBackground;

@end

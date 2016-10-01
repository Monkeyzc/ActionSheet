//
//  ZFActionSheet.h
//  ActionSheet
//
//  Created by Zhao Fei on 16/9/28.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlockBackground.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define padding 16.0
#define avatarSize 58.0

// Action Sheet constants
#define kActionSheetBounce         10
#define kActionSheetBorder         10
#define kActionSheetButtonHeight   55
#define kActionSheetTopMargin      15

#define kActionSheetTitleFont           [UIFont systemFontOfSize:25]
#define kActionSheetTitleTextColor      [UIColor blackColor]
#define kActionSheetDescriptionFont     [UIFont systemFontOfSize:18]
#define kActionSheetDescriptionColor    [UIColor KLRBlackColor]

#define kActionSheetTitleShadowColor    [UIColor blackColor]
#define kActionSheetTitleShadowOffset   CGSizeMake(0, -1)

#define kActionSheetButtonFont          [UIFont systemFontOfSize:20]
#define kActionSheetButtonTextColor     [UIColor colorWithRed:80 / 256.0 green:155 / 256.0 blue:245 / 256.0 alpha:1]
#define kActionSheetButtonShadowColor   [UIColor blackColor]
#define kActionSheetButtonShadowOffset  CGSizeMake(0, -1)

#define kActionSheetLineColor           [UIColor grayColor]

#define kActionSheetBackground              @"action-sheet-panel.png"
#define kActionSheetBackgroundCapHeight     30

@interface ZFActionSheet : UIView

@property (nonatomic, readwrite) BOOL vignetteBackground;

+ (instancetype)actionSheetWithTitle: (NSString *)title description: (NSString *)description;

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addButtonWithTitle:(NSString *)title atIndex:(NSInteger)index block:(void (^)())block;

- (void)showInView:(UIView *)view;
@end

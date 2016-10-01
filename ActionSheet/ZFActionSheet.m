//
//  ZFActionSheet.m
//  ActionSheet
//
//  Created by Zhao Fei on 16/9/28.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "ZFActionSheet.h"


static UIImage *background = nil;

@interface ZFActionSheet() {
@private
    CGFloat _height;
}


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *contactFullnameLabel;
@property (nonatomic, strong) UIImageView *phoneCountryFlag;
@property (nonatomic, strong) UILabel *phoneNumberLabel;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *blocks;

@end

@implementation ZFActionSheet

+ (instancetype)actionSheetWithTitle: (NSString *)title description: (NSString *)description {
    
    background = [UIImage imageNamed:kActionSheetBackground];
    background = [background stretchableImageWithLeftCapWidth:0 topCapHeight:kActionSheetBackgroundCapHeight];
    
    ZFActionSheet *actionSheet = [[ZFActionSheet alloc] init];
    actionSheet.titleLabel.text = title;
    actionSheet.descriptionLabel.text = description;
    
    return actionSheet;
}

- (instancetype)init{
    if (self = [super init]) {
        
        UIWindow *parentView = [BlockBackground sharedInstance];
        CGRect frame = parentView.bounds;
        
        self.frame = frame;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _height = kActionSheetTopMargin;
        
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.descriptionLabel];
        [self addSubview:self.avatarView];
        [self addSubview:self.contactFullnameLabel];
        [self addSubview:self.phoneNumberLabel];
        [self addSubview:self.phoneCountryFlag];
        
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kActionSheetTitleTextColor;
        label.font = kActionSheetTitleFont;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = kActionSheetDescriptionFont;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel = label;
    }
    return _descriptionLabel;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = avatarSize * 0.5;
        _avatarView.image = [UIImage imageNamed:@"img_default_avatar"];
    }
    return _avatarView;
}

- (UILabel *)contactFullnameLabel {
    if (!_contactFullnameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = kActionSheetDescriptionFont;
        label.textAlignment = NSTextAlignmentCenter;
        _contactFullnameLabel = label;
        _contactFullnameLabel.text = @"Zhao Fei";
    }
    return _contactFullnameLabel;
}

- (UIImageView *)phoneCountryFlag {
    if (!_phoneCountryFlag) {
        _phoneCountryFlag = [[UIImageView alloc] init];
        _phoneCountryFlag.image = [UIImage imageNamed:@"AD"];
    }
    return _phoneCountryFlag;
}

- (UILabel *)phoneNumberLabel {
    if (!_phoneNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = kActionSheetDescriptionFont;
        label.textAlignment = NSTextAlignmentCenter;
        _phoneNumberLabel = label;
        _phoneNumberLabel.text = @"86 130 5114 9394";
    }
    return _phoneNumberLabel;
}

- (NSMutableArray *)blocks {
    if (!_blocks) {
        _blocks = [[NSMutableArray alloc] init];
    }
    return _blocks;
}

#pragma mark - cancel button
- (void)addButtonWithTitle:(NSString *)title color:(NSString*)color block:(void (^)())block
{
    [self.blocks addObject:[NSArray arrayWithObjects:
                        block ? [block copy] : [NSNull null],
                        title,
                        color,
                        nil]];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block
{
    [self addButtonWithTitle:title color:@"red" block:block];
}


#pragma mark - add action button
- (void)addButtonWithTitle:(NSString *)title atIndex:(NSInteger)index block:(void (^)())block
{
    [self addButtonWithTitle:title color:@"gray" block:block atIndex:index];
}


- (void)addButtonWithTitle:(NSString *)title color:(NSString*)color block:(void (^)())block atIndex:(NSInteger)index
{
    if (index >= 0)
    {
        [self.blocks insertObject:[NSArray arrayWithObjects:
                               block ? [block copy] : [NSNull null],
                               title,
                               color,
                               nil]
                      atIndex:index];
    }
    else
    {
        [self.blocks addObject:[NSArray arrayWithObjects:
                            block ? [block copy] : [NSNull null],
                            title,
                            color,
                            nil]];
    }
}




- (void)showInView:(UIView *)view
{
    //白色背景
    CGFloat headBgViewHeight = 0;
    CGFloat headBgViewWidth = self.frame.size.width - 2 * 8;
    
    UIView *headBgView = [[UIView alloc] init];
    headBgView.layer.cornerRadius = 16;
    headBgView.backgroundColor = [UIColor whiteColor];
    [self insertSubview:headBgView atIndex:0];
    
    // set Title and description
    CGFloat width = ScreenWidth - 2 * padding;
    
    CGFloat titleLableHeight = ceil([self calculateLabelSizeBaseText:self.titleLabel.text Size:CGSizeMake(width, MAXFLOAT) font:self.titleLabel.font].height);
    CGRect titleLableFrame = CGRectMake(padding, padding, width, titleLableHeight);
    self.titleLabel.frame = titleLableFrame;
    
    CGFloat decriptionLabelheight = ceil([self calculateLabelSizeBaseText:self.descriptionLabel.text Size:CGSizeMake(width, MAXFLOAT) font:self.descriptionLabel.font].height);
    CGRect decriptionLabelFrame = CGRectMake(padding, CGRectGetMaxY(self.titleLabel.frame) + padding, width, decriptionLabelheight);
    self.descriptionLabel.frame = decriptionLabelFrame;
    
    
    _height = CGRectGetMaxY(self.descriptionLabel.frame);
    
    
    // set contact information
    
    self.avatarView.frame = CGRectMake((ScreenWidth - avatarSize) * 0.5 , _height + padding, avatarSize, avatarSize);
    _height = CGRectGetMaxY(self.avatarView.frame);
    
    CGFloat contactFullnameLabelHeight = 30;
    CGFloat contactFullnameLabelWidth = ceil([self calculateLabelSizeBaseText:self.contactFullnameLabel.text Size:CGSizeMake(MAXFLOAT, contactFullnameLabelHeight) font:self.contactFullnameLabel.font].width);
    self.contactFullnameLabel.frame = CGRectMake((ScreenWidth - contactFullnameLabelWidth) * 0.5, _height, contactFullnameLabelWidth, contactFullnameLabelHeight);
    _height = CGRectGetMaxY(self.contactFullnameLabel.frame);
    
    CGFloat phoneNumberLabelHeight = 30;
    CGFloat phoneNumberLabelWidth = ceil([self calculateLabelSizeBaseText:self.phoneNumberLabel.text Size:CGSizeMake(MAXFLOAT, phoneNumberLabelHeight) font:self.phoneNumberLabel.font].width);
    self.phoneNumberLabel.frame = CGRectMake((ScreenWidth - phoneNumberLabelWidth) * 0.5, _height, phoneNumberLabelWidth, phoneNumberLabelHeight);
    
    CGFloat flagWidth = 20;
    CGFloat flagHeight = 15;
    self.phoneCountryFlag.frame = CGRectMake(CGRectGetMinX(self.phoneNumberLabel.frame) - flagWidth - 8, _height, flagWidth, flagHeight);
    CGPoint tempFlagCenter = self.phoneCountryFlag.center;
    tempFlagCenter.y = _phoneNumberLabel.center.y;
    self.phoneCountryFlag.center = tempFlagCenter;
    
    

    _height = CGRectGetMaxY(self.phoneNumberLabel.frame) + padding;

    
    // 按钮
    NSUInteger i = 1;
    for (int index = 0; index < _blocks.count; index ++) {
        
        NSArray *block = _blocks[index];
        
        NSString *title = [block objectAtIndex:1];
        NSString *color = [block objectAtIndex:2];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"action-%@-button.png", color]];
        image = [image stretchableImageWithLeftCapWidth:(int)(image.size.width)>>1 topCapHeight:0];
        
        UIImage *highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"action-%@-button-highlighted.png", color]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.bounds.size.width - kActionSheetBorder*2, kActionSheetButtonHeight);
        
        button.titleLabel.font = kActionSheetButtonFont;
        button.titleLabel.minimumScaleFactor = 0.1;
        
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        button.tag = i++;
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        if (highlightedImage)
        {
            [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        }
        
        [button setTitle:title forState:UIControlStateNormal];
        button.accessibilityLabel = title;
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        // 获取到最后一个 buttons
        if (index == _blocks.count - 1) {
            
            UIView *bgView = [[UIView alloc] init];
            bgView.layer.cornerRadius = padding;
            bgView.backgroundColor = [UIColor whiteColor];
            
            bgView.frame = CGRectMake(kActionSheetBorder, _height + 8, self.bounds.size.width - kActionSheetBorder*2, kActionSheetButtonHeight);
            
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            [bgView addSubview:button];
            [self addSubview:bgView];
            
            _height = CGRectGetMaxY(bgView.frame) + kActionSheetBorder;
        } else {
            
            button.frame = CGRectMake(kActionSheetBorder, _height, self.bounds.size.width - kActionSheetBorder*2, kActionSheetButtonHeight);
            
            [button setBackgroundImage:image forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            
            //添加上下分割线
            if (index != _blocks.count - 2) {
                
                CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
                
                UIView *topLine = [[UIView alloc] init];
                topLine.backgroundColor = kActionSheetLineColor;
                topLine.frame = CGRectMake(8, CGRectGetMinY(button.frame), headBgViewWidth, lineHeight);
                [self addSubview:topLine];
                
                UIView *bottomLine = [[UIView alloc] init];
                bottomLine.backgroundColor = kActionSheetLineColor;
                bottomLine.frame = CGRectMake(8, CGRectGetMaxY(button.frame), headBgViewWidth, lineHeight);
                [self addSubview:bottomLine];
            }
            
            [self addSubview:button];
            _height = CGRectGetMaxY(button.frame);
            
            headBgViewHeight = _height;
        }
        
    }
    

    headBgView.frame = CGRectMake(8, 0, headBgViewWidth, headBgViewHeight);
    
    [view addSubview:self];
    
    UIImageView *modalBackground = [[UIImageView alloc] initWithFrame:self.bounds];
    modalBackground.image = background;
    modalBackground.contentMode = UIViewContentModeScaleToFill;
    modalBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:modalBackground atIndex:0];
    
    
    [BlockBackground sharedInstance].vignetteBackground = _vignetteBackground;
    [[BlockBackground sharedInstance] addToMainWindow:self];
    
    CGRect frame = self.frame;
    frame.origin.y = [BlockBackground sharedInstance].bounds.size.height;
    frame.size.height = _height + kActionSheetBounce;
    self.frame = frame;
    
    __block CGPoint center = self.center;
    center.y -= _height + kActionSheetBounce;
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [BlockBackground sharedInstance].alpha = 1.0f;
                         self.center = center;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              center.y += kActionSheetBounce;
                                              self.center = center;
                                          } completion:nil];
                     }];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (buttonIndex >= 0 && buttonIndex < [_blocks count])
    {
        id obj = [[_blocks objectAtIndex: buttonIndex] objectAtIndex:0];
        if (![obj isEqual:[NSNull null]])
        {
            ((void (^)())obj)();
        }
    }
    
    if (animated)
    {
        CGPoint center = self.center;
        center.y += self.bounds.size.height;
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.center = center;
                             [[BlockBackground sharedInstance] reduceAlphaIfEmpty];
                         } completion:^(BOOL finished) {
                             [[BlockBackground sharedInstance] removeView:self];
                         }];
    }
    else
    {
        [[BlockBackground sharedInstance] removeView:self];

    }
}

#pragma mark - Action
- (void)buttonClicked:(id)sender
{
    /* Run the button's block */
    NSInteger buttonIndex = [(UIButton *)sender tag] - 1;
    [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (CGSize)calculateLabelSizeBaseText:(NSString *)text Size:(CGSize)size font:(UIFont *)font{
    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionary];
    [attributesDict setObject:font forKey:NSFontAttributeName];
    CGSize result = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDict context:nil].size;
    return result;
}

@end

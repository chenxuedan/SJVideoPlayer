//
//  SJVideoPlayerTipsView.m
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2017/8/24.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJVideoPlayerTipsView.h"

#import "UIView+Extension.h"

#import <SJBorderLineView/SJBorderlineView.h>

#import <Masonry/Masonry.h>

#define SJThemeColor [UIColor colorWithRed:1 / 255.0 \
                                     green:0 / 255.0 \
                                      blue:13 / 255.0 \
                                     alpha:1]

@interface SJVideoPlayerTipsView ()

@property (nonatomic, strong, readonly) UIVisualEffectView *bottomMaskView;

@property (nonatomic, strong, readonly) UIView *tipsContainerView;

@property (nonatomic, strong, readonly) NSArray<UIView *> *tipsViewsArr;

@end


@implementation SJVideoPlayerTipsView

@synthesize bottomMaskView = _bottomMaskView;
@synthesize titleLabel = _titleLabel;
@synthesize imageView = _imageView;
@synthesize tipsContainerView = _tipsContainerView;
@synthesize tipsViewsArr = _tipsViewsArr;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _SJVideoPlayerTipsViewSetupUI];
    return self;
}

// MARK: UI

- (void)_SJVideoPlayerTipsViewSetupUI {
    
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
    
    [self addSubview:self.bottomMaskView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageView];
    [self addSubview:self.tipsContainerView];
    
    [_bottomMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_titleLabel.superview);
        make.top.offset(12);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    [_tipsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(12);
        make.trailing.offset(-12);
        make.bottom.offset(-20);
        make.height.offset(7);
    }];
    
    [self.tipsViewsArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_tipsContainerView addSubview:obj];
        if ( 0 == idx ) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.bottom.offset(0);
                make.width.equalTo(obj.superview).multipliedBy(1.0 / 16);
            }];
        }
        else {
            UIView *beforeView = _tipsViewsArr[idx - 1];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.offset(0);
                make.leading.equalTo(beforeView.mas_trailing).offset(0);
                make.width.equalTo(beforeView);
            }];
        }
    }];
}

- (UIVisualEffectView *)bottomMaskView {
    if ( _bottomMaskView ) return _bottomMaskView;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _bottomMaskView = [[UIVisualEffectView alloc] initWithEffect:effect];
    return _bottomMaskView;
}

- (UILabel *)titleLabel {
    if ( _titleLabel ) return _titleLabel;
    _titleLabel = [UILabel labelWithFontSize:16 textColor:SJThemeColor];
    return _titleLabel;
}

- (UIImageView *)imageView {
    if ( _imageView ) return _imageView;
    _imageView = [UIImageView imageViewWithImageStr:@"" viewMode:UIViewContentModeScaleAspectFit];
    return _imageView;
}

- (UIView *)tipsContainerView {
    if ( _tipsContainerView ) return _tipsContainerView;
    _tipsContainerView = [UIView new];
    _tipsContainerView.backgroundColor = SJThemeColor;
    return _tipsContainerView;
}

- (NSArray<UIView *> *)tipsViewsArr {
    if ( _tipsViewsArr ) return _tipsViewsArr;
    NSMutableArray<UIView *> *tipsArrM = [NSMutableArray new];
    for ( int i = 0 ; i < 16 ; i ++ ) {
        SJBorderlineView *view = [SJBorderlineView borderlineViewWithSide:SJBorderlineSideAll startMargin:0 endMargin:0 lineColor:SJThemeColor backgroundColor:[UIColor whiteColor]];
        [tipsArrM addObject:view];
    }
    _tipsViewsArr = tipsArrM;
    return _tipsViewsArr;
}

@end

//
//  WZMInputView.m
//  WZMKit_Example
//
//  Created by WangZhaomeng on 2019/7/19.
//  Copyright © 2019 wangzhaomeng. All rights reserved.
//

#import "WZMInputView.h"
#import "WZMInputHelper.h"
#import "WZMToolView.h"
#import "WZMEmojisKeyboard.h"
#import "WZMMoreKeyboard.h"

@interface WZMInputView ()<WZMToolViewDelegate,WZMEmojisKeyboardDelegate,WZMMoreKeyboardDelegate>

@property (nonatomic, strong) WZMToolView *inputToolView;
@property (nonatomic, strong) WZMMoreKeyboard *moreKeyboard;
@property (nonatomic, strong) WZMEmojisKeyboard *emojisKeyboard;

@end

@implementation WZMInputView {
    UIView *_toolView;
    NSArray *_keyboards;
}

#pragma mark - 实现以下三个数据源方法, 供父类调用
//设置toolView和keyboards
- (UIView *)toolViewOfInputView {
    if (_toolView == nil) {
        _toolView = self.inputToolView;
    }
    return _toolView;
}

- (NSArray<UIView *> *)keyboardsOfInputView {
    if (_keyboards == nil) {
        _keyboards = @[self.emojisKeyboard,self.moreKeyboard];
    }
    return _keyboards;
}

///视图的初始y值, 一般放在屏幕的最下方, 即: 屏幕高度-toolView的高度
- (CGFloat)startYOfInputView {
    return [UIScreen mainScreen].bounds.size.height-self.inputToolView.bounds.size.height;
}

#pragma mark - 代理事件
//toolView
- (void)toolView:(WZMToolView *)toolView didSelectAtIndex:(NSInteger)index {
    
}

- (void)toolView:(WZMToolView *)toolView showKeyboardType:(WZMKeyboardType)type {
    if (type == WZMKeyboardTypeSystem) {
        [self showSystemKeyboard];
    }
    else if (type == WZMKeyboardTypeEmoticon) {
        [self showKeyboardAtIndex:0 duration:0.3];
    }
    else if (type == WZMKeyboardTypeMore) {
        [self showKeyboardAtIndex:1 duration:0.3];
    }
    else {
        [self dismissKeyboard];
    }
}

- (void)toolView:(WZMToolView *)toolView didChangeRecordType:(WZMRecordType)type {
    if ([self.delegate respondsToSelector:@selector(inputView:didChangeRecordType:)]) {
        [self.delegate inputView:self didChangeRecordType:type];
    }
}

-(void)toolView:(WZMToolView *)toolView didSend:(WZMRecordType)type {
    //发送按钮
    [self sendText];
}

//表情键盘
- (void)emojisKeyboardDidSelectSend:(WZMEmojisKeyboard *)emojisKeyboard {
    //发送按钮
    [self sendText];
}

- (void)emojisKeyboardDidSelectDelete:(WZMEmojisKeyboard *)emojisKeyboard {
    //删除键
    [self deleteSelectedText];
}

- (void)emojisKeyboard:(WZMEmojisKeyboard *)emojisKeyboard didSelectText:(NSString *)text {
    //选择表情
    [self replaceSelectedTextWithText:text];
}

//more键盘
- (void)moreKeyboard:(WZMMoreKeyboard *)moreKeyboard didSelectType:(WZInputMoreType)type {
    //点击按钮类型
    if ([self.delegate respondsToSelector:@selector(inputView:didSelectMoreType:)]) {
        [self.delegate inputView:self didSelectMoreType:type];
    }
}

#pragma mark - 父类回调事件
//点击return键
- (BOOL)shouldReturn {
    [self sendText];
    return NO;
}

///开始编辑
- (void)didBeginEditing {
    [self resetToolViewStatus];
}

///输入框值改变
- (void)valueDidChange {
    if ([self.delegate respondsToSelector:@selector(inputView:didChangeText:)]) {
        [self.delegate inputView:self didChangeText:self.text];
    }
}

///还原视图
- (void)willResetConfig {
    [self resetToolViewStatus];
}

///视图frameb改变
- (void)willChangeFrameWithDuration:(CGFloat)duration {
    if ([self.delegate respondsToSelector:@selector(inputView:willChangeFrameWithDuration:)]) {
        [self.delegate inputView:self willChangeFrameWithDuration:duration];
    }
}

#pragma mark - private method
///还原toolView上的btn状态
- (void)resetToolViewStatus {
    [self.inputToolView resetStatus];
}

///点击发送按钮, 包括系统键盘和自定义表情键盘的发送按钮
- (void)sendText {
    if (self.text.length == 0) return;
    if ([self.delegate respondsToSelector:@selector(inputView:sendMessage:)]) {
        [self.delegate inputView:self sendMessage:self.text];
    }
    self.text = @"";
}

#pragma mark - getter
- (WZMToolView *)inputToolView {
    if (_inputToolView == nil) {
        _inputToolView = [[WZMToolView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50+[WZMInputHelper helper].iPhoneXBottomH)];
        _inputToolView.delegate = self;
        _inputToolView.backgroundColor = [UIColor colorWithRed:250/255. green:250/255. blue:250/255. alpha:1];
    }
    return _inputToolView;
}

- (WZMEmojisKeyboard *)emojisKeyboard {
    if (_emojisKeyboard == nil) {
        _emojisKeyboard = [[WZMEmojisKeyboard alloc] initWithFrame:CGRectMake(0, _toolView.bounds.size.height-[WZMInputHelper helper].iPhoneXBottomH, self.bounds.size.width, 200+[WZMInputHelper helper].iPhoneXBottomH)];
        _emojisKeyboard.delegate = self;
        _emojisKeyboard.hidden = YES;
        _emojisKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _emojisKeyboard;
}

- (WZMMoreKeyboard *)moreKeyboard {
    if (_moreKeyboard == nil) {
        _moreKeyboard = [[WZMMoreKeyboard alloc] initWithFrame:CGRectMake(0, _toolView.bounds.size.height-[WZMInputHelper helper].iPhoneXBottomH, self.bounds.size.width, 200+[WZMInputHelper helper].iPhoneXBottomH)];
        _moreKeyboard.delegate = self;
        _moreKeyboard.hidden = YES;
        _moreKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _moreKeyboard;
}

@end

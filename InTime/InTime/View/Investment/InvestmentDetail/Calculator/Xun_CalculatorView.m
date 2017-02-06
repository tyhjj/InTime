//
//  Xun_CalculatorView.m
//  InTime
//
//  Created by xunsmart on 2017/1/14.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_CalculatorView.h"
//#import "IQKeyboardManager.h"

@interface Xun_CalculatorView ()
{
    NSInteger investMoney_;
}

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeDayLabel;


@end

@implementation Xun_CalculatorView

- (void)dealloc
{
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)layoutSubviews
{
    self.textfield.inputView = [[UIView alloc] initWithFrame:CGRectZero];
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    self.incomeDayLabel.text = [NSString stringWithFormat:@"锁定%@天预计收益", self.detailModel.duration];
}

#pragma mark -
#pragma mark Action
- (IBAction)investmentAction:(id)sender {
    if (investMoney_ != 0 || self.InvestmentBtnClickHandler) {
        self.InvestmentBtnClickHandler(investMoney_);
    }
}

- (IBAction)closeBtnAction:(id)sender {
    if (self.closeBtnClickHandler) {
        self.closeBtnClickHandler();
    }
}

- (IBAction)keyClickedAction:(UIButton *)sender {
    
    if ([Xun_Util strNilOrEmpty:self.textfield.text] && (sender.tag == 0 || sender.tag == 10)) {
        return ;
    }
    
    NSString *originalStr = self.textfield.text;
    
    if (sender.tag != 10)
    {
        if ([Xun_Util strNilOrEmpty:originalStr]) {
            originalStr = @"¥";
        }
        
        originalStr = [originalStr stringByAppendingString:[NSString stringWithFormat:@"%ld", sender.tag]];
        
        self.textfield.text = originalStr;
    }
    else
    {
        NSMutableString *mulOriStr = [NSMutableString stringWithString:originalStr];
        NSRange range = {mulOriStr.length - 1, 1};
        [mulOriStr deleteCharactersInRange:range];
        
        if ([mulOriStr isEqualToString:@"¥"]) {
            mulOriStr = [NSMutableString stringWithString:[NSString empty]];
        }
        
        self.textfield.text = mulOriStr;
    }
    
    NSMutableString *resultStr = [NSMutableString stringWithString:self.textfield.text];
    if ([resultStr hasPrefix:@"¥"]) {
        NSRange range = {0, 1};
        [resultStr deleteCharactersInRange:range];
    }
    
    investMoney_ = [resultStr integerValue];
    
    [self calculateWithMoney:[resultStr integerValue]];
}

#pragma mark -
#pragma mark Calcalate
- (void)calculateWithMoney:(NSInteger)money
{
    float incom = [self.detailModel.rate floatValue] / 100.0 / 360.0 * [self.detailModel.duration integerValue] * money;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f", incom];
}

@end

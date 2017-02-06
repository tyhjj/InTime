//
//  Xun_IncomeCell.m
//  InTime
//
//  Created by xunsmart on 2017/1/11.
//  Copyright © 2017年 Xunsmart. All rights reserved.
//

#import "Xun_IncomeCell.h"
#import "Xun_SymbolsValueFormatter.h"
#import "Xun_DateValueFormatter.h"
#import "Xun_SetValueFormatter.h"

@interface Xun_IncomeCell ()

@property (nonatomic, strong) LineChartView *chartsView;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@end

@implementation Xun_IncomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    if (_chartsView == nil) {
        _chartsView = [[LineChartView alloc] initWithFrame:CGRectMake(self.contentView.width / 2.0, 35, self.contentView.width / 2 - 10, 90)];
//        _chartsView.delegate = self;//设置代理
        _chartsView.backgroundColor =  [UIColor whiteColor];
        _chartsView.noDataText = @"暂无数据";
        _chartsView.chartDescription.enabled = YES;
        _chartsView.scaleYEnabled = NO;//取消Y轴缩放
        _chartsView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _chartsView.dragEnabled = NO;//启用拖拽图标
        _chartsView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
        _chartsView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //描述及图例样式
        [_chartsView setDescriptionText:@""];
        _chartsView.legend.enabled = NO;
        [_chartsView animateWithXAxisDuration:1.0f];
        
        _chartsView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _chartsView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 8;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = YES;//不强制绘制指定数量的label
        leftAxis.axisMinValue = 0;//设置Y轴的最小值
        leftAxis.axisMaxValue = 175;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor grayColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        leftAxis.valueFormatter = [[Xun_SymbolsValueFormatter alloc]init];//设置y轴的数据格式
        
        ChartXAxis *xAxis = _chartsView.xAxis;
        xAxis.granularityEnabled = NO;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        leftAxis.forceLabelsEnabled = YES;//不强制绘制指定数量的label
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = [UIColor blackColor];//文字颜色
        xAxis.axisLineColor = [UIColor grayColor];

        
//        _chartsView.data = [self randomData];
        
        [self.contentView addSubview:_chartsView];
    }
}

- (LineChartData *)randomData
{
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.model.min.count; i++) {
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[self.model.invest[i] floatValue]];
        [yVals addObject:entry];
    }
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.model.min.count; i++) {
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[self.model.income[i] floatValue]];
        [yVals2 addObject:entry];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yVals label:nil];
    //设置折线的样式
    set1.lineWidth = 1;//折线宽度
    
    set1.drawValuesEnabled = YES;//是否在拐点处显示数据
    set1.valueFormatter = [[Xun_SetValueFormatter alloc] init];
    
    set1.valueColors = @[[UIColor blueColor]];//折线拐点处显示数据的颜色
    
    [set1 setColor:[UIColor greenColor]];//折线颜色
    set1.highlightColor = [UIColor redColor];
    set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
    //折线拐点样式
    set1.drawCirclesEnabled = YES;//是否绘制拐点
    set1.drawFilledEnabled = NO;//是否填充颜色
    
    //将 LineChartDataSet 对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    //添加第二个LineChartDataSet对象
    LineChartDataSet *set2 = [set1 copy];
    set2.values = yVals2;
    set2.drawValuesEnabled = YES;
    [set2 setColor:[UIColor blueColor]];
    [dataSets addObject:set2];
    
    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
    [data setValueTextColor:[UIColor blackColor]];//文字颜色
    
    
    return data;
}

- (void)setModel:(Xun_IncomeModel *)model
{
    if (_model != model) {
        _model = model;
        
        ChartXAxis *xAxis = _chartsView.xAxis;
        xAxis.labelCount = _model.min.count;
        xAxis.valueFormatter = [[Xun_DateValueFormatter alloc] initWithArray:_model.min];
        
        _chartsView.data = [self randomData];
        
    }
}

@end

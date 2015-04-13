//
//  QSMortgageCalculatorViewController.m
//  House
//
//  Created by 王树朋 on 15/4/6.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSMortgageCalculatorViewController.h"

#import "QSCustomSingleSelectedPopView.h"

#import "QSBlockButtonStyleModel+Normal.h"
#import "QSBlockButtonStyleModel+NavigationBar.h"

#import "UITextField+CustomField.h"
#import "NSString+Calculation.h"
#import "QSBlockView.h"

#import "QSBaseConfigurationDataModel.h"

#import "QSCoreDataManager+House.h"

#import <objc/runtime.h>

///默认的顶部导航栏高度
#define RATE_DEFAULT_ACCUMULATION_VALUE   4.05f      //!<公积金贷款利率
#define RATE_DEFAULT_BUSINESS_VALUE       6.15f      //!<商业贷款利率

///关联
static char accumulationTextFieldKey;   //!<公积金关联KEY
static char BusinessViewKey;            //!<商业贷款关联KEY
static char GrounpViewKey;              //!<组合贷款关联KEY

@interface QSMortgageCalculatorViewController ()<UITextFieldDelegate>

@property(nonatomic,assign) CGFloat housePrice;

@end

@implementation QSMortgageCalculatorViewController

-(instancetype)initWithHousePrice:(CGFloat )housePrice
{
    
    if (self = [super init]) {
        
        self.housePrice = housePrice;
        
    }
    
    return self;
    
}

-(void)createNavigationBarUI
{
    
    [super createNavigationBarUI];
    [self setNavigationBarTitle:@"房贷计算"];
    
}

-(void)createMainShowUI
{
    
    ///列表指针
    __block UIView *accumulationTextField;
    __block UIView *businessView;
    __block UIView *groupView;
    
    ///指示三角指针
    __block UIImageView *arrowIndicator;
    
    ///按钮指针
    __block UIButton *accumulationButton;
    __block UIButton *businessButton;
    __block UIButton *groupButton;
    
    ///尺寸
    CGFloat widthButton = SIZE_DEVICE_WIDTH / 3.0f;
    CGFloat listYPoint = 64.0f + 44.0f ;
    
    ///按钮风格
    QSBlockButtonStyleModel *buttonStyle = [QSBlockButtonStyleModel createNormalButtonWithType:nNormalButtonTypeClearGray];
    buttonStyle.bgColorSelected = COLOR_CHARACTERS_LIGHTYELLOW;
    buttonStyle.titleFont = [UIFont systemFontOfSize:FONT_BODY_16];
    
    ///公积金贷
    buttonStyle.title = @"公积金贷";
    accumulationButton = [UIButton createBlockButtonWithFrame:CGRectMake(0.0f, 64.0f, widthButton, 44.0f) andButtonStyle:buttonStyle andCallBack:^(UIButton *button) {
        
        ///当前已处于选择状态
        if (button.selected) {
            
            return;
            
        }
        
        ///切换按钮状态
        button.selected = YES;
        businessButton.selected = NO;
        groupButton.selected = NO;
        
        ///切换列表
        accumulationTextField = [[UIView alloc] initWithFrame:CGRectMake(-SIZE_DEVICE_WIDTH, listYPoint, SIZE_DEVICE_WIDTH, SIZE_DEVICE_HEIGHT-listYPoint)];
        accumulationTextField.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:accumulationTextField];
        
        [self createMortgageView:accumulationTextField andMortgageType:mMortgageAccumulationType];
        
        ///获取当前正在显示的view
        UIView *tempView = businessView ? businessView : groupView;
        
        ///移动指示器
        [UIView animateWithDuration:0.3f animations:^{
            
            arrowIndicator.frame = CGRectMake(button.frame.origin.x + button.frame.size.width / 2.0f - 7.5f, arrowIndicator.frame.origin.y, arrowIndicator.frame.size.width, arrowIndicator.frame.size.height);
            
            tempView.frame = CGRectMake(SIZE_DEVICE_WIDTH, tempView.frame.origin.y, tempView.frame.size.width, tempView.frame.size.height);
            
            accumulationTextField.frame = CGRectMake(0.0f, accumulationTextField.frame.origin.y, accumulationTextField.frame.size.width, accumulationTextField.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [tempView removeFromSuperview];
            businessView = nil;
            groupView = nil;
            
        }];
        
        objc_setAssociatedObject(self, &accumulationTextFieldKey, accumulationTextField, OBJC_ASSOCIATION_ASSIGN);
        
    }];
    [self.view addSubview:accumulationButton];
    
    ///商业贷款
    buttonStyle.title = @"商业贷款";
    businessButton = [UIButton createBlockButtonWithFrame:CGRectMake(accumulationButton.frame.origin.x + accumulationButton.frame.size.width, 64.0f, widthButton, 44.0f) andButtonStyle:buttonStyle andCallBack:^(UIButton *button) {
        
        ///当前已处于选择状态
        if (button.selected) {
            
            return;
            
        }
        
        ///切换按钮状态
        button.selected = YES;
        accumulationButton.selected = NO;
        groupButton.selected = NO;
        
        ///坐标
        CGFloat xpoint = -SIZE_DEVICE_WIDTH;
        CGFloat endXPoint = SIZE_DEVICE_WIDTH;
        if (accumulationTextField) {
            
            xpoint = -xpoint;
            endXPoint = - endXPoint;
            
        }
        
        ///切换列表
        businessView = [[UIView alloc] initWithFrame:CGRectMake(xpoint, listYPoint, SIZE_DEVICE_WIDTH, SIZE_DEVICE_HEIGHT - listYPoint)];
        businessView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:businessView];
        
        [self createMortgageView:businessView andMortgageType:mMortgageBusinessType];
        ///获取当前正在显示的view
        UIView *tempView = accumulationTextField ? accumulationTextField : groupView;
        
        ///移动指示器
        [UIView animateWithDuration:0.3f animations:^{
            
            arrowIndicator.frame = CGRectMake(button.frame.origin.x + button.frame.size.width / 2.0f - 7.5f, arrowIndicator.frame.origin.y, arrowIndicator.frame.size.width, arrowIndicator.frame.size.height);
            
            tempView.frame = CGRectMake(endXPoint, tempView.frame.origin.y, tempView.frame.size.width, tempView.frame.size.height);
            
            businessView.frame = CGRectMake(0.0f, businessView.frame.origin.y, businessView.frame.size.width, businessView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [tempView removeFromSuperview];
            accumulationTextField = nil;
            groupView = nil;
            
        }];
        objc_setAssociatedObject(self, &BusinessViewKey, businessView, OBJC_ASSOCIATION_ASSIGN);
        
        
    }];
    businessButton.selected=YES;
    [self.view addSubview:businessButton];
    
    ///组合贷款
    buttonStyle.title = @"组合贷款";
    groupButton = [UIButton createBlockButtonWithFrame:CGRectMake(businessButton.frame.origin.x + businessButton.frame.size.width, 64.0f, widthButton, 44.0f) andButtonStyle:buttonStyle andCallBack:^(UIButton *button) {
        
        ///当前已处于选择状态
        if (button.selected) {
            
            return;
            
        }
        
        ///切换按钮状态
        button.selected = YES;
        accumulationButton.selected = NO;
        businessButton.selected = NO;
        
        ///切换列表
        groupView = [[UIView alloc] initWithFrame:CGRectMake(SIZE_DEVICE_WIDTH, listYPoint, SIZE_DEVICE_WIDTH, SIZE_DEVICE_HEIGHT - listYPoint)];
        groupView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:groupView];
        [self createMortgageView:groupView andMortgageType:mMortgageGrounpType];
        ///获取当前正在显示的view
        UIView *tempView = accumulationTextField ? accumulationTextField : businessView;
        
        ///移动指示器
        [UIView animateWithDuration:0.3f animations:^{
            
            arrowIndicator.frame = CGRectMake(button.frame.origin.x + button.frame.size.width / 2.0f - 7.5f, arrowIndicator.frame.origin.y, arrowIndicator.frame.size.width, arrowIndicator.frame.size.height);
            
            tempView.frame = CGRectMake(-SIZE_DEVICE_WIDTH, tempView.frame.origin.y, tempView.frame.size.width, tempView.frame.size.height);
            
            groupView.frame = CGRectMake(0.0f, groupView.frame.origin.y, groupView.frame.size.width, groupView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [tempView removeFromSuperview];
            accumulationTextField = nil;
            businessView = nil;
            
        }];
        objc_setAssociatedObject(self, &GrounpViewKey, groupView, OBJC_ASSOCIATION_ASSIGN);
        
        
    }];
    [self.view addSubview:groupButton];
    
    ///初始化时，加载商业贷款列表
    businessView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, listYPoint, SIZE_DEVICE_WIDTH, SIZE_DEVICE_HEIGHT - listYPoint)];
    [self.view addSubview:businessView];
    [self createMortgageView:businessView andMortgageType:mMortgageBusinessType];
    
    ///指示三角
    arrowIndicator = [[QSImageView alloc] initWithFrame:CGRectMake(businessButton.frame.origin.x+businessButton.frame.size.width / 2.0f - 7.5f, businessButton.frame.origin.y + businessButton.frame.size.height - 5.0f, 15.0f, 5.0f)];
    arrowIndicator.image = [UIImage imageNamed:IMAGE_CHANNELBAR_INDICATE_ARROW];
    [self.view addSubview:arrowIndicator];
    
}

#pragma mark -添加UI
-(void)createMortgageView:(UIView *)view andMortgageType:(MORTGAGE_ACTION_TYPE)mortageType
{
    
    __block QSLabel *repayModelResultLabel;
    
    ///还款方式
    UIView *repayModelView = [[QSBlockView alloc] initWithFrame:CGRectMake(25.0f, 0.0f, SIZE_DEVICE_WIDTH-2.0f*25.0f, 50.0f) andSingleTapCallBack:^(BOOL flag) {
        
        ///获取贷款方式数据
        NSArray *intentArray = [QSCoreDataManager getMortgageTypes];
        [self popMortgageTypePickView:repayModelResultLabel andDataSource:intentArray];
        
    }];
    [view addSubview:repayModelView];
    
    QSLabel *repayModelLabel = [[QSLabel alloc] initWithFrame:CGRectMake(0.0f, 15.0f, 80.0f, 20.0f)];
    repayModelLabel.text = @"还款方式:";
    repayModelLabel.font = [UIFont systemFontOfSize:14.0f];
    [repayModelView addSubview:repayModelLabel];
    
    repayModelResultLabel = [[QSLabel alloc] initWithFrame:CGRectMake(SIZE_DEVICE_WIDTH-50.0f-13.0f-100.0f, repayModelLabel.frame.origin.y, 100.0f, 20.0f)];
    [repayModelView addSubview:repayModelResultLabel];
    repayModelResultLabel.text = @"等额本息";
    repayModelResultLabel.textAlignment = NSTextAlignmentRight;
    repayModelResultLabel.textColor = COLOR_CHARACTERS_GRAY;
    repayModelResultLabel.font = [UIFont systemFontOfSize:14.0f];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(repayModelResultLabel.frame.origin.x+repayModelResultLabel.frame.size.width, 13.0f, 13.0f, 23.0f)];
    arrowImageView.image = [UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW];
    [repayModelView addSubview:arrowImageView];
    
    ///分隔线
    UILabel *sepLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(repayModelView.frame.origin.x, repayModelView.frame.origin.y+repayModelView.frame.size.height-0.25f, repayModelView.frame.size.width, 0.25f)];
    sepLabel0.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:sepLabel0];
    
    ///列表指针
    __block UITextField *accumulationTextField;   //!<公积金贷款
    __block UITextField *totalTextField;          //!<总额贷款或商业贷款
    
    if (mortageType == mMortgageGrounpType) {
        ///公积金贷款
        accumulationTextField = [QSTextField createCustomTextFieldWithFrame:CGRectMake(25.0f, repayModelView.frame.origin.y+repayModelView.frame.size.height, repayModelView.frame.size.width, repayModelView.frame.size.height) andPlaceHolder:nil andLeftTipsInfo:@"公积金贷款:"  andRightTipsInfo:@"万元" andLeftTipsTextAlignment:NSTextAlignmentLeft andTextFieldStyle:cCustomTextFieldStyleLeftAndRightTipsBlack];
        accumulationTextField.textAlignment = NSTextAlignmentRight;
        accumulationTextField.textColor = COLOR_CHARACTERS_GRAY;
        accumulationTextField.text = [NSString stringWithFormat:@"%.2f",self.housePrice];
        accumulationTextField.delegate = self;
        
        [view addSubview:accumulationTextField];
        
        
        ///分隔线
        UILabel *sepLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(accumulationTextField.frame.origin.x, accumulationTextField.frame.origin.y+accumulationTextField.frame.size.height-0.25f, repayModelView.frame.size.width, 0.25f)];
        sepLabel1.backgroundColor = COLOR_CHARACTERS_BLACKH;
        [view addSubview:sepLabel1];
        
        ///商业贷款
        totalTextField = [QSTextField createCustomTextFieldWithFrame:CGRectMake(25.0f, accumulationTextField.frame.origin.y+accumulationTextField.frame.size.height, repayModelView.frame.size.width, repayModelView.frame.size.height) andPlaceHolder:nil andLeftTipsInfo:@"商业贷款:" andRightTipsInfo:@"万元" andLeftTipsTextAlignment:NSTextAlignmentLeft andTextFieldStyle:cCustomTextFieldStyleLeftAndRightTipsBlack];
        totalTextField.delegate = self;
        totalTextField.text = [NSString stringWithFormat:@"%.2f",self.housePrice];
        totalTextField.textAlignment = NSTextAlignmentRight;
        totalTextField.textColor = COLOR_CHARACTERS_GRAY;
        [view addSubview:totalTextField];
        
        ///分隔线
        UILabel *sepLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(totalTextField.frame.origin.x, totalTextField.frame.origin.y+totalTextField.frame.size.height-0.25f, repayModelView.frame.size.width, 0.25f)];
        sepLabel2.backgroundColor = COLOR_CHARACTERS_BLACKH;
        [view addSubview:sepLabel2];
        
    }
    else{
        ///贷款总额
        totalTextField = [QSTextField createCustomTextFieldWithFrame:CGRectMake(25.0f, repayModelView.frame.origin.y+repayModelView.frame.size.height, repayModelView.frame.size.width, repayModelView.frame.size.height) andPlaceHolder:nil andLeftTipsInfo:@"贷款总额:" andRightTipsInfo:@"万元" andLeftTipsTextAlignment:NSTextAlignmentLeft andTextFieldStyle:cCustomTextFieldStyleLeftAndRightTipsBlack];
        totalTextField.delegate = self;
        totalTextField.text = [NSString stringWithFormat:@"%.2f",self.housePrice];
        totalTextField.textAlignment = NSTextAlignmentRight;
        totalTextField.textColor = COLOR_CHARACTERS_GRAY;
        [view addSubview:totalTextField];
        
        ///分隔线
        UILabel *sepLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(totalTextField.frame.origin.x, totalTextField.frame.origin.y+totalTextField.frame.size.height-0.25f, repayModelView.frame.size.width, 0.25f)];
        sepLabel1.backgroundColor = COLOR_CHARACTERS_BLACKH;
        [view addSubview:sepLabel1];
    }
    
    ///贷款年限
    __block UILabel *yearResultLabel;
    UIView *yearView = [[QSBlockView alloc] initWithFrame:CGRectMake(25.0f, totalTextField.frame.origin.y+totalTextField.frame.size.height, repayModelView.frame.size.width, repayModelView.frame.size.height) andSingleTapCallBack:^(BOOL flag) {
        
        APPLICATION_LOG_INFO(@"点击贷款年限", nil);
        ///获取贷款选择项数据
        NSArray *intentArray = [QSCoreDataManager getMortgageYears];
        [self popMortgageTypePickView:yearResultLabel andDataSource:intentArray];
        
        
    }];
    QSLabel *yearLabel = [[QSLabel alloc] initWithFrame:CGRectMake(0.0f, 15.0f, 80.0f, 20.0f)];
    yearLabel.text = @"贷款年限:";
    yearLabel.font = [UIFont systemFontOfSize:14.0f];
    [yearView addSubview:yearLabel];
    
    yearResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE_DEVICE_WIDTH-50.0f-13.0f-100.0f, repayModelLabel.frame.origin.y, 100.0f, 20.0f)];
    yearResultLabel.textAlignment = NSTextAlignmentRight;
    yearResultLabel.textColor = COLOR_CHARACTERS_GRAY;
    yearResultLabel.font = [UIFont systemFontOfSize:14.0f];
    yearResultLabel.text = @"20年";
    [yearView addSubview:yearResultLabel];
    
    UIImageView *arrowImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_DEVICE_WIDTH-50.0f-13.0f, 13.0f, 13.0f, 23.0f)];
    arrowImageView2.image = [UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW];
    [yearView addSubview:arrowImageView2];
    [view addSubview:yearView];
    
    ///分隔线
    UILabel *sepLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(yearView.frame.origin.x, yearView.frame.origin.y+yearView.frame.size.height-0.25f, repayModelView.frame.size.width, 0.25f)];
    sepLabel2.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:sepLabel2];
    
    ///贷款利率
    UIView *rateView = [[QSBlockView alloc] initWithFrame:CGRectMake(25.0f, yearView.frame.origin.y+yearView.frame.size.height, repayModelView.frame.size.width, repayModelView.frame.size.height) andSingleTapCallBack:^(BOOL flag) {
        
        APPLICATION_LOG_INFO(@"点击贷款利率", nil);
    }];
    QSLabel *rateLabel = [[QSLabel alloc] initWithFrame:CGRectMake(0.0f, 15.0f, 80.0f, 20.0f)];
    rateLabel.text = @"贷款利率:";
    rateLabel.font = [UIFont systemFontOfSize:14.0f];
    [rateView addSubview:rateLabel];
    
    __block UILabel *rateResultLabel;
    rateResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE_DEVICE_WIDTH-50.0f-13.0f-100.0f, rateLabel.frame.origin.y, 100.0f, 20.0f)];
    rateResultLabel.textAlignment = NSTextAlignmentRight;
    rateResultLabel.textColor = COLOR_CHARACTERS_GRAY;
    rateResultLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if (mortageType == mMortgageAccumulationType) {
        
        rateResultLabel.text = [NSString stringWithFormat:@"%.2f", RATE_DEFAULT_ACCUMULATION_VALUE];
        
    }
    else
    {
        rateResultLabel.text = [NSString stringWithFormat:@"%.2f", RATE_DEFAULT_BUSINESS_VALUE];
        
    }
    [rateView addSubview:rateResultLabel];
    
    UIImageView *arrowImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_DEVICE_WIDTH-50.0f-13.0f, 13.0f, 13.0f, 23.0f)];
    arrowImageView3.image = [UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW];
    [rateView addSubview:arrowImageView3];
    [view addSubview:rateView];
    
    ///分隔线
    UILabel *sepLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(yearView.frame.origin.x, rateView.frame.origin.y+rateView.frame.size.height-0.25f, repayModelView.frame.size.width, 0.25f)];
    sepLabel3.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:sepLabel3];
    
    ///计算结果UI
    UIView *resultView = [[UIView alloc] initWithFrame:CGRectMake(rateView.frame.origin.x, rateView.frame.origin.y+rateView.frame.size.height+20.0f, rateView.frame.size.width, 120.0f)];
    resultView.backgroundColor = COLOR_CHARACTERS_YELLOW;
    [view addSubview:resultView];
    
    UILabel *repaymentToalLabel= [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 15.0f, 80.0f, 20.0f)];
    repaymentToalLabel.text =@"还款总额:";
    repaymentToalLabel.font = [UIFont systemFontOfSize:16.0f];
    [resultView addSubview:repaymentToalLabel];
    
    UILabel *repaymentToalResult = [[UILabel alloc] initWithFrame:CGRectMake(repaymentToalLabel.frame.origin.x+repaymentToalLabel.frame.size.width, repaymentToalLabel.frame.origin.y, 160.0f, repaymentToalLabel.frame.size.height)];
    repaymentToalResult.text = @"0元" ;
    repaymentToalResult.font = [UIFont systemFontOfSize:20.0f];
    [resultView addSubview:repaymentToalResult];
    
    UILabel *payInterestLabel= [[UILabel alloc] initWithFrame:CGRectMake(repaymentToalLabel.frame.origin.x,repaymentToalLabel.frame.origin.y+repaymentToalLabel.frame.size.height+15.0f, repaymentToalLabel.frame.size.width, repaymentToalLabel.frame.size.height)];
    payInterestLabel.text =@"支付利息:";
    payInterestLabel.font = [UIFont systemFontOfSize:16.0f];
    [resultView addSubview:payInterestLabel];
    
    UILabel *payInterestResult = [[UILabel alloc] initWithFrame:CGRectMake(payInterestLabel.frame.origin.x+payInterestLabel.frame.size.width, payInterestLabel.frame.origin.y, 160.0f, payInterestLabel.frame.size.height)];
    payInterestResult.text = @"0元" ;
    payInterestResult.font = [UIFont systemFontOfSize:20.0f];
    [resultView addSubview:payInterestResult];
    
    UILabel *monthPaymentLabel= [[UILabel alloc] initWithFrame:CGRectMake(payInterestLabel.frame.origin.x,payInterestLabel.frame.origin.y+payInterestLabel.frame.size.height+15.0f, payInterestLabel.frame.size.width, payInterestLabel.frame.size.height)];
    monthPaymentLabel.text =@"月均还款:";
    payInterestLabel.font = [UIFont systemFontOfSize:16.0f];
    [resultView addSubview:monthPaymentLabel];
    
    UILabel *monthPaymentResult = [[UILabel alloc] initWithFrame:CGRectMake(monthPaymentLabel.frame.origin.x+monthPaymentLabel.frame.size.width, monthPaymentLabel.frame.origin.y, 160.0f, monthPaymentLabel.frame.size.height)];
    monthPaymentResult.text = @"0元" ;
    monthPaymentResult.font = [UIFont systemFontOfSize:20.0f];
    [resultView addSubview:monthPaymentResult];
    
    ///分隔线
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, SIZE_DEVICE_HEIGHT-108.0f-60.0f, SIZE_DEVICE_WIDTH, 0.25f)];
    bottomLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:bottomLine];
    
    ///按钮风格
    QSBlockButtonStyleModel *buttonStyel = [[QSBlockButtonStyleModel alloc] init];
    buttonStyel.bgColor = COLOR_CHARACTERS_YELLOW;
    buttonStyel.cornerRadio = 6.0f;
    
    ///计算按钮
    buttonStyel.title = @"计算";
    UIButton *countButton = [QSBlockButton createBlockButtonWithFrame:CGRectMake(SIZE_DEFAULT_MARGIN_LEFT_RIGHT, bottomLine.frame.origin.y+bottomLine.frame.size.height+8.0f, bottomLine.frame.size.width - 2.0f * SIZE_DEFAULT_MARGIN_LEFT_RIGHT, 44.0f) andButtonStyle:buttonStyel andCallBack:^(UIButton *button) {
        NSLog(@"计算");
        
        if (mortageType == mMortgageGrounpType) {
            NSString *accumString = accumulationTextField.text;
            if ([accumString length] <= 0) {
                
                TIPS_ALERT_MESSAGE_ANDTURNBACK(@"请输入公积金贷款总额", 1.0f, ^(){
                    
                    [accumulationTextField becomeFirstResponder];
                    
                })
                
                return;
            }
            
            NSString *totalString = totalTextField.text;
            if ([totalString length] <= 0) {
                
                TIPS_ALERT_MESSAGE_ANDTURNBACK(@"请输入商业贷款总额", 1.0f, ^(){
                    
                    [totalTextField becomeFirstResponder];
                    
                })
                
                return;
            }
            
            ///刷新数据
 
            ///月均还款
            monthPaymentResult.text = [NSString stringWithFormat:@"%.2f%@",[NSString calculateMonthlyMortgatePayment:[accumulationTextField.text floatValue]*10000.0f andPaymentType:lLoadRatefeeCalculateHousingAccumulationFundLoan andRate:RATE_DEFAULT_ACCUMULATION_VALUE/100.0f/12.0f andTimes:[yearResultLabel.text floatValue]*12.0f] + [NSString calculateMonthlyMortgatePayment:[totalTextField.text floatValue]*10000.0f andPaymentType:lLoadRatefeeBusinessLoan andRate:[rateResultLabel.text floatValue]/100.0f/12.0f andTimes:[yearResultLabel.text floatValue]*12.0f],@"元"];
            
            ///还款总额
            repaymentToalResult.text = [NSString stringWithFormat:@"%.2f%@",[monthPaymentResult.text floatValue]*[yearResultLabel.text floatValue]*12.0f,@"元"];
            
            ///支付利息
            payInterestResult.text = [NSString stringWithFormat:@"%.2f%@",[repaymentToalResult.text floatValue]-[accumulationTextField.text floatValue]*10000.0f -[totalTextField.text floatValue]*10000.0f,@"元"];
            
        }
        
        else{
            NSString *totalString = totalTextField.text;
            if ([totalString length] <= 0) {
                
                TIPS_ALERT_MESSAGE_ANDTURNBACK(@"请输入贷款总额", 1.0f, ^(){
                    
                    [totalTextField becomeFirstResponder];
                    
                })
                
                return;
            }
            
            ///刷新数据
            
            ///月均还款
            monthPaymentResult.text = [NSString stringWithFormat:@"%.2f%@",[NSString calculateMonthlyMortgatePayment:[totalTextField.text floatValue]*10000.0f andPaymentType:lLoadRatefeeBusinessLoan andRate:[rateResultLabel.text floatValue]/1200.0f andTimes:[yearResultLabel.text floatValue]*12.0f],@"元"];
            
            ///还款总额
            repaymentToalResult.text = [NSString stringWithFormat:@"%.2f%@",[monthPaymentResult.text floatValue]*[yearResultLabel.text floatValue]*12.0f,@"元"];
            
            ///支付利息
            payInterestResult.text = [NSString stringWithFormat:@"%.2f%@",[repaymentToalResult.text floatValue]-[totalTextField.text floatValue]*10000.0f,@"元"];
        }
        
        ///回收键盘
        [accumulationTextField resignFirstResponder];
        [totalTextField resignFirstResponder];
    }];
    
    [view addSubview:countButton];
    
}

#pragma mark -弹出选择框的过滤列表
- (void)popMortgageTypePickView:(UILabel *)label andDataSource:(NSArray *)intentArray
{
    
    ///获取房子装修类型选择项数据
    //NSArray *intentArray = [QSCoreDataManager getMortgageTypes];
    
    ///显示房子装修类型选择窗口
    [QSCustomSingleSelectedPopView showSingleSelectedViewWithDataSource:intentArray andCurrentSelectedKey:nil andSelectedCallBack:^(CUSTOM_POPVIEW_ACTION_TYPE actionType, id params, int selectedIndex) {
        
        if (cCustomPopviewActionTypeSingleSelected == actionType) {
            
            ///转模型
            QSBaseConfigurationDataModel *tempModel = params;
            
            label.text = tempModel.val;
            
        } else if (cCustomPopviewActionTypeUnLimited == actionType) {
            
            label.text = nil;
            
        }
        
    }];
    
}

#pragma mark -键盘代理方法
///键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}
@end

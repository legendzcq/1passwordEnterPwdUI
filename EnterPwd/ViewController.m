//
//  ViewController.m
//  EnterPwd
//
//  Created by 张传奇 on 16/11/28.
//  Copyright © 2016年 张传奇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    int tempheight;
    int tempwidth;
}
@property (strong, nonatomic)  UIView *UpView;
@property (strong, nonatomic)  UIView *DownView;
@property (strong, nonatomic)  UIImageView *iconView;
@property (strong, nonatomic)  UITextField *uiText;
@property (strong, nonatomic)  UIButton *inputBtn;
@property (strong, nonatomic)  UIView * iconBack;
@property (strong, nonatomic)  UIView * btnBackView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uitextFieldBeginEditing:)name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uitextFieldEndEditing:)name:UITextFieldTextDidEndEditingNotification object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    tempheight =self.view.frame.size.height*0.5;
    tempwidth= (self.view.frame.size.width-230)*0.5;
    UIView * upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, tempheight)];
    upView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:upView];
    self.UpView = upView;
    
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, tempheight, self.view.frame.size.width, tempheight)];
    downView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:downView];
    self.DownView = downView;
    
    
    UIView * iconBack = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-110)*0.5, (tempheight-110)*0.5, 110, 110)];
    iconBack.backgroundColor = [UIColor redColor];
    iconBack.layer.cornerRadius = 55;
    [upView addSubview:iconBack];
    self.iconBack = iconBack;
    
    
    UIImageView * iconv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"settings_vaults"]];
    iconv.layer.cornerRadius = 50;
    iconv.frame =CGRectMake(5, 5, 100, 100);
    [iconBack addSubview:iconv];
    self.iconView = iconv;
    
    UITextField * uiText = [[UITextField alloc]initWithFrame:CGRectMake(tempwidth, 150, 200, 30)];
    uiText.placeholder = @"请输入主密码";
    uiText.backgroundColor = [UIColor whiteColor];
    [downView addSubview:uiText];
    self.uiText = uiText;
    
    
    UIView * btnBackView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(uiText.frame), CGRectGetMidY(uiText.frame)-15, 30, 30)];
     btnBackView.backgroundColor = [UIColor purpleColor];
    [downView addSubview:btnBackView];
    self.btnBackView = btnBackView;
    
    UIButton * inputBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(uiText.frame), CGRectGetMidY(uiText.frame)-15, 30, 30)];
    [inputBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    inputBtn.backgroundColor = [UIColor grayColor];
    [downView addSubview:inputBtn];
    self.inputBtn = inputBtn;
}



-(void)uitextFieldBeginEditing:( NSNotification *)notifin
{
     [UIView animateWithDuration:0.24 animations:^{
         self.uiText.frame =CGRectMake(tempwidth, 0, 200, 30);
         self.btnBackView.frame =self.inputBtn.frame =CGRectMake(CGRectGetMaxX(_uiText.frame), CGRectGetMidY(_uiText.frame)-15, 30, 30);
          self.iconBack.frame =CGRectMake((self.view.frame.size.width-110)*0.5, (tempheight-110)*0.5+100, 110, 110);
      
     }];
}

-(void)uitextFieldEndEditing:( NSNotification *)notifin
{
    [UIView animateWithDuration:0.24 animations:^{
        self.uiText.frame =CGRectMake(tempwidth, 150, 200, 30);
        self.btnBackView.frame =self.inputBtn.frame =CGRectMake(CGRectGetMaxX(_uiText.frame), CGRectGetMidY(_uiText.frame)-15, 30, 30);
        self.iconBack.frame =CGRectMake((self.view.frame.size.width-110)*0.5, (tempheight-110)*0.5, 110, 110);
    }];
}
-(void)btnClick
{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [UIView animateWithDuration:1  animations:^{
        self.inputBtn.frame =CGRectMake(tempwidth, CGRectGetMidY(_uiText.frame)-15, 30, 30);
        self.btnBackView.frame =CGRectMake(tempwidth, CGRectGetMidY(_uiText.frame)-15, 230, 30);
        
        
        
        CABasicAnimation *downanimation = nil;
        //平移
        downanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        //setFromValue不设置,默认以当前状态为准
        [downanimation setToValue:@(M_PI)];
        [downanimation setDelegate:self];//代理回调
        [downanimation setDuration:0.5];//设置动画时间，单次动画时间
        //    [animation setRemovedOnCompletion:YES];//默认为YES,设置为NO时setFillMode有效
        [downanimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [downanimation setAutoreverses:NO];
        [downanimation setFillMode:kCAFillModeBackwards];
        [self.iconView.layer addAnimation:downanimation forKey:@"iconViewbaseanimation"];
        
        self.iconBack.backgroundColor = [UIColor greenColor];
        
    } completion:^(BOOL finished) {
        [self backgroundanimation];
    }];
}
-(void)backgroundanimation
{
        CABasicAnimation *downanimation = nil;
        //平移
        downanimation = [CABasicAnimation animationWithKeyPath:@"position"];
        //setFromValue不设置,默认以当前状态为准
        [downanimation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 700)]];
        [downanimation setDelegate:self];//代理回调
        [downanimation setDuration:0.5];//设置动画时间，单次动画时间
    //    [animation setRemovedOnCompletion:YES];//默认为YES,设置为NO时setFillMode有效
        [downanimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [downanimation setAutoreverses:NO];
        [downanimation setFillMode:kCAFillModeBackwards];
        [self.DownView.layer addAnimation:downanimation forKey:@"baseanimation"];
    //     [self.iconView.layer addAnimation:downanimation forKey:@"baseanimation"];
    
        CABasicAnimation *upanimation = nil;
        //平移
        upanimation = [CABasicAnimation animationWithKeyPath:@"position"];
        //setFromValue不设置,默认以当前状态为准
        [upanimation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 700)]];
        [upanimation setDelegate:self];//代理回调
        [upanimation setDuration:0.5];//设置动画时间，单次动画时间
        //    [animation setRemovedOnCompletion:YES];//默认为YES,设置为NO时setFillMode有效
        [upanimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [upanimation setAutoreverses:NO];
        [upanimation setFillMode:kCAFillModeBackwards];
        [self.UpView.layer addAnimation:upanimation forKey:@"baseanimation"];
    //        [self.iconView.layer addAnimation:upanimation forKey:@"baseanimation"];
}
/**
 *  动画开始代理
 *
 *  @param anim anim description
 */
- (void)animationDidStart:(CAAnimation *)anim
{

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

}
@end

//
//  DataViewController.m
//  TYPageTransition
//
//  Created by thomasTY on 16/11/15.
//  Copyright © 2016年 thomasTY. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UILabel * pageLabel;
@end

@implementation DataViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupUI];
    }
    return self;
}
#pragma mark - 搭建界面
- (void)setupUI
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 20, self.view.bounds.size.height - 30, 40, 20)];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_pageLabel];
    
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, self.view.bounds.size.width-40, self.view.bounds.size.height-80)];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 70, 10, 100, 20)];
    _label.textAlignment = NSTextAlignmentCenter;
    [containerView addSubview:_label];
}

- (void)setDataObject:(NSString *)dataObject
{
    _dataObject = dataObject;
    _label.text = dataObject;
}

-(void)setPageNum:(NSUInteger)pageNum
{
    _pageNum = pageNum;
    _pageLabel.text = @(pageNum).description;
}

@end

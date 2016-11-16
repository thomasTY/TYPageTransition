//
//  ViewController.m
//  TYPageTransition
//
//  Created by thomasTY on 16/11/15.
//  Copyright © 2016年 thomasTY. All rights reserved.
//

#import "RootViewController.h"
#import "DataViewController.h"
@interface RootViewController()<UIPageViewControllerDataSource>
///数据展示控制器
@property(nonatomic,strong)DataViewController * dataViewController;
///翻页控制器
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation RootViewController
{
    //数据
    NSArray * _pageData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pageData = [self loadData];

    //初始化页面控制器
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //设置数据
    DataViewController * startingViewController = [self viewControllerAtIndex:0];
    NSArray * viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    //代理
    self.pageViewController.dataSource = self;
    
    //容器视图
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.pageViewController.view.frame = self.view.bounds;
}
#pragma mark - 加载数据
- (NSArray *)loadData
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSArray * array = [dateFormatter.monthSymbols copy];
    return array;
}
#pragma mark - 根据下标创建控制器
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index
{
    //月份数据不存在或越界，不再执行
    if (([_pageData count] == 0) || (index == NSNotFound))
    {
        return nil;
    }
    _dataViewController = [DataViewController new];
    _dataViewController.dataObject = _pageData[index];
    _dataViewController.pageNum = index + 1;
    return _dataViewController;
}
#pragma mark - 根据控制器拿到下标
- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    return [_pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source
//MARK: - 必须实现的代理方法之一，前一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index --;
    return [self viewControllerAtIndex:index];
}
//MARK: - 必须实现的代理方法之二，下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    
    if (index == [_pageData count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end

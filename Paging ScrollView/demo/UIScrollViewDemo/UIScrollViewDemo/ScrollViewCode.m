//
//  ScrollViewCode.m
//  UIScrollViewDemo
//
//  Created by Tin Blanc on 4/14/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "ScrollViewCode.h"

@interface ScrollViewCode() <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView* scrollView;
@end

@implementation ScrollViewCode
{
    UIImageView* photo;
    UILabel* titleLabel;
    
    UIToolbar* toolbar;
    UISlider* slider;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Add tool bar
    toolbar = [UIToolbar new];
    [toolbar sizeToFit];

    slider = [[UISlider alloc] initWithFrame:CGRectMake(8, 0, self.view.bounds.size.width - 16 , 40)];
    slider.minimumValue = 0.2;
    slider.maximumValue = 5.0;
    slider.value = slider.minimumValue;
    [slider addTarget:self
               action:@selector(onSliderChange:)
     forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:slider];
    
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;

    toolbar.items = @[barButton];
    toolbar.frame = CGRectMake(0,statusNavigationBarHeight, toolbar.bounds.size.width, toolbar.bounds.size.height);
    [self.view addSubview:toolbar];
    
    
    
    
    CGRect scrollRect = CGRectMake(0, statusNavigationBarHeight + toolbar.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - toolbar.bounds.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollRect];
    photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"galaxy1.jpg"]];
    [self.scrollView addSubview:photo];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = slider.minimumValue;
    self.scrollView.maximumZoomScale = slider.maximumValue;
    self.scrollView.zoomScale = slider.value;
    [self.view addSubview:self.scrollView];
    
    
    // Add Label to UINavigationBar
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    titleLabel.text =[NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale] ;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    
    
}

-(void ) onSliderChange: (UISlider*) sender {
    [self.scrollView setZoomScale:sender.value animated:true];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return photo;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
    titleLabel.text =[NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale] ;
    
    slider.value = self.scrollView.zoomScale ;
}

@end

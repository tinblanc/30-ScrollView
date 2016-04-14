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
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds]; // full màn hình
    photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"galaxy1.jpg"]];
    [self.scrollView addSubview:photo];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 4.0;
    [self.view addSubview:self.scrollView];
    
    
    // Add Label to UINavigationBar
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    titleLabel.text =[NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale] ;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return photo;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
    titleLabel.text =[NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale] ;
}

@end

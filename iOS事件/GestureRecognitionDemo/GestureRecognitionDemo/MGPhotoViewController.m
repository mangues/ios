//
//  MGPhotoViewController.m
//  GestureRecognitionDemo
//
//  Created by TTS on 15/8/10.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "MGPhotoViewController.h"
#import "MGImageViewController.h"
#define kImageCount 3
@interface MGPhotoViewController ()<UIGestureRecognizerDelegate>{
    UIImageView *_imageView;  //图片展示工具
    int _currentIndex;   //当前图片索引
}


@end

@implementation MGPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    [self addGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark 布局
- (void) initLayout{
    //添加图片控件
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat topPadding = 20;
    CGFloat y = 22 + 44 + topPadding, height = screenSize.height - y -topPadding;
    
    CGRect imageFrame = CGRectMake(0, y, screenSize.width, 300);
    _imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    _imageView.contentMode = UIViewContentModeScaleToFill;   //设置内容模式为缩放填充
    _imageView.userInteractionEnabled = YES;//这里必须设置YES，否则无法接接收手势操作
    //_imageView.multipleTouchEnabled = YES;   //支持多点触控，默认支持多点触控
    [self.view addSubview:_imageView];
    
    //添加默认图片
    UIImage *image = [UIImage imageNamed:@"0.jpg"];
    _imageView.image = image;
    [self showPhotoName];
    
 
//    self.view.tag=100;
    _imageView.tag=100;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 320, 21)];
    lbl.text = @"hello";
    lbl.userInteractionEnabled = YES;
    [self.view addSubview:lbl];
    lbl.tag = 200;
    
    UILongPressGestureRecognizer *klabLongPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
    klabLongPressGesture.delegate= self;
    [lbl addGestureRecognizer:klabLongPressGesture];
    
    
    /*演示不同视图的手势同时执行
     *在上面_imageView已经添加了长按手势，这里给视图控制器的视图也加上长按手势让两者都执行
     *
     */
    UILongPressGestureRecognizer *viewLongPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressColler:)];
    viewLongPressGesture.delegate= self;
   [self.view addGestureRecognizer:viewLongPressGesture];
}


#pragma mark 添加手势
- (void) addGesture{

    /****添加点按手势***/
    //创建手势对象
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    tapGesture.numberOfTapsRequired = 2; //设置点按次数，默认为1，注意ios中很少用双击操作
    tapGesture.numberOfTouchesRequired = 2; //点按的手指数

    //添加手势对象（注意，这里添加到了控制器视图中，而不是图片上，否则点击空白无法隐藏导航栏）
    [self.view addGestureRecognizer:tapGesture];
    
    
    /*****添加长按手势******/
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5 ;//设置长按时间，一般不要是修改
    //注意由于我们要做长按提示删除操作，因此这个手势不在添加到控制器视图上而是添加到图片上
    [_imageView addGestureRecognizer:longPressGesture];
    
    
    /****添加捏合手势********/
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    [self.view addGestureRecognizer:pinchGesture];
    

    /*添加旋转手势*/
    UIRotationGestureRecognizer *rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    
    /**添加拖动手势****/
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    [_imageView addGestureRecognizer:panGesture];
    
    /*添加轻扫手势*/
    //注意一个轻扫手势只能控制一个方向，默认向右，通过direction进行方向控制
    UISwipeGestureRecognizer *swipeGestureToRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    //swipeGestureToRight.direction=UISwipeGestureRecognizerDirectionRight;//默认为向右轻扫
    [self.view addGestureRecognizer:swipeGestureToRight];
    
    UISwipeGestureRecognizer *swipeGestureToLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeGestureToLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureToLeft];
    
    
    
    
    
    //解决手势冲突
    //长按效果要在 拖动事件失败后执行
     [longPressGesture requireGestureRecognizerToFail:panGesture];
    //拖动事件 要在轻扫效果失败后执行
    [panGesture requireGestureRecognizerToFail:swipeGestureToLeft];
    [panGesture requireGestureRecognizerToFail: swipeGestureToRight];
}

#pragma mark - 手势操作
#pragma mark 点按隐藏或显示导航栏
- (void) tapImage:(UITapGestureRecognizer *)gesture{
   
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
    
    
}

#pragma mark 显示图片名称
- (void) showPhotoName{
    NSString *title = [NSString stringWithFormat:@"%i.jpg",_currentIndex];
    [self setTitle:title];
    
    
    
}


#pragma mark 长按提示是否删除
- (void) longPressImage:(UILongPressGestureRecognizer *)gesture{
    UIImageView *imageView;
    NSInteger tag = gesture.view.tag;
    switch (tag) {
        case 100:
        {
            //NSLog(@"longpress:%i",gesture.state);
            //注意其实在手势里面有一个view属性可以获取点按的视图
            imageView =(UIImageView *)gesture.view;
            MGImageViewController *coller = [[MGImageViewController alloc] init];
            coller.image = imageView.image;
            [self presentViewController:coller animated:YES completion:nil];
            break;
        }
        case 200:
        {
             NSLog(@"view long press!");//控制器视图的长按手势
            break;
        }
        default:
            break;
    }
}


#pragma mark 捏合是缩放图片
- (void) pinchImage:(UIPinchGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //捏合手势中scale属性记录的缩放比例
        _imageView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }else if(gesture.state==UIGestureRecognizerStateEnded){//结束后恢复
        [UIView animateWithDuration:.5 animations:^{
            _imageView.transform=CGAffineTransformIdentity;//取消一切形变
        }];
    }
    
}

#pragma mark 旋转图片
-(void)rotateImage:(UIRotationGestureRecognizer *)gesture{
    //NSLog(@"rotate:%i",gesture.state);
    if (gesture.state==UIGestureRecognizerStateChanged) {
        //旋转手势中rotation属性记录了旋转弧度
        _imageView.transform=CGAffineTransformMakeRotation(gesture.rotation);
    }else if(gesture.state==UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.8 animations:^{
            _imageView.transform=CGAffineTransformIdentity;//取消形变
        }];
    }
}

#pragma mark 拖动图片
- (void) panImage:(UIPanGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateChanged){
           CGPoint translation=[gesture translationInView:self.view];//利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动
        _imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    }else if(gesture.state == UIGestureRecognizerStateEnded){
        _imageView.transform = CGAffineTransformIdentity;
    }
    
}





#pragma mark 下一张图片
-(void)nextImage{
    int index=(_currentIndex+kImageCount+1)%kImageCount;
    NSString *imageName=[NSString stringWithFormat:@"%i.jpg",index];
    _imageView.image=[UIImage imageNamed:imageName];
    _currentIndex=index;
    [self showPhotoName];
}

#pragma mark 上一张图片
-(void)lastImage{
    int index=(_currentIndex+kImageCount-1)%kImageCount;
    NSString *imageName=[NSString stringWithFormat:@"%i.jpg",index];
    _imageView.image=[UIImage imageNamed:imageName];
    _currentIndex=index;
    [self showPhotoName];
}

#pragma mark 轻扫则查看下一张或上一张
//注意虽然轻扫手势是连续手势，但是只有在识别结束才会触发，不用判断状态
-(void)swipeImage:(UISwipeGestureRecognizer *)gesture{
    //    NSLog(@"swip:%i",gesture.state);
    //    if (gesture.state==UIGestureRecognizerStateEnded) {
    
    //direction记录的轻扫的方向
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {//向右
        [self nextImage];
        //            NSLog(@"right");
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionLeft){//向左
        //            NSLog(@"left");
        [self lastImage];
    }
    //    }
}



#pragma mark 控制器视图的长按手势
-(void)longPressColler:(UILongPressGestureRecognizer *)gesture{
    NSLog(@"view long press!");
}


#pragma mark 手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //NSLog(@"%i,%i",gestureRecognizer.view.tag,otherGestureRecognizer.view.tag);
    
    //注意，这里控制只有在UIImageView中才能向下传播，其他情况不允许
    if ([otherGestureRecognizer.view isKindOfClass:[UIImageView class]]) {
        return YES;
    }
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

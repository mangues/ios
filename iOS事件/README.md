#iOS开发系列--触摸事件、手势识别、摇晃事件、耳机线控

在iOS中事件分为三类：

    触摸事件：通过触摸、手势进行触发（例如手指点击、缩放）
    运动事件：通过加速器进行触发（例如手机晃动）
    远程控制事件：通过其他远程设备触发（例如耳机控制按钮）



在iOS中并不是所有的类都能处理接收并事件，只有继承自UIResponder类的对象才能处理事件（如我们常用的UIView、UIViewController、UIApplication都继承自UIResponder，它们都能接收并处理事件）。在UIResponder中定义了上面三类事件相关的处理方法：
事件 	说明
触摸事件 	 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event; 	一根或多根手指开始触摸屏幕时执行；
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event; 	一根或多根手指在屏幕上移动时执行，注意此方法在移动过程中会重复调用；
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event; 	一根或多根手指触摸结束离开屏幕时执行；
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event; 	触摸意外取消时执行（例如正在触摸时打入电话）；
运动事件 	 
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0); 	运动开始时执行；
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0); 	运动结束后执行；
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0); 	运动被意外取消时执行；
远程控制事件 	 
- (void)remoteControlReceivedWithEvent:(UIEvent *)event NS_AVAILABLE_IOS(4_0); 	接收到远程控制消息时执行；
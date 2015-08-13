//
//  AppDelegate.m
//  LocationNotification
//
//  Created by TTS on 15/8/13.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

   int i = 0;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self addLocationNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    }
    
    
    //接收通知参数
    UILocalNotification *notification = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    NSDictionary *userInfo = notification.userInfo;
    //这个参数意思是如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.如果为NO,则直接写入目标文件里.
    [userInfo writeToFile:@"/Users/kenshincui/Desktop/didFinishLaunchingWithOptions.txt" atomically:YES];
    NSLog(@"didFinishLaunchingWithOptions:The userInfo is %@.",userInfo);
    
    
    
    
    
    
    
    return YES;
}
#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
//注意这个方法只有在程序启动之后才会执行，因此当程序处于后台时，该方法不会执行。
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if(notificationSettings.types!=UIUserNotificationTypeNone){
        [self addLocationNotification];
    }
    
}

#pragma mark 接收本地通知时触发
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSDictionary *userInfo=notification.userInfo;
    [userInfo writeToFile:@"/Users/tts/Desktop/didReceiveLocalNotification.txt" atomically:YES];
    NSLog(@"didReceiveLocalNotification:The userInfo is %@",userInfo);
}



#pragma mark 添加本地通知
-(void)addLocationNotification{
    //定义本地通知对象
    UILocalNotification *notificaiton = [[UILocalNotification alloc] init];
    //设置调用时间
    notificaiton.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
    notificaiton.repeatInterval = 2; //通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
 
    //设置通知属性
    notificaiton.alertBody = @"最近添加了诸多有趣的特性，是否立即体验";
    notificaiton.applicationIconBadgeNumber = ++i; //应用程序右上角显示消息数
    notificaiton.alertAction = @"打开应用";//待机界面的滑动动作提示
    notificaiton.alertLaunchImage = @"micro_messenger"; //通过点击通知打开应用的启动图片
    notificaiton.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
      //notificaiton.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    //设置用户信息
    notificaiton.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notificaiton];
    
    
    
}

#pragma mark移除本地通知，在不需要时此通知要记得移除
//有一点需要注意，如果我们的应用程序给系统发送的本地通知是周期性的，那么即使把程序删了重装，之前的本地通知在重装时依然存在（没有从系统中移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
#pragma mark 进入前台后设置消息信息
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //应用上的标号
   [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

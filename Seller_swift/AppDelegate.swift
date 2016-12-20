//
//  AppDelegate.swift
//  Seller_swift
//
//  Created by fanpeng on 16/10/12.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         总结：
         1：1：window为可选类型，可选类型的定义：var window: UIWindow?，可选类型就是可以为空值nil或是有值，若是想获得可选类型的值，则可以进行可选绑定或是强制解包，若是强制解包必须要保证强制解包的值不为nil，若为nil会产生崩溃，一般可选绑定用guard else进行校验（let会自动解包） 
            2：var window: UIWindow?，为该类的属性，定义属性的时候，必须保证属性有初始化值，或是定义成可选类型，否则会报错
         2：需要自己去创建window：创建对象就用构造函数：RHTabBarViewController()，获得实例对象之后，调用方法可以使用点语法window?.makeKeyAndVisible()
       
         window = UIWindow(frame:UIScreen.main.bounds)
         window?.rootViewController = RHTabBarViewController()
         window?.makeKeyAndVisible()
         
         4：设置全局的函数，或是全局的样式，都在AppDelegate文件中去设置
         */
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = CustomTabBarController()
        let loginSB = UIStoryboard.init(name: "Login", bundle: Bundle.main)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNav")
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
  
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

//MARK:-3:定义全局的DLog:使用全局函数：传默认参数
/*
 总结：1：设置全局函数都在AppDelegate中进行设置，class 类声明之后
 
 2： 自定义Log： 定义Log 1. 定义Log的打印内容
 获取所在的文件 #FILE 获取所在的方法 #FUNCTION 获取所在的行 #LINE
 默认参数：当在方法中传参数时，也可以传入默认参数，定义：file : String = #file，默认参数在外界传递参数的时候不会显示
 全局函数：在AppDelegate中定义全局函数：<T>表示泛型，传打印内容：func DLog<T> (message: T,fileName:String = #file,funcName:String = #function,lineNum:Int = #line) 2.DLog在Debug下 打印,在release下 不打印
 定义标记项 —>buildSettings—>搜索swift flag—>Debug -> -D DEBUG 做标记--------在项目中实现：#if DEBUG    #endif
 
 3：1：#if DEBUG  //DEBUG模式下
 
 let file = (fileName as NSString).lastPathComponent;
 
 print("\(file):\(funcName):\(lineNum):\("打印内容"):\(message)")
 
 #endif
 
 2：let file = (fileName as NSString).lastPathComponent;获取文件的扩展名，(fileName as NSString)将swift的字符串转为OC字符串，并调用OC的方法，关键字as，在截取字符串的时候也通常将swift的字符串转为OC字符串来进行截取
 3： print("\(file):\(funcName):\(lineNum):\("打印内容"):\(message)")：插值运算:插值运算"\()"来表示。
 
 */

func DLog<T> (message: T,fileName:String = #file,funcName:String = #function,lineNum:Int = #line) {
    
    #if DEBUG
        
        let file = (fileName as NSString).lastPathComponent;
        
        print("\(file):\(funcName):\(lineNum):\("打印内容"):\(message)")
        
    #endif
    
}

//
//  ViewController.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor=UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        
        
        let w:CGFloat=0.95*view.frame.width
        let h:CGFloat=0.8*w
        
        
       //Get fake data:(
       var data = [[String:Any]]()
       var data2 = [[String:Any]]()
       var data3 = [[String:Any]]()
 
       let test = Tests()
      
 
 
        data = test.getSingleSetOfData(intervals: 10, numberElements: 20, max: 20)
        data2 = test.getMarkes(data: data)
        data3 = test.getBars(data: data)
        
        
        print(data3)
        
 
        //add curve view (not curve)
        let size = CGRect(x: 10, y: 80, width: w, height: h)
        let curve = Curve(frame: size)
        self.view.addSubview(curve)
        

        
        curve.title="Garden Sensor"
        curve.font="LucidaGrande-Bold"
        
        let orangeColor=UIColor(red: 253.0/255.0, green:173.0/255.0, blue:76.0/255.0, alpha: 0.8)
        let orangeLine=UIColor(red: 253.0/255.0, green:173.0/255.0, blue:76.0/255.0, alpha: 1.0)
        let blueColor=UIColor(red: 40.0/255.0, green:200.0/255.0, blue:180.0/255.0, alpha: 0.8)
        let blueLine=UIColor(red: 40.0/255.0, green:200.0/255.0, blue:180.0/255.0, alpha: 1.0)


        curve.addNewCurve(name: "Garden", data: data, fillColor:orangeColor ,lineColor:orangeLine ,animation:"bottom" )
        curve.addNewCurve(name: "Mark", data: data2, fillColor:UIColor.red,lineColor:UIColor.red ,animation:"mark" )
        curve.addNewCurve(name: "bar", data: data3, fillColor:blueLine,lineColor:blueLine ,animation:"bars" )

        //curve.addNewCurve(name: "Sex", data: data3, fillColor:yellowColor,lineColor:yellowColor ,animation:"bottom" )
        

        //curve.addNewCurve(name: "Sex", data: data3, fillColor:yellowColor,lineColor:yellowColor ,animation:"bottom" )
        //curve.addNewCurve(name: "main2", data: data2, fillColor:UIColor.clear,lineColor:UIColor(red: 0.99, green: 0.0, blue: 0.2, alpha: 1.0),animation:"left" )
        
 
        
     }


}


 

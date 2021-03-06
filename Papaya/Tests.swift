//
//  File.swift
//  Papaya
//
//  Created by ran T on 05/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit

class Tests {


    
    func getSquareWaveData(intervals:Int, numberElements:Int, max:Int)->[[String:Any]]
    {
        
        //fake data
        var data = [[String:Any]]()
        let dateCount=numberElements
        let dataArray:[CGFloat]=[2,2,4,4,6,6,8,8,6,6,4,4,2,2,4,4,6,6,8,8,25,15,1,1,5,5,9,9,2,2]
        
        for i in 0..<dataArray.count
        {
            //date
            let current = Date()
            let date = current.addingTimeInterval(Double(-intervals * (dateCount-i)) * 60.0)
            
            //value
            var random:CGFloat = 0
            random = dataArray[i]
            
            
            
            
            
            //add
            var pair1 =  [String:Any]()
            pair1["date"]=date
            pair1["value"]=random
            data.append(pair1)
            
        }
        
        return data
    }
    
    
    func getSingleSetOfData(intervals:Int, numberElements:Int, max:Int)->[[String:Any]]
    {
        
        //fake data
        var data = [[String:Any]]()
        let dateCount=numberElements
        
        for i in 0..<dateCount
        {
            //date
            let current = Date()
            let date = current.addingTimeInterval(Double(-intervals * (dateCount-i)) * 60.0)
            
            //value
            let random:CGFloat =  0+CGFloat(arc4random()%UInt32(max))//   CGFloat(  Double(sin(sinus)) * Double.pi / 180   ) //1.0+CGFloat(arc4random()%20)
            
            
 
            //add
            var pair1 =  [String:Any]()
            pair1["date"]=date
            pair1["value"]=random
            data.append(pair1)
            
         
        }
        
        return data

    }
    
    
    func getSingleValue(value:CGFloat)->[[String:Any]]
    {
        
        //date
        let current = Date()
        let date = current.addingTimeInterval(Double(-5  * 60.0))
        
        
        //add
        var data = [[String:Any]]()
        var pair1 =  [String:Any]()
        pair1["date"]=date
        pair1["value"]=value
        data.append(pair1)
        return data
        
    }
    
    
    
    func getAverageForData(data:[[String:Any]],parameter:Int)->[[String:Any]]
    {
        var rdata = [[String:Any]]()

        for i in 0..<data.count
        {
            
            
            var av:CGFloat = 0
            var count:CGFloat=1
            let to = max(0, i-parameter)
            for index in stride(from: i, to: to, by: -1)
            
            {
                if(i<0){break}
                let pair = data[index]
                let value:CGFloat=pair["value"] as! CGFloat
                av=av+value
                
                count+=1
                if (Int(count)==parameter){break}
                
            }
            av=av/count
 
            var pair2 =  [String:Any]()
            pair2["date"]=data[i]["date"]
            pair2["value"]=av
            rdata.append(pair2)
           

            
        }
        
       return rdata
    }
    
    
    
    
    
    
    func getMarkes(data:[[String:Any]])->[[String:Any]]
    {
        var finaldata = [[String:Any]]()
        
        
           //mark between point 1-2
            
            let lastElement = data.count-1
        
            finaldata.append(data[lastElement-3])
            finaldata.append(data[lastElement-2])
            finaldata.append(data[lastElement-1])
            finaldata.append(data[lastElement])
 
        
        return finaldata
        
 
    }
    
    
    
    func getBars(data:[[String:Any]])->[[String:Any]]
    {
        
        var finaldata = [[String:Any]]()
        
        let numGroups = 3
        var count = 0
        
        while (count < data.count-numGroups)
        {
            var lastMax:CGFloat = -10000000
            var lastMin:CGFloat = 10000000
            var date:Date=Date()
            for index in count..<count+numGroups
            {
                
                let pair = data[index]
                let value:CGFloat=pair["value"] as! CGFloat
                date=pair["date"] as! Date
                
                if(value>lastMax){lastMax=value}
                if(value<lastMin){lastMin=value}

                
            }
 
            finaldata.append(["date":date,"value":lastMin])
            finaldata.append(["date":date,"value":lastMax])
            
            count+=numGroups
        }
        
        return finaldata
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



}

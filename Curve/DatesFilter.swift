//
//  DatesFilter.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit


class DatesFilter {
    
    
    
    
 
    
    
    
    
    
    
    
    // ** graph values
    
    
    //return  numbers 0-1 which relative to the whole time span, so  for 8-10am, 9am is 0.5
    func getRelativeTime(resolutionMin:Int,withDate:Date, endDate:Date, maxXValues:Int, scrollingScreens:Int)->CGFloat
    {
        //calculate in seconds resolution
        
        let timeSpanSec:CGFloat  = 60.0*CGFloat(resolutionMin)
     
  
      //using extension class for Date
        let delta:Int = withDate.seconds(from: self.getOpenTime(resolutionMin: resolutionMin, endDate: endDate, maxXValues:maxXValues))
 
        
            if ( delta >= 0 )
            {
                let relative = CGFloat(delta) / timeSpanSec
                return relative
        
            }
        return -1

  
        
        
    }
    
    

    
    
    
    
    //**axis
    
    
    
    
    
    //1. get pairs of a string date and a relative location inside the span(resolution)
    func getStringDateAndLocation(endDate:Date, resolution:Int, maximumValues:Int, scrollingScreens:Int)->[[String:CGFloat]]
    {
        
        var finalArray = [[String:CGFloat]]()
        
        for date in self.getListOfRoundedDates(endDate: endDate, resolution: resolution, maximumValues: maximumValues,scrollingScreens:scrollingScreens )
        {
            
            
            let dateString = getDateAsString(forDate: date, resolution: resolution,scrollingScreens: scrollingScreens)
            
            //get date location on screen
            let relativeTime=self.getRelativeTime(resolutionMin: resolution, withDate: date, endDate: endDate, maxXValues: maximumValues,scrollingScreens: scrollingScreens)
            
            
            finalArray.append([dateString:relativeTime])
        }
        
        
        return finalArray
        
    }
    
    
    
    
    //2. get list of dates by resolution , time divider, and number of values to show on axis (with rounded minutes)
    func getListOfRoundedDates(endDate:Date, resolution:Int, maximumValues:Int, scrollingScreens:Int)->[Date]
    {
        
        
        var finalDates = [Date]()
        let openDate = self.getOpenTime(resolutionMin: resolution,endDate: endDate, maxXValues:maximumValues )
        var nextDate = openDate
        let timeDividerMinutes = getTimeDivider(resolution:resolution, maximumValues:maximumValues,scrollingScreens: scrollingScreens)
 
        //run on each date from the first one, and add the timedivider to get array of dates
        //add relevant dates when they are rounded by minute - to final array
        //stop when added date is larger than now
       
         finalDates.append(openDate)
        
  
        
        //if date is not later than now
        while (nextDate < endDate)
        {
            //add time interval to get a new date
             nextDate=self.getDateInterval(forDate: nextDate, minutes: timeDividerMinutes)
             finalDates.append(nextDate)
        }
        return finalDates
        
        
    }
    
    
    //2(1) every how many minutes - we  jump (show a label) since the starting date of the resolution to end date
    func getTimeDivider(resolution:Int, maximumValues:Int, scrollingScreens:Int)->Int
    {
        let defaultDistance:Int = maximumValues
        
        //1H / MINUTES
        if(resolution<=60*scrollingScreens){return (resolution/scrollingScreens)/defaultDistance}
            //1D
        else if (resolution <= 60*24*scrollingScreens) { return 60*4}
            //3D, 5D
        else if (resolution <= 60*24*5*scrollingScreens) { return 60*24}
            //1M
        else if (resolution <= 60*24*31*scrollingScreens) { return 60*24*7}
            //1Y
        else if (resolution <= 60*24*31*12*scrollingScreens) { return 60*24*31}
        
        
        return resolution/defaultDistance
    }
    

    
    /*
    //2(2) round down a date's minutes by our resolution and maximum labels allowed to show
    func getRoundedDate(date:Date,resolution:Int, maxXValues:Int, scrollingScreens:Int)->Date
    {
        //round up the minutes by relationship between resolution(span) and number of values to show
        let roundMinutesBy:Int = (resolution/scrollingScreens)/maxXValues
        //less than a minute jumps is not allowed
        if(roundMinutesBy == 0){return Date()}
        
        
        
        //read components to calculate the rounding
        let min = Calendar.current.component(.minute, from: date)
        let hour = Calendar.current.component(.hour, from: date)
        let rounded:Int = (min)/roundMinutesBy*roundMinutesBy //(min+roundMinutesBy-1)/roundMinutesBy*roundMinutesBy
        var setMin:Int = rounded

        if(rounded >= 60) { setMin = 0  }

        
        return Calendar.current.date(bySettingHour:hour, minute: setMin, second: 0, of: date)!

    }
 */
    
    
 
    
    
    
    
    
    //**general
    
    
    func getResolutionInMin(forString:String)->Int
    {
        
     
        //10M
        if (forString == "10M") { return 24}
            //1H
        else if (forString == "1H") { return 60}
            //1D
        else if (forString == "1D") { return 60*24}
            //3D
        else if (forString == "3D") { return 60*24*3}
            //5D
        else if (forString == "5D") {return 60*24*5}
            //1M
        else if (forString == "1M") {return 60*24*31}
        
        return 24

    }
    
    func getDateAsString(forDate:Date, resolution:Int, scrollingScreens:Int)->String
    {
        
        //get date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        
        
        
        //min//hour
        if (resolution <= 60*scrollingScreens) { dateFormatter.dateFormat = "HH:mm"}
            //day
        else if (resolution <= 60*24*scrollingScreens) {dateFormatter.dateFormat = "HH:mm"}
            //3-5 days
        else if (resolution <= 60*24*5*scrollingScreens) { dateFormatter.dateFormat = "EEE"   }
            //month
        else if (resolution <= 60*24*31*scrollingScreens) { dateFormatter.dateFormat = "dd.MM" }
            //year
        else if (resolution <= 60*24*31*12*scrollingScreens) { dateFormatter.dateFormat = "MMMM" }
        
        
        let dateString = dateFormatter.string(from: forDate)
        return dateString

    }
    
    
    //return first date for a certain resolution
    func getOpenTime(resolutionMin:Int, endDate:Date, maxXValues:Int) ->Date
    {
        let calendar = Calendar.current
        let openDateForSpan:Date = calendar.date(byAdding: .minute, value:-1*resolutionMin  , to: endDate)!
        return openDateForSpan
        //return self.getRoundedDate(date: openDateForSpan, resolution: resolutionMin, maxXValues: maxXValues)
 
    }
    
    
    //return interval for a date
    func getDateInterval(forDate:Date,minutes:Int)->Date
    {
        
        return  forDate.addingTimeInterval(TimeInterval(1.0*CGFloat(minutes) * 60.0))

    }
    
   
    
    
    
    
    
    

    
    
 

    
    

}

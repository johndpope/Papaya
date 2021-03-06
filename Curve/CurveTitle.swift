//
//  CurveTitle.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class CurveTitle: UIView {
    
    //title
    var title:UILabel!
    var titleDefault = ""
    var titleDefaultFont = "Avenir-Light"
    
    
    //subtitle
    var subtitle:UILabel!
    var subtitleDefault = ""
    var subtitleDefaultFont = "Avenir-Light"
    
    
    
    

    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        let titleToSub:CGFloat = 0.66
        
        
        title=UILabel(frame: CGRect(x:0, y:0, width: self.frame.width/2.0, height: (self.frame.height)*titleToSub))
        title.text=titleDefault
        title.textAlignment = .left
        title.text=titleDefault
        title.font=UIFont(name: titleDefaultFont, size: 24)
        self.addSubview(title)
        
        
        subtitle=UILabel(frame: CGRect(x:0,y:title.frame.maxY, width: self.frame.width/2.0, height: (self.frame.height)*(1.0-titleToSub)))
        subtitle.text=subtitleDefault
        subtitle.textAlignment = .left
        subtitle.text=subtitleDefault
        subtitle.font=UIFont(name: subtitleDefaultFont, size: 12.0)
        subtitle.textColor=UIColor.black

        self.addSubview(subtitle)
        
 
    }
    
    
   
   
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}

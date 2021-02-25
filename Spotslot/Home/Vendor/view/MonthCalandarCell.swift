//
//  MonthCalandarCell.swift
//  SplotslotVendor
//
//  Created by mac on 09/09/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class MonthCalandarCell: UICollectionViewCell {
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDayText: UILabel!
    @IBOutlet weak var lblRequest: UILabel!
    @IBOutlet weak var monthYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblRequest.isHidden = true
        monthYearLabel.isHidden = true
        lblRequest.layer.cornerRadius = lblRequest.frame.height/2
        lblRequest.clipsToBounds = true
        viewDate.setViewShadow(opacity: 0.4, cRadius: 14)
    }
    
    func configure(date: Date, selectedDate: Date) {
        let components = date.get(.day, .month, .year)
        if let day = components.day, let month = components.month, let year = components.year {
            
            //print("day: \(day), month: \(month), year: \(year)")
            self.lblDate.text = String(day)
            self.lblDayText.text = date.getWeekDay()
            if String(day) == "01" || String(day) == "1" {
                monthYearLabel.isHidden = false
                monthYearLabel.text = date.getMonthAndYear()
            }else {
                monthYearLabel.isHidden = true
            }
        }
        if date == selectedDate {
            viewDate.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1)
            lblDate.textColor = UIColor.white
            lblDayText.textColor = UIColor.white
        }else {
            viewDate.backgroundColor = UIColor.white
            lblDate.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
            lblDayText.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        }
    }

}


extension Date {
    
    func getWeekDay() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "E"
        return dateformatter.string(from: self)
    }
    
    func getMonthAndYear() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM yyy"
        return dateformatter.string(from: self)
    }
    
    func getStringDate()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func removeTimeStamp() -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

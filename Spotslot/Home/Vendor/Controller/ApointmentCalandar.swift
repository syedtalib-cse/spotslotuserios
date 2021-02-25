//
//  ApointmentCalandar.swift
//  Spotslot
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit
import FSCalendar
class ApointmentCalandar: UIViewController {

    @IBOutlet weak var fsCalander: FSCalendar!
    
    //MARK:- Class Variable of the Controller-
    private var arrOfSelectedDates = [String]()
    var selectedDate = ""
    private var selectedDatefromCalender = Date()
    
    fileprivate lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    var dicData = [String:Any]()
  
    var vendorId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fsCalander.scrollDirection = .vertical
        fsCalander.pagingEnabled = false
        fsCalander.customizeCalenderAppearance()
       
        self.fsCalander.placeholderType = .none
     // For UITest
        self.fsCalander.accessibilityIdentifier = "calendar"
    }
    
    @IBAction func btnPushToReview(_ sender: Any) {
        if selectedDate == ""{
            GlobalObj.showAlertVC(title:appName, message: "Please select appointment date", controller: self)
        }else{
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ReviewApointmentVC") as! ReviewApointmentVC
            print("Vendor ID Appointment Calander:- \(self.vendorId)")
            vc.dataDic = self.dicData
            vc.selectedDate = selectedDatefromCalender
            vc.vendorId = self.vendorId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK:- FSCalendarDataSource, FSCalendarDelegate-
extension ApointmentCalandar: FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let date = Date()
        var components = DateComponents()
        components.setValue(2, for: .month)
        let expirationDate = Calendar.current.date(byAdding: components, to: date)
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 60, to: Date())!
        return modifiedDate
    }
    // MARK:- FSCalendarDataSource
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return self.gregorian.isDateInToday(date) ? "\(Calendar.current.component(.day, from: date))": nil
    }
    
    // MARK:- FSCalendarDelegate-
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
       // self.lblCurrentMothWithYear.text = self.changeDateformat(dateString:self.formatter.string(from: calendar.currentPage) , currentFomat: "yyyy-MM-dd", expectedFromat: "MMM, yyyy")
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDatefromCalender = date
        print("calendar Selected date \(formatter.string(from: date))")
        selectedDate = formatter.string(from: date)
        dicData["appointmentDate"] = formatter.string(from: date)
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        // self.arrOfSelectedDates.append(formatter.string(from: date))
        //self.getSelectedDateCount(count: self.arrOfSelectedDates.count)
        //self.getDayNameFromDate(count: self.arrOfSelectedDates.count)
       // print(self.arrOfSelectedDates)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        print("calendar Deselected date \(self.formatter.string(from: date))")
//        let matchedDate = self.formatter.string(from: date)
//        if let index = self.arrOfSelectedDates.firstIndex(of: matchedDate) {
//            self.arrOfSelectedDates.remove(at: index)
//            self.getSelectedDateCount(count: self.arrOfSelectedDates.count)
//            self.getDayNameFromDate(count: self.arrOfSelectedDates.count)
//        }
       // print(self.arrOfSelectedDates)
    }
    
    /*
    It display previous month while you swipe to see previous month, This solution consider current date as past date because there's time difference) */
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        if date .compare(Date()) == .orderedAscending {
//            return true
//        }else {
//            return true
//        }
//    }
    
    //Change Past dates title. Color
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        if date.compare(Date()) == .orderedAscending {
//             return #colorLiteral(red: 0.004608990159, green: 0.7726951241, blue: 0.8249664903, alpha: 1)
//        } else if date.compare(Date()) == .orderedSame {
//            return #colorLiteral(red: 0.004608990159, green: 0.7726951241, blue: 0.8249664903, alpha: 1)
//        }
//        return #colorLiteral(red: 0.004608990159, green: 0.7726951241, blue: 0.8249664903, alpha: 1)
//    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        //self.calenderHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
} // end of the Extension



//Extension For the Calendar Customization
extension FSCalendar {
    func customizeCalenderAppearance() {
        self.appearance.headerTitleFont = UIFont.init(name:"OpenSans-Bold", size: 16)
        self.appearance.weekdayFont     = UIFont.init(name:"OpenSans-Bold", size: 16)
        self.appearance.titleFont       = UIFont.init(name:"OpenSans-Regular", size: 12)
        self.weekdayHeight = 35
        self.headerHeight = 35
        self.appearance.headerMinimumDissolvedAlpha = 0.0 // Hide Left Right Month Name
    }
    
    func customizeCalenderAppearance2() {
           self.appearance.headerTitleFont = UIFont.init(name:"OpenSans-Bold", size: 16)
           self.appearance.weekdayFont     = UIFont.init(name:"OpenSans-Bold", size: 16)
           self.appearance.titleFont       = UIFont.init(name:"OpenSans-Regular", size: 12)
           self.weekdayHeight = 25
           self.headerHeight = 30
           //self.appearance.headerMinimumDissolvedAlpha = 0.0 // Hide Left Right Month Name
       }
       
}

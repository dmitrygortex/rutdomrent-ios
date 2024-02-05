//
//  MyBookingsViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 27/01/2024.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseAuth

final class MyBookingsViewController: UIViewController {
    
    // MARK: - Properties
    
    var bookings = UserModel.bookingsModel
    
    private var viewsArray = [BookingView]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setUpConstraints()
        setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBookings()
        setUp()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Мои бронирования"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backItem?.title = "Назад"
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = AppColors.miitColor


        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private func setBookings() {
        let bookingsNumber = bookings?.count ?? 0
        
        if bookingsNumber != 0 {
            
            var mltp = 25
            var cnt = 0
            
            // MARK: Add user bookings to view
            
            for i in 0..<bookingsNumber {
                
                let view = BookingView()
                viewback.addSubview(view.mainView)
                view.setViewConstraints(multiplier: mltp)
                view.cancelButton.tag = i
                
                viewsArray.append(view)
                mltp += 189
            }
            
            // MARK: Addjust user bookings to display info
            
            for view in viewsArray {
                view.timeLabel.text = bookings![cnt].time!
                view.roomLabel.text = bookings![cnt].room!
                view.purposeLabel.text = bookings![cnt].purpose!
                let (month, year) = getYear(date: bookings![cnt].date!)
                view.yearLabel.text = String(year)
                view.monthLabel.text = String(month)
                cnt += 1
            }
            
            // MARK: Change scrollView height
            
            if bookingsNumber > 3 {
                
                let backHeight = (bookingsNumber * 164) + ((bookingsNumber + 1) * 25) - 10
                setBackHeight(multiplier: backHeight)
            } else {
                setBackHeight(multiplier: 600)
            }
            
        } else {
            
            // TODO: Check for bookings in firestore ???
            
            showEmptyLabel()
        }
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func showEmptyLabel() {
        let alert = UIAlertController(title: "Упс", message: "У вас пока нет бронирований!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Понятно", style: .cancel, handler: { action in
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.popViewController(animated: true)
            
            print("Alert successful")
        }))
        present(alert, animated: true)
    }
    
    private func setBackHeight(multiplier: Int) {
        viewback.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(multiplier)
            make.width.equalTo(self.view)
        }
    }
    
    private class BookingView {
        
        let mainView: UIView = {
            var mainView = UIView()
            mainView.backgroundColor = AppColors.backViewColor
            mainView.layer.cornerRadius = 12
            
            return mainView
        }()
        
        let lineView: UIView = {
            let line = UIView()
            line.backgroundColor = .black
            
            return line
        }()
        
        let yearLabel: UILabel = {
            let yearLabel = UILabel()
            yearLabel.text = "2024"
            yearLabel.font = .systemFont(ofSize: 18, weight: .bold)
            yearLabel.textColor = .black
            
            return yearLabel
        }()
        
        let monthLabel: UILabel = {
            let monthLabel = UILabel()
            monthLabel.text = "26 Января"
            monthLabel.font = .systemFont(ofSize: 17, weight: .bold)
            monthLabel.textColor = .black
            
            return monthLabel
        }()
        
        var timeLabel: UILabel = {
            let timeLabel = UILabel()
            timeLabel.text = "10.00-11.00"
            timeLabel.font = .systemFont(ofSize: 17, weight: .bold)
            timeLabel.textColor = .black
            
            return timeLabel
        }()
        
        let roomLabel: UILabel = {
            let roomLabel = UILabel()
            roomLabel.text = "Переговорная"
            roomLabel.font = .systemFont(ofSize: 18, weight: .bold)
            roomLabel.textColor = .black
            roomLabel.textAlignment = .center
            
            return roomLabel
        }()
        
        let purposeLabel: UILabel = {
            let purposeLabel = UILabel()
            purposeLabel.text = "Обсуждение проекта"
            purposeLabel.font = .systemFont(ofSize: 15, weight: .medium)
            purposeLabel.textColor = .black
            purposeLabel.textAlignment = .center
            purposeLabel.numberOfLines = 0
            
            return purposeLabel
        }()
        
        let cancelButton: UIButton = {
            let cancelButton = UIButton(type: .system)
            cancelButton.setTitle("Отменить бронь", for: .normal)
            cancelButton.backgroundColor = AppColors.miitColor
            cancelButton.setTitleColor(.white, for: .normal)
            cancelButton.layer.cornerRadius = 12
            cancelButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
            cancelButton.tag = 1
            
            return cancelButton
        }()
        
        func setViewConstraints(multiplier: Int) {
            [yearLabel, monthLabel, timeLabel, roomLabel, purposeLabel].forEach { mainView.addSubview($0) }
            mainView.addSubview(cancelButton)
            mainView.addSubview(lineView)
            
            mainView.snp.makeConstraints { make in
                make.top.equalTo(multiplier) // changeable only
                make.leading.equalTo(21)
                make.height.equalTo(164)
                make.width.equalTo(334)
            }
            
            yearLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(23)
                make.leading.equalToSuperview().inset(34)
                make.height.equalTo(35)
                make.width.equalTo(85)
            }
            
            monthLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(39)
                make.leading.equalToSuperview().inset(12)
                make.height.equalTo(50)
                make.width.equalTo(104)
            }
            
            timeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(100)
                make.leading.equalToSuperview().inset(12)
                make.height.equalTo(35)
                make.width.equalTo(100)
            }
            
            roomLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(8)
                make.leading.equalToSuperview().inset(135)
                make.height.equalTo(34)
                make.width.equalTo(180)
            }
            
            purposeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(40)
                make.leading.equalToSuperview().inset(135)
                make.height.equalTo(48)
                make.width.equalTo(180)
            }
            
            cancelButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(103)
                make.leading.equalToSuperview().inset(140)
                make.height.equalTo(46)
                make.width.equalTo(180)
            }
            
            lineView.snp.makeConstraints { make in
                make.width.equalTo(1)
                make.height.equalTo(134)
                make.leading.equalTo(127)
                make.top.equalTo(15)
                make.bottom.equalTo(-15)
            }
        }
        
    }
    
    private func getYear(date: String) -> (String, Int) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "d.M.yyyy"

        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            
            if let day = components.day,
               let month = components.month,
               let year = components.year {
                
                let monthWithDay = getMonth((day, month))
                
                return (monthWithDay, year)
            } else {
                print("Unable to convert the string to a date.")
            }
        }
        return ("", 0)
    }
    
    private func getMonth(_ tuple: (day: Int, month: Int)) -> String {
        let months = [1 : "Января", 2 : "Февраля", 3 : "Марта", 4 : "Апреля", 5 : "Мая", 6 : "Июня", 7 : "Июля", 8 : "Августа", 9 : "Сентября", 10 : "Октября", 11 : "Ноября", 12 : "Декабря"]
        
        let result = String(tuple.day) + " " + months[tuple.month]!
        
        return result
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        
        let bookingToDelete = bookings![sender.tag]
        let view = viewsArray[sender.tag]
        
        let room = bookingToDelete.room!
        let date = bookingToDelete.date!
        let time = bookingToDelete.time!
        
        // MARK: Delete booking from Firestore booking collection
        
        deleteBooking(room: room, date: date, time: time)
        
        // MARK: Delete booking from users collection
        
        deleteUserBooking(room: room, date: date, time: time)
        
        // MARK: Delete booking from UserDefaults
        
        UserModel.deleteBooking(booking: bookingToDelete)
        
        print("Bookings successfully deleted: \(date) \(time) \(room)")
        
        let alert = Validate.showAlert(title: "Готово", message: "Вы успешно отменили бронирование!")
        present(alert, animated: true)
        
        viewsArray.forEach { view in
            view.mainView.removeFromSuperview()
        }
        
        self.bookings = UserModel.bookingsModel
        self.viewsArray = []
        setBookings()
    }
    
    private func deleteBooking(room: String, date: String, time: String) {
        let documentRef = Firestore.firestore().collection(room).document(date)
                        
        documentRef.getDocument { document, error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                if var data = document?.data() {
                    data[time] = nil
                                    
                    documentRef.setData(data)
                    
                }
            }
        }
    }
    
    private func deleteUserBooking(room: String, date: String, time: String) {
        let uid = Auth.auth().currentUser?.uid
        let documentRef = Firestore.firestore().collection("users").document(uid!)
        var updatedBooking = [[String: Any]]()
        
        documentRef.getDocument { document, error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                if let data = document?.data() {
                    let bookings = data["bookings"] as! [[String: Any]]
                    for booking in bookings {
                        if booking["date"]! as! String == date && booking["time"]! as! String == time && booking["room"]! as! String == room {
                            continue
                        } else {
                            updatedBooking.append(booking)
                        }
                    }
                    documentRef.updateData(["bookings": updatedBooking])
                }
            }
        }
    }
    
}

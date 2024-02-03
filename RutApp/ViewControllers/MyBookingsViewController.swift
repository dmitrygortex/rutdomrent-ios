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
        setBookings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Мои бронирования"
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.backButtonTitle = "Назад"
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = AppColors.miitColor


        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private func setBookings() {
        let bookingsNumber = UserModel.bookingsModel.count
        let bookings = UserModel.bookingsModel
        
        if bookingsNumber != 0 {
            var viewsArray = [BookingView]()
            var mltp = 25
            var cnt = 0
            
            for booking in 0..<bookingsNumber {
                
                let view = BookingView()
                viewback.addSubview(view.mainView)
                view.setViewConstraints(multiplier: mltp)
                viewsArray.append(view)
                mltp += 189
            }
            
            for view in viewsArray {
                view.timeLabel.text = bookings![cnt].time!
                view.roomLabel.text = bookings![cnt].room!
                view.purposeLabel.text = bookings![cnt].purpose!
                let (month, year) = getYear(date: bookings![cnt].date!)
                view.yearLabel.text = String(year)
                view.monthLabel.text = String(month)
                cnt += 1
            }
            
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
        
        viewback.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(930)
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
                make.top.equalTo(multiplier)
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
                make.leading.equalTo(120)
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
        
        var result = String(tuple.day) + " " + months[tuple.month]!
        
        return result
    }
    
    @objc func cancelButtonTapped() {
        // TODO: Delete booking
        
        print("cancelBookingButtonTapped tapped")
    }
}

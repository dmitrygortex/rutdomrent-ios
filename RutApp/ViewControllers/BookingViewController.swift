//
//  BookingViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class BookingViewController: UIViewController, UICalendarViewDelegate {
    
    //MARK: -Properties
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Бронирование"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.miitColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var calendar: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 12
        calendarView.delegate = self
        calendarView.backgroundColor = AppColors.miitColor
        
        return calendarView
    }()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(titlelabel)
        view.addSubview(calendar)
    }
    
    private func setUpConstraints() {
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(370)
            make.leading.equalTo(75)
            make.top.equalToSuperview().inset(35)
        }
        
        calendar.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.width.equalTo(414)
            make.top.equalToSuperview().inset(106)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}

//
//  BookingView.swift
//  RutApp
//
//  Created by Michael Kivo on 01/02/2024.
//

import UIKit
import SnapKit

class BookingView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        [yearLabel, monthLabel, timeLabel, roomLabel, purposeLabel].forEach { mainView.addSubview($0) }
        mainView.addSubview(cancelBookingButton)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = AppColors.backViewColor
        mainView.layer.cornerRadius = 12
        
        let image = UIImageView(image: .init(named: "bookingView"))
        mainView.addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        mainView.sendSubviewToBack(image)
        //viewback.addSubview(mainView)
        
        return mainView
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
    
    let timeLabel: UILabel = {
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
        
        return roomLabel
    }()
    
    let purposeLabel: UILabel = {
        let purposeLabel = UILabel()
        purposeLabel.text = "Обсуждение проекта"
        purposeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        purposeLabel.textColor = .black
        
        
        return purposeLabel
    }()
    
    let cancelBookingButton: UIButton = {
        let cancelBookingButton = UIButton(type: .system)
        cancelBookingButton.setTitle("Отменить бронь", for: .normal)
        cancelBookingButton.backgroundColor = AppColors.miitColor
        cancelBookingButton.setTitleColor(.white, for: .normal)
        cancelBookingButton.layer.cornerRadius = 12
        cancelBookingButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        cancelBookingButton.addTarget(self, action: #selector(cancelBookingButtonTapped), for: .touchUpInside)
        cancelBookingButton.tag = 1
        
        return cancelBookingButton
    }()
    
    private func setUpConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(25)
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
            make.width.equalTo(95)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        roomLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(156)
            make.height.equalTo(34)
            make.width.equalTo(185)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.equalToSuperview().inset(144)
            make.height.equalTo(48)
            make.width.equalTo(188)
        }
        
        cancelBookingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(135)
            make.height.equalTo(46)
            make.width.equalTo(180)
        }
    }
    
    func changeTop(multiplier: Int = 25) {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(multiplier)
            make.leading.equalTo(21)
            make.height.equalTo(164)
            make.width.equalTo(334)
        }
    }
    
    @objc func cancelBookingButtonTapped() {
        print("cancelBookingButtonTapped tapped")
    }
}

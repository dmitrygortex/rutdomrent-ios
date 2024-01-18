//
//  BookingViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class BookingViewController: UIViewController {
    
    //MARK: -Properties
    
    let rooms = ["Лекторий", "Переговорная", "Фотостудия"]
    
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
    
    private lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.text = "Помещение:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "Цель посещения:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var roomPicker: UIPickerView = {
        var picker = UIPickerView()
        
        return picker
        
    }()
    
    private lazy var roomTextField: UITextField = {
        let room = UITextField()
        room.textColor = .black
        room.backgroundColor = AppColors.grayColor
        room.layer.cornerRadius = 12
        room.returnKeyType = .go
        room.inputView = roomPicker
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: room.frame.height))
        room.leftView = paddingView
        room.leftViewMode = .always
        
        return room
    }()
    
    private lazy var purposeTextField: UITextField = {
        let purpose = UITextField()
        purpose.textColor = .black
        purpose.backgroundColor = AppColors.grayColor
        purpose.layer.cornerRadius = 12
        purpose.returnKeyType = .go
        purpose.delegate = self
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: purpose.frame.height))
        purpose.leftView = paddingView
        purpose.leftViewMode = .always
        
        return purpose
    }()
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
        
        roomPicker.dataSource = self
        roomPicker.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(titlelabel)
        view.addSubview(calendar)
        [roomLabel, purposeLabel].forEach { view.addSubview($0) }
        [roomTextField, purposeTextField].forEach { view.addSubview($0) }
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
        
        roomLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(506)
        }
        
        roomTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(560)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(600)
        }
        
        purposeTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(653)
        }
    }
    
    
}

extension BookingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rooms[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roomTextField.text = rooms[row]
        roomTextField.resignFirstResponder()
    }
    
}

extension BookingViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}

extension BookingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

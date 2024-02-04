//
//  BookingViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit
import FirebaseAuth

final class BookingViewController: UIViewController {
    
    //MARK: -Properties
    
    var scheduleVC = ScheduleViewController()
    
    let rooms = ["Лекторий", "Переговорная", "Фотостудия"]
    
    var userRoom = ""
    
    var userPurpose = ""
    
    var userDate: DateComponents?
        
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Бронирование"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.miitColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var calendar: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.calendar = .current
        calendarView.calendar.firstWeekday = 2
        calendarView.locale = Locale(identifier: "ru")
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 12
        calendarView.delegate = self
        calendarView.backgroundColor = AppColors.miitColor
        calendarView.delegate = self
        calendarView.availableDateRange = DateInterval.init(start: Date.now, end: Date.distantFuture)
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection

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
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var myBookingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Мои Бронирования", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(myBookingsButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addSubviews()
        setUpConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scheduleVC.room = userRoom
        scheduleVC.date = userDate
        scheduleVC.purpose = userPurpose
    }
    
    private func setUp() {
        view.backgroundColor = .white
        
        roomPicker.dataSource = self
        roomPicker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        viewback.addSubview(titlelabel)
        viewback.addSubview(calendar)
        [continueButton, myBookingsButton].forEach { viewback.addSubview($0) }
        [roomLabel, purposeLabel].forEach { viewback.addSubview($0) }
        [roomTextField, purposeTextField].forEach { viewback.addSubview($0) }
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
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(370)
            make.leading.equalTo(75)
            make.top.equalToSuperview().inset(4)
        }
        
        calendar.snp.makeConstraints { make in
            make.height.equalTo(420)
            make.width.equalTo(414)
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        roomLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(524)
        }
        
        roomTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(578)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(618)
        }
        
        purposeTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(671)
        }
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(742)
            make.centerX.equalToSuperview()
        }
        
        myBookingsButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(315)
            make.top.equalToSuperview().inset(829)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func continueButtonTapped() {
        if roomTextField.text == "" || purposeTextField.text == "" || userDate == nil {
            let alert = Validate.showAlert(title: "Ошибка", message: "Заполните все поля")
            present(alert, animated: true)
            return
        }
        
        userRoom = roomTextField.text!
        userPurpose = purposeTextField.text!
        
        scheduleVC.room = userRoom
        scheduleVC.date = userDate
        scheduleVC.purpose = userPurpose
        
        purposeTextField.resignFirstResponder()
        
        navigationController?.pushViewController(scheduleVC, animated: true)
    }
        
    @objc private func myBookingsButtonTapped() {
        navigationController?.pushViewController(MyBookingsViewController(), animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
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

extension BookingViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let data = dateComponents else {
            print("Error on data")
            return
        }
        print("Выбранная дата: \(data)")
        self.userDate = data
    }

      
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
}

extension BookingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

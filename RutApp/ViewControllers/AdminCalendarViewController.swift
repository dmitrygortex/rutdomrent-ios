//
//  AdminCalendarViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 08/02/2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

final class AdminCalendarViewController: UIViewController {
    
    //MARK: -Properties
    
    var adminDateListVC = AdminDateListViewController()
        
    let rooms = ["Все", "Лекторий", "Переговорная", "Фотостудия"]
    
    var adminRoom = ""
        
    var adminDate: DateComponents?
    
    static let db = Firestore.firestore()
        
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Бронирования"
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
        calendarView.tintColor = .white
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
    
    private lazy var showBookings: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Показать бронирования", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(showBookingsTapped), for: .touchUpInside)
        
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
        
        adminDateListVC.date = adminDate
        adminDateListVC.room = adminRoom
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        [showBookings].forEach { viewback.addSubview($0) }
        [roomLabel].forEach { viewback.addSubview($0) }
        [roomTextField].forEach { viewback.addSubview($0) }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(780)
            make.width.equalTo(self.view)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(370)
            make.leading.equalTo(75)
            make.top.equalToSuperview().inset(4)
        }
        
        calendar.snp.makeConstraints { make in
            make.height.equalTo(440)
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        roomLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(553)
        }
        
        roomTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(598)
        }
        
        showBookings.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(315)
            make.top.equalToSuperview().inset(677)
            make.centerX.equalToSuperview()
        }
    }
        
    @objc private func showBookingsTapped() {
        
        if adminDate == nil || adminRoom == "" {
            let alert = Validate.showAlert(title: "Ошибка", message: "Выберите дату и комнату")
            present(alert, animated: true)
            return
        }
        
        // MARK: Get all bookings on data
                
        if adminRoom != "Все" {
            
            getAllBookingsFromDB(room: adminRoom)
            
        } else if adminRoom == "Все" {
            for currentRoom in ["Лекторий", "Переговорная", "Фотостудия"] {
                getAllBookingsFromDB(room: currentRoom)
            }
        }
    }
    
    private func getAllBookingsFromDB(room: String) {
        let fullDate = getFullDate()
        
        AdminCalendarViewController.db.collection(room).document(fullDate).getDocument { document, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                if let doc = document {
                    if let data = doc.data() as? [String : [String : String]] {
                        let keys = Array(data.keys)
                        
                        for time in keys {
                            let uid = data[time]!["uid"]!
                            let purpose = data[time]!["purpose"]!
                            let email = data[time]!["email"]!
                            let fio = data[time]!["fio"]!
                            let institute = data[time]!["institute"]!
                            print(uid, purpose, email, fio, institute)
                            
                            let model = BookingsModel(date: fullDate, time: time, purpose: purpose, room: self.adminRoom, uid: uid, email: email, fio: fio, institute: institute)
                            
                            self.adminDateListVC.bookingArray.append(model)
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.pushViewController(self.adminDateListVC, animated: true)
        })
    }
    
    private func getFullDate() -> String {
        return String(adminDate!.day!) + "." + String(adminDate!.month!) + "." + String(adminDate!.year!)
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

extension AdminCalendarViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rooms[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roomTextField.text = rooms[row]
        adminRoom = roomTextField.text!
        roomTextField.resignFirstResponder()
    }
    
}

extension AdminCalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        //        if !dateComponents.day!.isMultiple(of: 2) {
        //                return UICalendarView.Decoration.default(color: .systemGreen, size: .large)
        //            }
        return nil
        //    }
    }
}

extension AdminCalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let data = dateComponents else {
            print("Error on data")
            return
        }
        print("Выбранная дата: \(data)")
        self.adminDate = data
    }

      
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
}

extension AdminCalendarViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//
//  ScheduleViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 18/01/2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

final class ScheduleViewController: UIViewController {
    
    // MARK: - Properties
    
    var room = ""
    
    var purpose = ""
    
    var date: DateComponents?
    
    var time = ""
    
    private var email = ""
    
    private var fio = ""
    
    private var institute = ""
    
    var listener: ListenerRegistration?
    
    let db = Firestore.firestore()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var firstButton: UIButton = {
        let button = getButton(text: "10.00-11.00")
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = getButton(text: "11.00-12.00")
        
        return button
    }()
    
    private lazy var thirdButton: UIButton = {
        let button = getButton(text: "12.00-13.00")
        
        return button
    }()
    
    private lazy var fourthButton: UIButton = {
        let button = getButton(text: "13.00-14.00")
        
        return button
    }()
    
    private lazy var fifthButton: UIButton = {
        let button = getButton(text: "14.00-15.00")
        
        return button
    }()
    
    private lazy var sixthButton: UIButton = {
        let button = getButton(text: "15.00-16.00")
        
        return button
    }()
    
    private lazy var seventhButton: UIButton = {
        let button = getButton(text: "16.00-17.00")
        
        return button
    }()
    
    private lazy var eighthButton: UIButton = {
        let button = getButton(text: "17.00-18.00")
        
        return button
    }()
    
    private lazy var ninthButton: UIButton = {
        let button = getButton(text: "18.00-19.00")
        
        return button
    }()
    
    private lazy var tenthButton: UIButton = {
        let button = getButton(text: "19.00-20.00")
        
        return button
    }()
    
    private lazy var bookingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забронировать", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(bookingButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        addSubviews()
        setUpConstraints()
        setUserInfo()
        checkForUpdates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        [firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton, seventhButton, eighthButton, ninthButton, tenthButton].forEach { button in
            button.setTitleColor(AppColors.freeColor, for: .normal)
            button.layer.borderColor = AppColors.freeColor.cgColor
            button.isEnabled = true
        }
        
        listener?.remove()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkFreeTime()
        setUp()
    }
    
    private func checkForUpdates() {
        let bookingsCollection = db.collection(room)
        listener = bookingsCollection.addSnapshotListener { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error fetching snapshots: \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.checkFreeTime()
        }
    }
    
    private func getButton(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitleColor(AppColors.freeColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.layer.borderWidth = 2
        button.layer.borderColor = AppColors.freeColor.cgColor
        button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        
        return button
    }

    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Выберите время бронирования"
        navigationController?.navigationBar.isTranslucent = true
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = AppColors.miitColor


        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        
        [firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton, seventhButton, eighthButton, ninthButton, tenthButton, bookingButton].forEach { viewback.addSubview($0) }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(830)
            make.width.equalTo(self.view)
        }
        
        firstButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
        }
        
        secondButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(firstButton).inset(69)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(secondButton).inset(69)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(thirdButton).inset(69)
        }
        
        fifthButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(fourthButton).inset(69)
        }
        
        sixthButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(fifthButton).inset(69)
        }
        
        seventhButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(sixthButton).inset(69)
        }
        
        eighthButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(seventhButton).inset(69)
        }
        
        ninthButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(eighthButton).inset(69)
        }
        
        tenthButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(292)
            make.centerX.equalToSuperview()
            make.top.equalTo(ninthButton).inset(69)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.centerX.equalToSuperview()
            make.top.equalTo(tenthButton).inset(71)
            
        }
    }
    
    func checkFreeTime() {
        let dataFull = getFullDate(self.date)
        
        db.collection(self.room).document(dataFull).getDocument { document, error in
            if error != nil {
                print("Error on checking date for bookings: \(String(describing: error?.localizedDescription))")
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("Данные о бронировании: \(data)")
                    
                    [self.firstButton, self.secondButton, self.thirdButton, self.fourthButton, self.fifthButton, self.sixthButton, self.seventhButton, self.eighthButton, self.ninthButton, self.tenthButton].forEach { button in
                        if button.tag != 1 {
                            button.setTitleColor(AppColors.freeColor, for: .normal)
                            button.layer.borderColor = AppColors.freeColor.cgColor
                            button.layer.borderWidth = 2
                            button.tag = 0
                        }
                    }
                    
                    for (time, _) in data {
                        print(time)
                        
                        if time == "10.00-11.00" {
                            self.disableButton(button: self.firstButton)
                        }
                        
                        if time == "11.00-12.00" {
                            self.disableButton(button: self.secondButton)
                        }
                        
                        if time == "12.00-13.00" {
                            self.disableButton(button: self.thirdButton)
                        }
                        
                        if time == "13.00-14.00" {
                            self.disableButton(button: self.fourthButton)
                        }
                        
                        if time == "14.00-15.00" {
                            self.disableButton(button: self.fifthButton)
                        }
                        
                        if time == "15.00-16.00" {
                            self.disableButton(button: self.sixthButton)
                        }
                        
                        if time == "16.00-17.00" {
                            self.disableButton(button: self.seventhButton)
                        }
                        
                        if time == "17.00-18.00" {
                            self.disableButton(button: self.eighthButton)
                        }
                        
                        if time == "18.00-19.00" {
                            self.disableButton(button: self.ninthButton)
                        }
                        
                        if time == "19.00-20.00" {
                            self.disableButton(button: self.tenthButton)
                        }
                    }
                }
            }
        }
    }
    
    private func disableButton(button: UIButton) {
        button.layer.borderColor = AppColors.busyColor.cgColor
        button.setTitleColor(AppColors.busyColor, for: .normal)
        button.layer.borderWidth = 2
        button.isEnabled = false
    }
    
    private func getFullDate(_ date: DateComponents?) -> String {
        return String(date!.day!) + "." + String(date!.month!) + "." + String(date!.year!)
    }
    
    private func setUserInfo() {
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document(uid!).getDocument { doc, err in
            if let err = err {
                print("Error: \(err.localizedDescription)")
            } else {
                if let doc = doc {
                    let data = doc.data()
                    self.email = data!["email"]! as! String
                    self.fio = data!["fio"]! as! String
                    self.institute = data!["institute"]! as! String
                }
            }
        }
    }
    
    @objc private func timeButtonTapped(sender: UIButton) {
        self.time = sender.titleLabel!.text!
        
        if sender.titleLabel?.textColor != AppColors.miitColor {
            sender.setTitleColor(AppColors.miitColor, for: .normal)
            sender.layer.borderColor = AppColors.miitColor.cgColor
            sender.layer.borderWidth = 3
            sender.tag = 1
            disableButtons(disable: true)
            
            print("User time - \(time)")
            print(date?.day ?? "", date?.month ?? "", date?.year ?? "")
            print(room)
            print(purpose)
            
        } else if sender.titleLabel?.textColor == AppColors.miitColor {
            sender.setTitleColor(AppColors.freeColor, for: .normal)
            sender.layer.borderColor = AppColors.freeColor.cgColor
            sender.layer.borderWidth = 2
            disableButtons(disable: false)
            sender.tag = 0
            self.time = ""
        }
    }
    
    @objc private func bookingButtonTapped() {
        if self.time == "" {
            let alert = Validate.showAlert(title: "Ошибка", message: "Укажите время посещения")
            present(alert, animated: true)
            return
        }
        
        if self.date == nil {
            let alert = Validate.showAlert(title: "Ошибка", message: "Укажите дату бронирования")
            present(alert, animated: true)
            return
        }
        
        if self.room == "" {
            let alert = Validate.showAlert(title: "Ошибка", message: "Укажите помещение для бронирования")
            present(alert, animated: true)
            return
        }
        
        if self.purpose == "" {
            let alert = Validate.showAlert(title: "Ошибка", message: "Укажите цель бронирования")
            present(alert, animated: true)
            return
        }
        
        // MARK: Add to firestore
        
        let dataFull = getFullDate(date)
        let uid = Auth.auth().currentUser?.uid
        let bookingData = [time: ["uid": uid, "purpose": purpose, "email": email, "fio": fio, "institute": institute]]
        
        var fl = false
        
        db.collection(room).document(dataFull).getDocument { doc, error in
            if let err = error {
                print("Error: \(err.localizedDescription)")
            } else {
                if let doc = doc, doc.exists {
                    let data = doc.data().map(String.init(describing:))
                    if data!.contains(self.time) {
                        let alert = Validate.showAlert(title: "Данное время забронировано", message: "Выберите другое время")
                        self.present(alert, animated: true)
                        fl = true
                        return
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            if !fl {
                self.db.collection(self.room).document(dataFull).setData(bookingData, merge: true) { error in
                    if let error = error {
                        print("Error on booking to firestore: \(error.localizedDescription)")
                    } else {
                        print("Successfully added a new booking to firestore")
                        let alert = Validate.showAlert(title: "Готово", message: "Вы успешно забронированы")
                        self.present(alert, animated: true)
                    }
                }
                
                // MARK: Add to users collection
                
                let bookingArray = ["date": dataFull, "time": self.time, "room": self.room, "purpose": self.purpose]
                
                let userData = ["bookings": FieldValue.arrayUnion([bookingArray])]
                
                self.db.collection("users").document(uid!).updateData(userData) { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("Successfully added to user account booking")
                    }
                }
                
                // MARK: Add to UserDefaults
                
                let booking = BookingsModel(date: dataFull, time: self.time, purpose: self.purpose, room: self.room, uid: uid!, email: self.email, fio: self.fio, institute: self.institute)
                UserModel.bookingsModel = [booking]
                
                self.checkFreeTime()
                
                [self.firstButton, self.secondButton, self.thirdButton, self.fourthButton, self.fifthButton, self.sixthButton, self.seventhButton, self.eighthButton, self.ninthButton, self.tenthButton].forEach { button in
                    if button.layer.borderColor != AppColors.busyColor.cgColor {
                        button.setTitleColor(AppColors.freeColor, for: .normal)
                        button.layer.borderColor = AppColors.freeColor.cgColor
                        button.layer.borderWidth = 2
                        button.tag = 0
                    }
                }
                
                // MARK: Make a notification
                
                UNUserNotificationCenter.current().getNotificationSettings { [self] settings in
                    if settings.authorizationStatus == .authorized {
                        let calendar = Calendar.current
                        let notificationDate = calendar.date(byAdding: .day, value: -1, to: (date?.date)!)!
                        
                        let content = UNMutableNotificationContent()
                        
                        content.title = "У вас бронирование"
                        content.body = "Завтра, \(dataFull) в \(booking.time!) \(room)"
                        
                        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
                        let temp = Int(booking.time!.split(separator: "-")[0].split(separator: ".")[0])!
                        components.hour = temp
                        components.minute = 0
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                        let identifier = uid! + booking.time! + dataFull + room
                        
                        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request) { error in
                            if let error = error {
                                print("Error on notification: \(error.localizedDescription)")
                            } else {
                                print("Successfully add a new notification for user booking ")
                            }
                        }
                    }
                }
            } else {
                self.checkFreeTime()
                return
            }
            
            self.disableButtons(disable: false)
            self.time = ""
        })
    }
    
    private func disableButtons(disable: Bool) {
        [firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton, seventhButton, eighthButton, ninthButton, tenthButton].forEach { button in
            if button.tag != 1 && button.layer.borderColor != AppColors.busyColor.cgColor {
                button.isEnabled = !disable
            }
        }
    }
    
}


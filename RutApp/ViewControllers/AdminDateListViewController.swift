//
//  AdminDateListViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 08/02/2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

final class AdminDateListViewController: UIViewController {
    
    // MARK: - Properties
    
    var room = ""
    
    var date: DateComponents?
    
    var bookingArray = [BookingsModel]()
    
    private var viewArray = [BookingViews]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        addSubviews()
        setUpConstraints()
        setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
        viewArray.forEach { item in
            item.mainView.removeFromSuperview()
        }
        
        bookingArray = []
        viewArray = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        setUpViews()
        setUp()
        navigationItem.title = getFullDate(date)
        navigationController?.navigationBar.backItem?.title = "Назад"
        navigationItem.backButtonTitle = "Назад"
    }
    
    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backItem?.title = "Назад"
        navigationItem.backButtonTitle = "Назад"
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = AppColors.miitColor
        
        
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private func setUpViews() {
        let number = bookingArray.count
            
        if number != 0 {
            var mlt = 25
            var cnt = 0
            
            // MARK: Add bookings to view
            
            for i in 0..<number {
                let view = BookingViews()
                viewback.addSubview(view.mainView)
                view.setViewConstraints(multiplier: mlt)
                
                mlt += 189
                viewArray.append(view)
            }
            
            // MARK: Addjust user bookings to display info
            
            for view in viewArray {
                view.roomLabel.text = bookingArray[cnt].room!
                view.timeLabel.text = bookingArray[cnt].time!
                view.fioLabel.text = bookingArray[cnt].fio!
                view.purposeLabel.text = bookingArray[cnt].purpose!
                view.instituteLabel.text = bookingArray[cnt].institute!
                view.cancelButton.setTitle(bookingArray[cnt].email!, for: .normal)
                cnt += 1
            }
            
            // MARK: Change scrollView height
            
            if number > 3 {
                let backHeight = (number * 189) + 15
                setBackHeight(multiplier: backHeight)
            } else {
                setBackHeight(multiplier: 600)
            }
            
        } else {
            showEmptyLabel()
        }
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setBackHeight(multiplier: Int) {
        viewback.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(multiplier)
            make.width.equalTo(self.view)
        }
    }
    
    private func showEmptyLabel() {
        let alert = UIAlertController(title: "Упс", message: "Бронирований пока нет", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Понятно", style: .cancel, handler: { action in
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.popViewController(animated: true)
            
            print("Alert successful")
        }))
        present(alert, animated: true)
    }
    
    private func getFullDate(_ date: DateComponents?) -> String {
        if let day = date?.day, let month = date?.month, let year = date?.year {
            let months = [1 : "Января", 2 : "Февраля", 3 : "Марта", 4 : "Апреля", 5 : "Мая", 6 : "Июня", 7 : "Июля", 8 : "Августа", 9 : "Сентября", 10 : "Октября", 11 : "Ноября", 12 : "Декабря"]
            
            let result = String(day) + " " + months[month]! + " " + String(year) + " г."
            
            return result
        }
        
        return ""
    }
    
    private class BookingViews {
        
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
        
        let fioLabel: UILabel = {
            let fio = UILabel()
            fio.text = "Киво Михаил Андреевич"
            fio.font = .systemFont(ofSize: 16, weight: .bold)
            fio.textColor = .black
            fio.numberOfLines = 2
            fio.textAlignment = .center
            
            return fio
        }()
        
        let instituteLabel: UILabel = {
            let institute = UILabel()
            institute.text = "ИУЦТ"
            institute.font = .systemFont(ofSize: 17, weight: .bold)
            institute.textColor = .black
            
            return institute
        }()
        
        var timeLabel: UILabel = {
            let time = UILabel()
            time.text = "10.00-11.00"
            time.font = .systemFont(ofSize: 17, weight: .bold)
            time.textColor = .black
            time.textAlignment = .center
            time.adjustsFontSizeToFitWidth = true
            time.minimumScaleFactor = 0.5
            
            return time
        }()
        
        var roomLabel: UILabel = {
            let room = UILabel()
            room.text = "Переговорная"
            room.font = .systemFont(ofSize: 18, weight: .bold)
            room.textColor = .black
            room.textAlignment = .center
            room.adjustsFontSizeToFitWidth = true
            room.minimumScaleFactor = 0.5
            
            return room
        }()
        
        let purposeLabel: UILabel = {
            let purpose = UILabel()
            purpose.text = "Обсуждение проекта"
            purpose.font = .systemFont(ofSize: 16, weight: .medium)
            purpose.textColor = .black
            purpose.textAlignment = .center
            purpose.numberOfLines = 0
            purpose.adjustsFontSizeToFitWidth = true
            purpose.minimumScaleFactor = 0.5
            
            return purpose
        }()
        
        let cancelButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("example@gmail.com", for: .normal)
            button.backgroundColor = AppColors.miitColor
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 12
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            button.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
            
            return button
        }()
        
        func setViewConstraints(multiplier: Int) {
            [roomLabel, instituteLabel, timeLabel, roomLabel, purposeLabel, fioLabel].forEach { mainView.addSubview($0) }
            mainView.addSubview(cancelButton)
            mainView.addSubview(lineView)
            
            mainView.snp.makeConstraints { make in
                make.top.equalTo(multiplier) // changeable only 66ggZl&7bb!!!
                make.leading.equalTo(14)
                make.trailing.equalTo(-14)
                make.height.equalTo(164)
                make.width.equalTo(355)
            }
            
            instituteLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(106)
                make.leading.equalToSuperview().inset(45)
                make.height.equalTo(50)
                make.width.equalTo(104)
            }
            
            fioLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalToSuperview().inset(144)
                make.height.equalTo(40)
                make.width.equalTo(190)
            }
            
            timeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(66)
                make.leading.equalToSuperview().inset(16)
                make.height.equalTo(35)
                make.width.equalTo(100)
            }
            
            roomLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(42)
                make.leading.equalToSuperview().inset(-2)
                make.height.equalTo(34)
                make.width.equalTo(140)
            }
            
            purposeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(53)
                make.leading.equalTo(lineView).inset(15)
                make.height.equalTo(38)
                make.width.equalTo(180)
            }
            
            cancelButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(108)
                make.leading.equalToSuperview().inset(144)
                make.height.equalTo(41)
                make.width.equalTo(190)
            }
            
            lineView.snp.makeConstraints { make in
                make.width.equalTo(1)
                make.height.equalTo(134)
                make.leading.equalToSuperview().inset(135)
                make.top.equalTo(15)
                make.bottom.equalTo(-15)
            }
        }
    }
    
    @objc private func emailTapped(sender: UIButton) {
        UIPasteboard.general.string = sender.titleLabel?.text ?? ""
        print("copied!")
        
        let alert = UIAlertController(title: "Скопировано", message: "Текст скопирован в буфер обмена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

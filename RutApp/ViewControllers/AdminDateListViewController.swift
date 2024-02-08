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

class AdminDateListViewController: UIViewController {
    
    // MARK: - Properties
    
    var room = ""
    
    var date: DateComponents?
    
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

        setUp()
        setUpConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = getFullDate(date)
        print(room)
    }
    
    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backItem?.title = "Назад"
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = AppColors.miitColor


        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private func setUpConstraints() {
        
    }
    
    //TODO: Finish
    
    private func getFullDate(_ date: DateComponents?) -> String {
        if let day = date?.day, let month = date?.month, let year = date?.year {
            let months = [1 : "Января", 2 : "Февраля", 3 : "Марта", 4 : "Апреля", 5 : "Мая", 6 : "Июня", 7 : "Июля", 8 : "Августа", 9 : "Сентября", 10 : "Октября", 11 : "Ноября", 12 : "Декабря"]
            
            let result = String(day) + " " + months[month]! + " " + String(year) + " г."
            
            return result
        }
        
        return ""
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
        
        let instituteLabel: UILabel = {
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
            cancelButton.addTarget(AdminDateListViewController.BookingView.self, action: #selector(emailTapped), for: .touchUpInside)
            cancelButton.tag = 1
            
            return cancelButton
        }()
        
        func setViewConstraints(multiplier: Int) {
            [roomLabel, instituteLabel, timeLabel, roomLabel, purposeLabel].forEach { mainView.addSubview($0) }
            mainView.addSubview(cancelButton)
            mainView.addSubview(lineView)
            
            mainView.snp.makeConstraints { make in
                make.top.equalTo(multiplier) // changeable only
                make.leading.equalTo(21)
                make.height.equalTo(164)
                make.width.equalTo(334)
            }
            
            roomLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(23)
                make.leading.equalToSuperview().inset(34)
                make.height.equalTo(35)
                make.width.equalTo(85)
            }
            
            instituteLabel.snp.makeConstraints { make in
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
        
        // TODO: email write
        
        @objc private func emailTapped(sender: UIButton) {
            
        }
        
    }
    
}

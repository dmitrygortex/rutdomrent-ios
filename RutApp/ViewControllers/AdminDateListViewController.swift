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
        setUpViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = getFullDate(date)
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
    
    private func setUpViews() {
        var view1 = BookingViews()
        viewback.addSubview(view1.mainView)
        view1.setViewConstraints(multiplier: 25)
    }
    
    private func setUpConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        setBackHeight(multiplier: 650)
    }
    
    private func setBackHeight(multiplier: Int) {
        scrollView.addSubview(viewback)
        viewback.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(multiplier)
            make.width.equalTo(self.view)
        }
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
//            fio.adjustsFontSizeToFitWidth = true
//            fio.minimumScaleFactor = 0.5
            
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
        
        let roomLabel: UILabel = {
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
            let cancel = UIButton(type: .system)
            cancel.setTitle("example@gmail.com", for: .normal)
            cancel.backgroundColor = AppColors.miitColor
            cancel.setTitleColor(.white, for: .normal)
            cancel.layer.cornerRadius = 12
            cancel.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            cancel.addTarget(AdminDateListViewController.BookingViews.self, action: #selector(emailTapped), for: .touchUpInside)
            cancel.tag = 1
            
            return cancel
        }()
        
        func setViewConstraints(multiplier: Int) {
            [roomLabel, instituteLabel, timeLabel, roomLabel, purposeLabel, fioLabel].forEach { mainView.addSubview($0) }
            mainView.addSubview(cancelButton)
            mainView.addSubview(lineView)
            
            mainView.snp.makeConstraints { make in
                make.top.equalTo(multiplier) // changeable only
                make.leading.equalTo(21)
                make.height.equalTo(164)
                make.width.equalTo(334)
            }
            
            instituteLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(110)
                make.leading.equalToSuperview().inset(32)
                make.height.equalTo(50)
                make.width.equalTo(104)
            }
            
            fioLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalToSuperview().inset(137)
                make.height.equalTo(40)
                make.width.equalTo(190)
            }
            
            timeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(75)
                make.leading.equalToSuperview().inset(13)
                make.height.equalTo(35)
                make.width.equalTo(100)
            }
            
            roomLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(45)
                make.leading.equalToSuperview()
                make.height.equalTo(34)
                make.width.equalTo(140)
            }
            
            purposeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(53)
                make.leading.equalToSuperview().inset(138)
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
                make.leading.equalToSuperview().inset(132)
                make.top.equalTo(15)
                make.bottom.equalTo(-15)
            }
        }
        
        // TODO: email write
        
        @objc private func emailTapped(sender: UIButton) {
            
        }
        
    }
    
}

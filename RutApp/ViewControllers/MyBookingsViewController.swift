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
    
    // MARK: -Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: -Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setUpConstraints()
        setUp()
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
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = AppColors.miitColor


        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        
        let view1 = BookingView().mainView
        viewback.addSubview(view1)
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
    
//    private func getBookingView() -> UIView {
//        let mainView = UIView()
//        mainView.backgroundColor = AppColors.backViewColor
//        mainView.layer.cornerRadius = 12
//        
//        let image = UIImageView(image: .init(named: "bookingView"))
//        mainView.addSubview(image)
//        image.snp.makeConstraints { make in
//            make.leading.trailing.bottom.top.equalToSuperview()
//        }
//        mainView.sendSubviewToBack(image)
//        viewback.addSubview(mainView)
//        
//        let yearLabel = UILabel()
//        yearLabel.text = "2024"
//        yearLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        yearLabel.textColor = .black
//        
//        let monthLabel = UILabel()
//        monthLabel.text = "26 Января"
//        monthLabel.font = .systemFont(ofSize: 17, weight: .bold)
//        monthLabel.textColor = .black
//            
//        let timeLabel = UILabel()
//        timeLabel.text = "10.00-11.00"
//        timeLabel.font = .systemFont(ofSize: 17, weight: .bold)
//        timeLabel.textColor = .black
//        
//        let roomLabel = UILabel()
//        roomLabel.text = "Переговорная"
//        roomLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        roomLabel.textColor = .black
//        
//        let purposeLabel = UILabel()
//        purposeLabel.text = "Обсуждение проекта"
//        purposeLabel.font = .systemFont(ofSize: 15, weight: .medium)
//        purposeLabel.textColor = .black
//        
//        let cancelBookingButton = UIButton(type: .system)
//        cancelBookingButton.setTitle("Отменить бронь", for: .normal)
//        cancelBookingButton.backgroundColor = AppColors.miitColor
//        cancelBookingButton.setTitleColor(.white, for: .normal)
//        cancelBookingButton.layer.cornerRadius = 12
//        cancelBookingButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
//        cancelBookingButton.addTarget(self, action: #selector(cancelBookingButtonTapped), for: .touchUpInside)
//        cancelBookingButton.tag = 1
//        
//        [yearLabel, monthLabel, timeLabel, roomLabel, purposeLabel].forEach { mainView.addSubview($0) }
//        mainView.addSubview(cancelBookingButton)
//        
//        mainView.snp.makeConstraints { make in
//            make.top.equalTo(25)
//            make.leading.equalTo(21)
//            make.height.equalTo(164)
//            make.width.equalTo(334)
//        }
//        
//        yearLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(23)
//            make.leading.equalToSuperview().inset(34)
//            make.height.equalTo(35)
//            make.width.equalTo(85)
//        }
//        
//        monthLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(39)
//            make.leading.equalToSuperview().inset(12)
//            make.height.equalTo(50)
//            make.width.equalTo(95)
//        }
//        
//        timeLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(100)
//            make.leading.equalToSuperview().inset(10)
//            make.height.equalTo(35)
//            make.width.equalTo(100)
//        }
//        
//        roomLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.leading.equalToSuperview().inset(156)
//            make.height.equalTo(34)
//            make.width.equalTo(185)
//        }
//        
//        purposeLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(40)
//            make.leading.equalToSuperview().inset(144)
//            make.height.equalTo(48)
//            make.width.equalTo(188)
//        }
//        
//        cancelBookingButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(100)
//            make.leading.equalToSuperview().inset(135)
//            make.height.equalTo(46)
//            make.width.equalTo(180)
//        }
//        
//        func changeTop(multiplier: Int = 25) {
//            mainView.snp.makeConstraints { make in
//                make.top.equalTo(multiplier)
//                make.leading.equalTo(21)
//                make.height.equalTo(164)
//                make.width.equalTo(334)
//            }
//        }
//        
//        return mainView
//    }
    
//    @objc func cancelBookingButtonTapped() {
//        print("cancelBookingButtonTapped tapped")
//    }
}

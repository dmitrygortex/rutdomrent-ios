//
//  MyBookingsViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 27/01/2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

class MyBookingsViewController: UIViewController {
    
    //MARK: -Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let firstView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 21, y: 25, width: 334, height: 164)
        view.backgroundColor = AppColors.backViewColor
        view.layer.cornerRadius = 12
        
        let image = UIImageView(image: UIImage(named: "bookingView"))
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        view.sendSubviewToBack(image)
        
        return view
    }()
    
    let yearLabel: UILabel = {
        let date = UILabel()
        date.text = "2024"
        date.font = .systemFont(ofSize: 18, weight: .bold)
        date.textColor = .black
        date.frame = CGRect(x: 34, y: 23, width: 85, height: 35)
        
        return date
    }()
    
    let monthLabel: UILabel = {
        let month = UILabel()
        month.text = "26 Января"
        month.font = .systemFont(ofSize: 17, weight: .bold)
        month.textColor = .black
        month.frame = CGRect(x: 12, y: 39, width: 95, height: 50)
        
        return month
    }()
    
    let timeLabel: UILabel = {
        let date = UILabel()
        date.text = "10.00-11.00"
        date.font = .systemFont(ofSize: 17, weight: .bold)
        date.textColor = .black
        date.frame = CGRect(x: 10, y: 90, width: 100, height: 35)
        
        return date
    }()
    
    let roomLabel: UILabel = {
        let date = UILabel()
        date.text = "Переговорная"
        date.font = .systemFont(ofSize: 18, weight: .bold)
        date.textColor = .black
        date.frame = CGRect(x: 156, y: 8, width: 185, height: 34)
        
        return date
    }()
    
    let purposeLabel: UILabel = {
        let date = UILabel()
        date.text = "Обсуждение проекта"
        date.font = .systemFont(ofSize: 15, weight: .medium)
        date.textColor = .black
        date.frame = CGRect(x: 144, y: 40, width: 188, height: 48)
        
        return date
    }()
    
    let cancelBookingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить бронь", for: .normal)
        button.backgroundColor = AppColors.miitColor
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 135, y: 100, width: 180, height: 46)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.addTarget(self, action: #selector(cancelBookingButtonTapped), for: .touchUpInside)
        button.tag = 1
        
        return button
    }()
    
    // MARK: -Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addSubviews()
        setUpConstraints()
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
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        viewback.addSubview(firstView)
        
        [yearLabel, monthLabel, timeLabel, roomLabel, purposeLabel].forEach { firstView.addSubview($0) }
        
        firstView.addSubview(cancelBookingButton)
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
    
    @objc private func cancelBookingButtonTapped() {
        
    }
}

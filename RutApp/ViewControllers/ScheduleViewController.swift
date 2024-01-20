//
//  ScheduleViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 18/01/2024.
//

import UIKit
import SnapKit
import Firebase

class ScheduleViewController: UIViewController {
    
    //MARK: -Properties

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
    }
    
    private func setUp() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(bookingButton)
    }
    
    private func setUpConstraints() {
        bookingButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(215)
            make.top.equalToSuperview().inset(400)
            make.centerX.equalToSuperview()
        }
    }
    
    // TODO: DB
    @objc private func bookingButtonTapped() {
        
    }
}

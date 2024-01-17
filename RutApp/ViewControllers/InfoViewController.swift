//
//  InfoViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    //MARK: -Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var viewback: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Информация"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.miitColor
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Общая информация:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "График работы Дома:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var infoText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "Мой Дом - это приложение для резервирования специальных помещений Дома молодёжи РУТ(МИИТ) под мероприятия.\n\nНужно провести конференцию? Организовать митап? Сделать профессиональные фотографии? Дом моложёжи РУТ(МИИТ) - это Ваш вариант!"
        label.font = UIFont(name: "Lato-Black", size: 30)
        label.numberOfLines = 0
        label.textColor = .black
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var scheduleText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "По будням с 10:00 до 20:00"
        label.layer.cornerRadius = 12
        label.textColor = .black
        label.layer.masksToBounds = true

        return label
    }()
    
    private lazy var adressText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "ул. Образцова, 21, г. Москва"
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textColor = .black

        return label
    }()
    
    private lazy var roomlabel: UILabel = {
        let label = UILabel()
        label.text = "Помещения"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.miitColor
        
        return label
    }()
    
    // MARK: -Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        [titlelabel, infoLabel, scheduleLabel, adressLabel].forEach {
            viewback.addSubview($0)
        }
        
        [infoText, scheduleText, adressText].forEach {
            viewback.addSubview($0)
        }
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(900)
            make.width.equalTo(self.view)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(370)
            make.leading.equalTo(95)
            make.top.equalToSuperview().inset(4)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(68)
        }
        
        infoText.snp.makeConstraints { make in
            make.height.equalTo(220)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(114)
        }
        
        scheduleLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(354)
        }
        
        scheduleText.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(400)
        }
        
        adressLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(439)
        }
        
        adressText.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(334)
            make.leading.equalTo(20)
            make.top.equalTo(485)
        }
    }

}



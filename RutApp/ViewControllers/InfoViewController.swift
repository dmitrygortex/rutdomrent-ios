//
//  InfoViewController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import SnapKit

final class InfoViewController: UIViewController {
    
    //MARK: - Properties
    
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
    
    private lazy var roomtitle: UILabel = {
        let label = UILabel()
        label.text = "Помещения"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = AppColors.miitColor
        
        return label
    }()
    
    private lazy var lectureLabel: UILabel = {
        let label = UILabel()
        label.text = "Лекторий:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var meetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Переговорная:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var photoStudioLabel: UILabel = {
        let label = UILabel()
        label.text = "Фотостудия:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var coworkingLabel: UILabel = {
        let label = UILabel()
        label.text = "Коворкинг:"
        label.textColor = AppColors.placeholderColor
        label.font = UIFont(name: "Extra Light", size: 20)
        
        return label
    }()
    
    private lazy var lectureImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "lecture"))
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var meetingImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "meeting"))
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var photoStudioImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "photo"))
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var coworkingImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "coworking"))
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var lectureText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "40 посадочных мест с мини-столиками, маркерная доска, жк-экран 60 дюймов"
        label.font = UIFont(name: "Lato-Black", size: 30)
        label.numberOfLines = 0
        label.textColor = .black
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var meetingText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "12 посадочных мест, из них отдельная зона на 6 мест, маркерная доска"
        label.font = UIFont(name: "Lato-Black", size: 30)
        label.numberOfLines = 0
        label.textColor = .black
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var photoStudioText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "два гримёрных зеркала, белый фотофон, хромакей, шторы блэкаут"
        label.font = UIFont(name: "Lato-Black", size: 30)
        label.numberOfLines = 0
        label.textColor = .black
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var coworkingText: PaddedLabel = {
        let label = PaddedLabel()
        label.backgroundColor = AppColors.grayColor
        label.text = "8 рабочих мест с розетками, 11 посадочных мест, из них отдельная зона на 6 мест, маркерная доска"
        label.font = UIFont(name: "Lato-Black", size: 30)
        label.numberOfLines = 0
        label.textColor = .black
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addSubviews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setUp() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewback)
        
        [titlelabel, infoLabel, scheduleLabel, adressLabel, roomtitle, lectureLabel, meetingLabel, photoStudioLabel, coworkingLabel, lectureText, meetingText, photoStudioText, coworkingText, infoText, scheduleText, adressText].forEach { viewback.addSubview($0) }
                
        [lectureImage, meetingImage, photoStudioImage, coworkingImage].forEach { viewback.addSubview($0) }
        
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewback.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(2015)
            make.width.equalTo(self.view)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
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
            make.trailing.equalTo(-20)
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
            make.trailing.equalTo(-20)
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
            make.trailing.equalTo(-20)
            make.top.equalTo(485)
        }
        
        roomtitle.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(553)
        }
        
        lectureLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(613)
        }
        
        lectureImage.snp.makeConstraints { make in
            make.height.equalTo(199)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(663)
        }
        
        lectureText.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(873)
        }
        
        meetingLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(962)
        }
        
        meetingImage.snp.makeConstraints { make in
            make.height.equalTo(199)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(1012)
        }
        
        meetingText.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(1222)
        }
        
        photoStudioLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(1311)
        }
        
        photoStudioImage.snp.makeConstraints { make in
            make.height.equalTo(199)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(1361)
        }
        
        photoStudioText.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(1571)
        }
        
        coworkingLabel.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(280)
            make.leading.equalTo(20)
            make.top.equalTo(1660)
        }
        
        coworkingImage.snp.makeConstraints { make in
            make.height.equalTo(199)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(1710)
        }
        
        coworkingText.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalTo(337)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(1920)
        }
    }

}


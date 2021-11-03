//
//  InfoViewController.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import UIKit
import SnapKit


protocol InfoViewProtocol {
    var controller: InfoControllerProtocol? { get set }

    func configure(movie: Movie)
}

final class InfoViewController: UIViewController, InfoViewProtocol {

    var id: Int = 0

    var controller: InfoControllerProtocol?

    lazy var imageOfMovie: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.layer.cornerRadius = 5
        return image
    }()

    lazy var titleMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 26)
        label.text = "TITLE"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var year: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var lang: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var voite: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    lazy var descript: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setups()
        controller?.getMovieDeitals(id: id)

    }
}

//MARK: - SubViews setup and configugre
extension InfoViewController {

    func setups() {
        setupNavController()
        setupImage()
        setupTitile()
        setupYear()
        setupLang()
        setupVoite()
        setupDescription()
    }

    func setupImage() {
        view.addSubview(imageOfMovie)
        imageOfMovie.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(view.bounds.height/1.8)
        }
    }
    func setupTitile() {
        view.addSubview(titleMovie)
        titleMovie.snp.makeConstraints { make in
            make.top.equalTo(imageOfMovie.snp.bottom).inset(-1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(view.bounds.height/2.0)
        }
    }

    func setupYear() {
        view.addSubview(year)
        year.snp.makeConstraints { make in
            make.top.equalTo(titleMovie.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(view.bounds.width/1.6)
            make.bottom.equalToSuperview().inset(view.bounds.height/2.1)
        }
    }

    func setupLang() {
        view.addSubview(lang)
        lang.snp.makeConstraints { make in
            make.top.equalTo(titleMovie.snp.bottom)
            make.left.equalTo(year.snp.right)
            make.right.equalToSuperview().inset(view.bounds.width/3)
            make.bottom.equalToSuperview().inset(view.bounds.height/2.1)
        }
    }

    func setupVoite() {
        view.addSubview(voite)
        voite.snp.makeConstraints { make in
            make.top.equalTo(titleMovie.snp.bottom)
            make.left.equalTo(lang.snp.right)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(view.bounds.height/2.1)
        }
    }

    func setupDescription() {
        view.addSubview(descript)
        descript.snp.makeConstraints { make in
            make.top.equalTo(lang.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func configure(movie: Movie) {
        title = movie.original_title
        titleMovie.text = movie.original_title
        year.text = movie.release_date
        lang.text = movie.original_language
        voite.text = "\(movie.vote_average)"
        descript.text = movie.overview
        imageOfMovie.load(link: movie.poster_path)
    }
}
//MARK: - NavBar Settings
extension InfoViewController {
    func setupNavController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .purple
        self.navigationController?.navigationBar.barTintColor = .purple
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

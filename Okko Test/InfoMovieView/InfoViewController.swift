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
    func setupTable()
}

final class InfoViewController: UIViewController, InfoViewProtocol, UITableViewDelegate, UITableViewDataSource {

    var id: Int = 0

    var controller: InfoControllerProtocol?

    var movie: Movie?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(InfoTableViewCell.self))
        tableView.register(TextInfoTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TextInfoTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        controller?.getMovieDeitals(id: id)

    }
}

//MARK: - Setup TableView Info of movie
extension InfoViewController {

    func setupTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.tableView.backgroundColor = .purple
        self.tableView.separatorColor = .clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(InfoTableViewCell.self), for: indexPath) as! InfoTableViewCell
            cell.configure(image: movie?.poster_path ?? " ")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TextInfoTableViewCell.self), for: indexPath) as! TextInfoTableViewCell
            cell.configure(text: movie?.original_title ?? "none", style: .title)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TextInfoTableViewCell.self), for: indexPath) as! TextInfoTableViewCell
            cell.configure(text: "DESCRIPTION: \n\(movie?.overview ?? "none")", style: .normal)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TextInfoTableViewCell.self), for: indexPath) as! TextInfoTableViewCell
            let str = "DATE: \(movie?.release_date ?? "0") . LANG: \(movie?.original_language ?? "en") . VOITE: \((movie?.vote_average)!)"

            cell.configure(text: str, style: .description)
            return cell
        }
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return view.bounds.height/1.5
        case 3:
            return view.bounds.height/5
        default:
            return view.bounds.height/20
        }
    }
    func configure(movie: Movie) {
        title = movie.original_title
        self.movie = movie
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

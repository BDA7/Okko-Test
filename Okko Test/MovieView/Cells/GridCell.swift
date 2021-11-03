//
//  GridCell.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import UIKit
import SnapKit

class GridCell: UICollectionViewCell {

    var id: Int?

    var delegate: MoviesViewProtocol?

    lazy var nameOfMovie: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemPurple
        label.textAlignment = .center
        return label
    }()

    lazy var imageOfMovie: UIImageView = {
        let image = UIImageView()
        return image
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        return button
    }()


    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
        setupTitile()
        setupButton()

        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }

    func configure(with text: String, image: String, id: Int) {
        nameOfMovie.text = text
        imageOfMovie.load(link: image)
        self.id = id
    }

    @objc func click(_ sender: Any?) {
        delegate?.tapCell(id: self.id ?? 0)
    }


    func setupImage() {
        contentView.addSubview(imageOfMovie)
        imageOfMovie.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(contentView.frame.height/4)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
    }

    func setupTitile() {
        contentView.addSubview(nameOfMovie)
        nameOfMovie.snp.makeConstraints { make in
            make.top.equalTo(imageOfMovie.snp.bottom).inset(-2)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
    }

    func setupButton() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
    }
}
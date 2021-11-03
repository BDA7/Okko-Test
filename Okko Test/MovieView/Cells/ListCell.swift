//
//  ListCell.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import UIKit
import SnapKit

class ListCell: UICollectionViewCell {

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
        image.contentMode = .scaleToFill
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
        self.layer.borderColor = UIColor.systemPurple.cgColor
        self.layer.borderWidth = 5
        self.clipsToBounds = true
    }

    func configure(with text: String, image: String, id: Int) {
        nameOfMovie.text = text
        imageOfMovie.load(link: image)
        self.id = id
    }

    @objc func click(_ sender: Any?) {
        delegate?.action(with: .tapCell(id: self.id ?? 0))
    }
    
//MARK: add subViews and Constraints
    func setupImage() {
        contentView.addSubview(imageOfMovie)
        imageOfMovie.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView).inset(contentView.frame.width/1.75)
        }
    }

    func setupTitile() {
        contentView.addSubview(nameOfMovie)
        nameOfMovie.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(imageOfMovie.snp.right)
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

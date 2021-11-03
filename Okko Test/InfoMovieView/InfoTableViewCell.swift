//
//  InfoTableViewCell.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import UIKit
import SnapKit

class InfoTableViewCell: UITableViewCell {

    lazy var imageOfMovie: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
    }

    func configure(image: String) {
        imageOfMovie.load(link: image)
    }

    func setupImage() {
        contentView.addSubview(imageOfMovie)
        imageOfMovie.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
    }

}

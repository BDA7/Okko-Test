//
//  TextInfoTableViewCell.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import UIKit
import SnapKit


enum TextStyle {
    case title
    case normal
    case description
}

class TextInfoTableViewCell: UITableViewCell {

    lazy var infoForMovie: UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupInfo()
        backgroundColor = .purple
    }


    func configure(text: String, style: TextStyle) {
        switch style {
        case .title:
            infoForMovie.font = UIFont(name: "Arial", size: 20)
            infoForMovie.text = text
        case .normal:
            infoForMovie.font = UIFont(name: "Arial", size: 14)
            infoForMovie.text = text
        case .description:
            infoForMovie.font = UIFont(name: "Arial", size: 16)
            infoForMovie.text = text
        }
    }

    func setupInfo() {
        contentView.addSubview(infoForMovie)
        infoForMovie.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
    }
}

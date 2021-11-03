//
//  SectionHeader.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 03.11.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    let title = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cunstomizeElements()
        setupConstraints()
    }
    
    private func cunstomizeElements() {
        title.textColor = .white
        title.font = UIFont(name: "Arial", size: 26)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

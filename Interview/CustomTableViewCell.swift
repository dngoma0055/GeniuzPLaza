//
//  CustomTableViewCell.swift
//  Interview
//
//  Created by davy ngoma mbaku on 8/11/19.
//  Copyright © 2019 davy ngoma mbaku. All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static var withIdentifier = "customTableViewCell"
    var backView = UIView()
    var artistName = UILabel()
    var albumName = UILabel()
    var albumImage = CustomImageclass()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bindData(_ item: Results) {
        artistName.text = item.artistName ?? "No Information"
        albumName.text = item.name ?? "No Information"
    }
}

//MAR: TableviewCell SnapKit
extension CustomTableViewCell {
    func createCellView() {
        addSubview(backView)
        backView.addSubview(albumImage)
        backView.addSubview(artistName)
        backView.addSubview(albumName)
        
        backView.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
            $0.height.equalTo(110)
        }
        backView.backgroundColor = .clear
        
        albumImage.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.width.equalTo(90)
            $0.height.equalTo(90)
            $0.centerY.equalTo(backView)
        }
        albumImage.layer.cornerRadius = 45
        albumImage.backgroundColor = .clear
        albumImage.clipsToBounds = true
        
        artistName.snp.makeConstraints {
            $0.left.equalTo(albumImage.snp_rightMargin).offset(20)
            $0.right.equalTo(backView)
            $0.height.equalTo(30)
            $0.top.equalTo(20)
        }
        artistName.textAlignment = .left
        artistName.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        albumName.snp.makeConstraints {
            $0.left.equalTo(albumImage.snp_rightMargin).offset(20)
            $0.right.equalTo(backView)
            $0.height.equalTo(30)
            $0.top.equalTo(artistName.snp_bottomMargin).offset(10)
        }
        albumName.textAlignment = .left
        albumName.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createCellView()
        layoutSubviews()
    }
}

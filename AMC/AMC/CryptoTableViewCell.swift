//
//  CryptoTableViewCell.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/9/22.
//

import UIKit


struct CryptoTableViewCellViewModel {
    let name: String
    let symbol: String
    let price: String
}


class CryptoTableViewCell: UITableViewCell {
    
static let identifier = "CryptoTableViewCell"
    
    //subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    //init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    
    //layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        symbolLabel.sizeToFit()
        
        
        nameLabel.frame = CGRect(
            x: 15,
            y: 0,
            width: contentView.frame.size.width/2,
            height: contentView.frame.size.height/2
        )
    
    
    symbolLabel.frame = CGRect(
        x: 15,
        y: contentView.frame.size.height/2,
        width: contentView.frame.size.width/2,
        height: contentView.frame.size.height/2
)
priceLabel.frame = CGRect(
    x: contentView.frame.size.width/2,
    y: 0,
    width: (contentView.frame.size.width/2) - 15,
    height: contentView.frame.size.height
)
    }
    
    //under discussion needs to be reviewd
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil
    }
    //configure
    
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        symbolLabel.text = viewModel.symbol
        
    }

    }


//
//  ViewController.swift
//  GeniusPLaza
//
//  Created by davy ngoma mbaku on 8/10/19.
//  Copyright © 2019 davy ngoma mbaku. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let tableView = UITableView()
    let name = UILabel()
    let genre = UILabel()
    let image = UIImageView()
    var resultData = [Results]()
    let emptyPicture = "albumart"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    func getData() {
        WebService.shared.getDataItune { (jsonResponse, Error) in
            if let error = Error {
                //can customize your error behavoir
                //for now just priting it
                NSLog("=======Error: \(String(describing:error))")
            }
            guard let data = jsonResponse else {
                return
            }
            self.resultData = data.feed.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func setTableView() {
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
        }
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.withIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.withIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        let index = resultData[indexPath.row]
        print(index)
        cell.albumName.text = index.name
        cell.bindData(index)
        if let artworkUrl100 = index.artworkUrl100?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let imgUrl = URL(string: artworkUrl100) {
            cell.albumImage.loadImageWithUrl(imgUrl)
        }
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
}

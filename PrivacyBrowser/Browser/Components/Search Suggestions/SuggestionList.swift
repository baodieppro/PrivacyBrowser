//
//  SuggestionList.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 19.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

final class SuggestionList: UIView {    
    @IBOutlet weak private var tableView: UITableView!
    
    private let reuseIdentifier = "suggestionListTableViewCell"
    
    var suggestions: [Suggestion]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: SuggestionListDelegate?

    class func instanceFromNib() -> SuggestionList {
        return UINib(nibName: "SuggestionList", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! SuggestionList
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTableView()
    }
}

extension SuggestionList {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SuggestionList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = suggestions?[indexPath.row].phrase       
        return cell
    }
}

extension SuggestionList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let suggestion = suggestions?[indexPath.row] else {
            return
        }
        
        delegate?.suggestionList(self, didTapSuggestion: suggestion)
    }
}

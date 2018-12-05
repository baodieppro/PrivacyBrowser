//
//  MainViewController.swift
//  PrivacyBrowser
//
//  Created by Eray Cetiner on 18.11.2018.
//  Copyright © 2018 Eray Cetiner. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak private var addressBar: AddressBar!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var navigationBar: NavigationBar!
    
    private var webView: WebView!
    private var suggestionList: SuggestionList?
    
    private let trackerStore: TrackerStore! = TrackerDictionary()
    private let suggestionService: SuggestionService! = DuckDuckGoSuggestionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddressBar()
        setupWebView()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = containerView.bounds
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "showTrackerList" {
            if let navigationViewController = segue.destination as? UINavigationController,
                let trackerListTableViewController = navigationViewController.topViewController as? TrackerListTableViewController {
                trackerListTableViewController.trackers = getDetectedTrackersAtCurrentPage()
            }
        }
    }
}

// MARK: Address bar
extension MainViewController {
    private func setupAddressBar() {
        addressBar.state = .idle
        addressBar.delegate = self
    }
}

// MARK: Address bar delegate
extension MainViewController: AddressBarDelegate {
    func addressBar(_ addressBar: AddressBar, didSubmitText text: String?) {
        load(urlFromText: text)
    }
    
    func addressBar(_ addressBar: AddressBar, didTypeText text: String?) {
        guard let text = text, !text.isEmpty else {
            return
        }
        
        fetchSuggestions(forText: text)
    }
    
    func addressBarDidTapTrackerButton(_ addressBar: AddressBar) {
        performSegue(
            withIdentifier: "showTrackerList",
            sender: self
        )
    }
    
    func addressBarDidTapReloadButton(_ addressBar: AddressBar) {
        webView.reload()
    }
}

// MARK: Fetch suggestions
extension MainViewController {
    private func fetchSuggestions(forText text: String) {
        suggestionService.getSuggestions(
            forText: text,
            completionHandler: fetchSuggestionsCompletionHandler,
            errorHandler: fetchSuggestionsErrorHandler
        )
    }
    
    private func fetchSuggestionsCompletionHandler(suggestions: [Suggestion]) {
        DispatchQueue.main.async{
            self.display(suggestions: suggestions)
        }
    }
    
    private func fetchSuggestionsErrorHandler(error: Error?) {
        DispatchQueue.main.async{
            self.detachSuggestionList()
        }
    }
}

// MARK: Display suggestions
extension MainViewController {
    private func display(suggestions: [Suggestion]) {
        if suggestionList == nil {
            attachSuggestionList()
        }
        
        suggestionList!.suggestions = suggestions
    }
    
    private func attachSuggestionList() {
        suggestionList = SuggestionList.instanceFromNib()
        containerView.addSubview(suggestionList!)
        suggestionList!.frame = containerView.bounds
        suggestionList!.delegate = self
    }
    
    private func detachSuggestionList() {
        suggestionList?.removeFromSuperview()
        suggestionList = nil
    }
}

// MARK: Suggestion list delegate
extension MainViewController: SuggestionListDelegate {
    func suggestionList(_ suggestionList: SuggestionList, didTapSuggestion suggestion: Suggestion) {
        addressBar.updateText(with: suggestion.phrase)
        load(urlFromText: suggestion.phrase)
    }
}

// MARK: Web view
extension MainViewController {
    private func setupWebView() {
        webView = WebView(frame: containerView.bounds)
        containerView.addSubview(webView)
        webView.delegate = self
    }
    
    private func load(urlFromText text: String?) {
        guard let text = text,
            let url = URLFactory.getURL(fromText: text) else {
                return
        }

        load(url: url)
    }
    
    private func load(url: URL) {
        webView.load(URLRequest(url: url))
        detachSuggestionList()
        view.endEditing(true)
    }
}

// MARK: Web view delegate
extension MainViewController: WebViewDelegate {
    func webView(_ webView: WebView, didFinishLoadingContentAtURL url: URL) {
        addressBar.state = .pageLoaded(url: url.absoluteString)
        addressBar.trackerCount = trackerStore.getTrackers(blockedAtURL: url).count
        navigationBar.navigationState = NavigationState(
            canGoBack: webView.canGoBack,
            canGoForward: webView.canGoForward
        )
    }
    
    func webView(_ webView: WebView, didFailLoadingContentWithError error: Error) {
        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: "Error"),
            message: NSLocalizedString("network_error.generic_message", comment: "Network Error Generic Message"),
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Cancel", comment: "Cancel"),
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WebView, didDetectTracker tracker: Tracker, atURL url: URL) {
        trackerStore.addTracker(tracker, blockedAtURL: url)
        addressBar.trackerCount = trackerStore.getTrackers(blockedAtURL: url).count
    }
}

// MARK: Navigation bar
extension MainViewController {
    private func setupNavigationBar() {
        navigationBar.navigationState = NavigationState(
            canGoBack: false,
            canGoForward: false
        )
        navigationBar.delegate = self
    }
}

// MARK: Navigation bar delegate
extension MainViewController: NavigationBarDelegate {
    func navigationBarDidTapBackButton(_ navigationBar: NavigationBar) {
        webView.goBack()
    }
    
    func navigationBarDidTapForwardButton(_ navigationBar: NavigationBar) {
        webView.goForward()
    }    
}

// MARK: Helpers
extension MainViewController {
    private func getDetectedTrackersAtCurrentPage() -> [Tracker]? {
        guard let url = webView.url else {
            return nil
        }
        
        return trackerStore.getTrackers(blockedAtURL: url)
    }
}

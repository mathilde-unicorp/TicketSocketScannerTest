//
//  ViewController.swift
//  TicketSocketScanner
//
//  Created by Ressier Mathilde on 22/03/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    // MARK: - View lifecycle

    override func loadView() {
        super.loadView()
        self.loadWebView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Load Web View

    private func loadWebView() {
        let url = URL(string: Constants.ticketSocketUrl)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    // MARK: Setup View

    private func setupUI() {
        self.webView.navigationDelegate = self
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        // Auto fill user log in form
        setElement(on: webView, withName: "username", value: Constants.username)
        setElement(on: webView, withName: "password", value: Constants.password)
        setElement(on: webView, withName: "siteId", value: Constants.siteId)
    }

    private func setElement(on webView: WKWebView, withName name: String, value: String) {
        webView.evaluateJavaScript("document.getElementsByName(\"\(name)\")[0].value = \"\(value)\"")
    }
}

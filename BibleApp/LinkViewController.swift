//
//  LinkViewController.swift
//  BibleApp
//
//  Created by Mac on 5/11/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController {
    
    // MARK:- Properties and IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var backController: UIViewController?
    var pathWebView: String!
    var typeContentProvider = ContentProviderType.User
    
    // MARK:- LinkViewController`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage(with: URL(string: pathWebView)!)

        saveButton.layer.cornerRadius = 5
        saveButton.layer.masksToBounds = true
    
        webView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK:- The other helpfull methods
    
    fileprivate func loadPage(with url: URL) {
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    fileprivate func fetchYouTubeID() -> String? {

        let youTubePath = linkTextField.text!
        
        let stringArray = youTubePath.components(separatedBy: "?v=")
        
        return stringArray.last
    }
    // MARK: - Actions
    
    @IBAction func goForwardAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func goBackAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
            webView.reload()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        switch typeContentProvider {
        case .Pastor:
           let controller = backController as! UploadSermonesVC
            
            controller.isYouTubeLoaded = true
            controller.tableView.reloadData()
            controller.youTubeId = fetchYouTubeID()
            controller.videoUrl = linkTextField.text!
        case .Author_Movie:
            
            let controller = backController as! UploadMovieTVC
            
            controller.isYouTubeLoaded = true
            controller.tableView.reloadData()
            controller.youTubeId = fetchYouTubeID()
            controller.videoUrl = linkTextField.text!

        case .Artist:
            let controller = backController as! UploadMusicTVC
            
            controller.isYouTubeLoaded = true
            controller.tableView.reloadData()
            controller.youTubeId = fetchYouTubeID()
            controller.videoUrl = linkTextField.text!
        case .Author_Book:
            let controller = backController as! BookUploadViewController
            
            controller.isYouTubeLoaded = true
            controller.tableView.reloadData()
            controller.videoUrl = linkTextField.text!
            
        default:
            print("")
        }
        
        dismiss(animated: true, completion: nil)
    }
}

private typealias WebViewDelegate = LinkViewController
extension WebViewDelegate: UIWebViewDelegate {

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        linkTextField.text = request.url?.absoluteString
        return true
    }   
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if webView.request!.url!.absoluteString != "" {
            linkTextField.text = webView.request?.url?.absoluteString
        }
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
    
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    
    }
}

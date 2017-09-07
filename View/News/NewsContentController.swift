//
//  NewsContentController.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ViewModel

class NewsContentController: UIViewController {
    private let disposeBag = DisposeBag()
    
    public var viewModel: NewsContentViewModel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        bindViewModel()
    }
    
    private func configureTextView() {
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = NewsContentViewModel.Input(
            refreshTrigger: self.refreshTrigger
        )
        
        let output = viewModel.transform(input: input)
        
        //Connect Create Post to UI
        output.content
            .drive(textView.rx.text)
            .addDisposableTo(disposeBag)
        
        output.fetching
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        output.error
            .drive(onNext: { [weak self] (err) in
                self?.handleError(err: err)
            })
            .disposed(by: disposeBag)
    }
    
    var refreshTrigger: Driver<Void> {
        return rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
    }
    
    
    private func handleError(err: Error) {
        let errorDesc = (err as NSError).localizedDescription
        let desc = errorDesc.characters.count > 0 ? errorDesc : "Some Error"
        let alert = UIAlertController(title: "Error", message: desc, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

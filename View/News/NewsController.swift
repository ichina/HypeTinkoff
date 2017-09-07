//
//  NewsController.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ViewModel

public class NewsController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    public var viewModel: NewsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let itemSelected:Observable<IndexPath> = tableView.rx.itemSelected.asObservable()
        let input = NewsViewModel.Input(
            viewWillAppear: self.viewWillAppearDriver,
            refreshTrigger: self.refreshTrigger,
            nextPageTrigger: self.nextPageTrigger,
            itemSelected:itemSelected
        )
        
        let output = viewModel.transform(input: input)
        
        //Bind Posts to UITableView
        output.posts.drive(tableView.rx.items(cellIdentifier: NewsTableViewCell.reuseID, cellType: NewsTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
            
            }.addDisposableTo(disposeBag)
        
        //Connect Create Post to UI
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.error
            .drive(onNext: { [weak self] (err) in
                self?.handleError(err: err)
            })
            .disposed(by: disposeBag)
    }
    
    var viewWillAppearDriver: Driver<Void> {
        return rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriver(onErrorJustReturn: ())
    }
    var refreshTrigger: Driver<Void> {
        return tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .map{[weak self] () -> Bool in self?.tableView.refreshControl!.isRefreshing == true}
            .filter({$0 == true})
            .mapToVoid()
            .asDriver(onErrorJustReturn: ())
    }
    
    var nextPageTrigger: Driver<Void> {
        return tableView.rx.didScrollToBottom
            .throttle(0.4, scheduler: MainScheduler.asyncInstance)
            .filter({[weak self] _ in
                self?.tableView.refreshControl!.isRefreshing != true
            })
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

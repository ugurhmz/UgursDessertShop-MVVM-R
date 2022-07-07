//
//  BaseViewModel.swift
//  ChallengeApp
//
//  Created by ugur-pc on 6.05.2022.
//

import Foundation

protocol BaseViewModelDataSource: AnyObject {}

protocol BaseViewModelEventSource: AnyObject {
    var showActivityIndicatorView: VoidClosure? { get set }
    var hideActivityIndicatorView: VoidClosure? { get set }
    
    var showLoading: VoidClosure? { get set }
    var hideLoading: VoidClosure? { get set }
    
    var showWarningToast: StringClosure? { get set }
}

protocol BaseViewModelProtocol: BaseViewModelDataSource, BaseViewModelEventSource {}

class BaseViewModel<R: Router>: BaseViewModelProtocol {
    
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    
    var showLoading: VoidClosure?
    var hideLoading: VoidClosure?
    
    var showWarningToast: StringClosure?
    
    let router: R
    let dataProvider: DataProviderProtocol
    
    init(router: R, dataProvider: DataProviderProtocol = apiDataProvider) {
        self.router = router
        self.dataProvider = dataProvider
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
    
}

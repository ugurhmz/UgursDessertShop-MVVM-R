//
//  DataProvider.swift
//  ChallengeApp
//
//  Created by ugur-pc on 6.05.2022.
//

#if DEBUG
let apiDataProvider = APIDataProvider(interceptor: APIRequestInterceptor.shared,
                                      eventMonitors: [APILogger.shared])
#else
let apiDataProvider = APIDataProvider(interceptor: APIRequestInterceptor.shared,
                                      eventMonitors: [])
#endif

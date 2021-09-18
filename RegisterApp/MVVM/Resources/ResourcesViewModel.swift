//
//  ResourcesViewModel.swift
//  RegisterApp
//
//  Created by Curitiba01 on 18/09/21.
//

import Foundation
import RxSwift

class ResourcesViewModel {
    func getResources() -> Observable<[Resource]> {
        return ReqressAPI.shared.getResources()
    }
}

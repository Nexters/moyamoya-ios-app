//
//  ProfileViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI
import Combine

protocol ProfileViewDelegate: AnyObject {
    func delete(profile: Profile)
}

struct ProfileViewBuilder {
    
    private var container: DIContainer
    private var viewModel: ProfileViewModel
    private var delegate: ProfileViewDelegate
    
    init(
        _ container: DIContainer,
        delegate: ProfileViewDelegate
    ) {
        self.container = container
        self.delegate = delegate
        
        let useCase = DefaultDeleteProfileUseCase(profileRepository: container.dependency.profileRepository)
        
        self.viewModel = .init(
            container: container,
            useCase: useCase,
            delegate: delegate
        )
    }
    
    var body: some View {
        let view = ProfileView(viewModel: viewModel)
        
        return view
    }
}

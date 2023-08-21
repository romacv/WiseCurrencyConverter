//
//  NetworkManager.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 21-08-2023.
//

import Foundation

class NetworkManager {
    private var currentTask: URLSessionTask?

    func fetchData<T: Decodable>(from url: URL, shouldCancelCurrentTask: Bool = false) async throws -> T {
        if shouldCancelCurrentTask {
            cancelCurrentTask()
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    private func cancelCurrentTask() {
        currentTask?.cancel()
        currentTask = nil
    }
}

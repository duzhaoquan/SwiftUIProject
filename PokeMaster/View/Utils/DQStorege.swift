//
//  DQStorege.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2022/3/20.
//  Copyright © 2022 duzhaoquan. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void

protocol ReadableStorage {
    func fetchValue(for key: String) throws -> Data
    func fetchValue(for key: String, handler: @escaping Handler<Data>)
}

protocol WritableStorage {
    func save(value: Data, for key: String) throws
    func save(value: Data, for key: String, handler: @escaping Handler<String>)
}

protocol DeletableStorage {
    func delete(for key: String) throws
    func delete(for key: String, handler: @escaping Handler<Any>)
    func deleteAll() throws
    func deleteAll(handler: @escaping Handler<Any>)
}

typealias Storage = ReadableStorage & WritableStorage & DeletableStorage

enum StorageError: Error {
    case notFound
    case cantWrite(Error)
}

class DiskStorage {
    private let path: URL
    private let queue: DispatchQueue
    private let fileManager: FileManager
    
    init(
        path: URL,
        queue: DispatchQueue = .init(label: "DiskCache.Queue"),
        fileManager: FileManager = FileManager.default
    ) {
        self.path = path
        self.queue = queue
        self.fileManager = fileManager
    }
    
    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil)
        }
    }
}

extension DiskStorage: WritableStorage {
    func save(value: Data, for key: String) throws {
        let url = path.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try value.write(to: url, options: .atomic)
        } catch {
            throw StorageError.cantWrite(error)
        }
    }
    
    func save(value: Data, for key: String, handler: @escaping Handler<String>) {
        queue.async {
            do {
                try self.save(value: value, for: key)
                handler(.success(key))
            } catch {
                handler(.failure(error))
            }
        }
    }
}

extension DiskStorage: ReadableStorage {
    func fetchValue(for key: String) throws -> Data {
        let url = path.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }
    
    func fetchValue(for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            handler(Result { try self.fetchValue(for: key) })
        }
    }
}

extension DiskStorage: DeletableStorage {
    func delete(for key: String) throws {
        let url = path.appendingPathComponent(key)
        guard let _ = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        try fileManager.removeItem(at: url)
    }
    
    func delete(for key: String, handler: @escaping Handler<Any>) {
        queue.async {
            handler(Result {try self.delete(for: key)})
        }
    }
            
    func deleteAll() throws {
        try fileManager.removeItem(at: path)
    }
    
    func deleteAll(handler: @escaping Handler<Any>) {
        queue.async {
            handler(Result {try self.deleteAll()})
        }
    }
}

class CodableStorage {
    private let path: URL
    private var storage: DiskStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        path: URL = URL(fileURLWithPath:  NSTemporaryDirectory() + "/storage"),
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.path = path
        self.storage = DiskStorage(path: path)
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: key)
        return try decoder.decode(T.self, from: data)
    }
    
    func asyncFetch<T: Decodable>(for key: String, handler:@escaping Handler<T>) {
        storage.fetchValue(for: key) { result in
            handler(Result {try self.decoder.decode(T.self, from: result.get())} )
        }
    }
    
    func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: key)
    }
    
    func asyncSave<T: Encodable>(_ value: T, for key: String, handler:@escaping Handler<String>) {
        do {
            let data = try encoder.encode(value)
            storage.save(value: data, for: key, handler: handler)
        } catch {
            handler(.failure(error))
        }
    }
    
    func delete(for key: String) throws {
        try storage.delete(for: key)
    }
    
    func asyncDelete(for key: String, handler: @escaping Handler<Any>) {
        storage.delete(for: key, handler: handler)
    }
    
    func deleteAll() throws {
        try storage.deleteAll()
    }
    
    func asyncDeleteAll(handler: @escaping Handler<Any>) {
        storage.deleteAll(handler: handler)
    }
}

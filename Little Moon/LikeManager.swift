import Foundation
import Combine

final class LikeManager: ObservableObject {
    static let shared = LikeManager()

    @Published private(set) var likes: [String: Int] = [:]
    @Published private(set) var userLiked: Set<String> = []

    private let countsKey = "like_counts"
    private let userKey = "user_liked_items"

    private init() {
        load()
    }

    func toggleLike(for sound: SoundItem) {
        let key = sound.rawValue
        if userLiked.contains(key) {
            userLiked.remove(key)
            likes[key] = max(0, (likes[key] ?? 0) - 1)
        } else {
            userLiked.insert(key)
            likes[key] = (likes[key] ?? 0) + 1
        }
        persist()
        objectWillChange.send()
    }

    func isLiked(_ sound: SoundItem) -> Bool {
        userLiked.contains(sound.rawValue)
    }

    func likeCount(_ sound: SoundItem) -> Int {
        likes[sound.rawValue] ?? 0
    }

    private func load() {
        let defaults = UserDefaults.standard
        if let savedCounts = defaults.dictionary(forKey: countsKey) as? [String: Int] {
            likes = savedCounts
        }
        if let savedUser = defaults.array(forKey: userKey) as? [String] {
            userLiked = Set(savedUser)
        }
    }

    private func persist() {
        let defaults = UserDefaults.standard
        defaults.set(likes, forKey: countsKey)
        defaults.set(Array(userLiked), forKey: userKey)
    }
}

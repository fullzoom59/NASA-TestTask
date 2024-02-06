import UIKit

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func downloadImage(from url: URL, imageSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                let scaledImage = self.scaleImage(image, toSize: imageSize)
                
                self.cache.setObject(scaledImage, forKey: url as NSURL)
                DispatchQueue.main.async {
                    completion(scaledImage)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    private func scaleImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage {
        let aspectWidth = newSize.width / image.size.width
        let aspectHeight = newSize.height / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let scaledSize = CGSize(width: image.size.width * aspectRatio, height: image.size.height * aspectRatio)
        let renderer = UIGraphicsImageRenderer(size: scaledSize)

        let scaledImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: scaledSize))
        }

        return scaledImage
    }
    
    public func clearCache() {
        cache.removeAllObjects()
    }
    
}

import Foundation

protocol VideoViewModelDelegate: class {
    func loadVideoList()
}

class VideoViewModel: NSObject {
    weak var delegate: VideoViewModelDelegate?
    
    private(set) var videos: [Video]? = nil {
        didSet {
            delegate?.loadVideoList()
        }
    }
    
    func fetchVideoList() {
        guard let url = URL(string: Constants.ExternalHyperlinks.videoCategory) else {
            return
        }
        
        APIClient.getVideos(url: url) { result in
            switch result {
            case .success(let videos):
                self.videos = videos
            case .failure(let error):
                print(error)
            }
        }
    }
}

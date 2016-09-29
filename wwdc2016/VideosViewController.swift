//
//  VideosViewController.swift
//  wwdc2016
//
//  Created by Daniele Vitali on 29/09/2016.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    var videoServices: VideoServicesContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoServices.getVideos { [unowned self] (result) in
            switch result {
            case .error(let error):
                print(error)
            case .data(let data):
                DispatchQueue.main.async {
                    self.videos = data
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension VideosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let video = videos[indexPath.row]
        cell.titleLabel.text = video.title
        cell.platformsLabel.text = video.platforms.joined(separator: ", ")
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: video.imageUrl),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let updatedCell = tableView.cellForRow(at: indexPath) as? VideoCell {
                        updatedCell.thumbImageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: video.videoUrl)
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

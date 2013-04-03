$.getJSON('/videos.json', function(data){
  Videos.setVideos(data.videos);
  dispatcher.trigger('videos_loaded');
});

$.getJSON('http://localhost:3000/show/data/' + showId + '.json', function(data){
  Videos.setVideos(data.videos);
  dispatcher.trigger('videos_loaded');
}).fail(function() {console.log('failed fetching videos')});
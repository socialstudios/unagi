//    This code loads the IFrame Player API code asynchronously.
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

//    This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '390',
    width: '640',
    events: {
      'onReady': function() {
        if (Videos.isReady()) {
          startSequence();
        }
      },
      'onStateChange': onPlayerStateChange
    }
  });
}

//    The API calls this function when the player's state changes.
//    The function indicates that when playing a video (state=1),
//    the player should play for six seconds and then stop.
var done = false;
function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.ENDED && Videos.hasNext()) {
    event.target.loadVideoById(Videos.next(), 0, "large");
  }
}

function startSequence() {
  player.loadVideoById(Videos.next(), 0, "large");
  player.playVideo();
}

dispatcher.on('videos_loaded',function() {
  if (player) {
    startSequence();
  }
});

// Iterator implementation, couldn't find one!!
var Videos = (function() {

  var index = -1;
  var videos = null;

  function next() {
    index++;
    if (hasNext()) {
      return videos[index];
    }
  }

  function setVideos(data) {
    videos = data;
  }

  function hasNext() {
    if (videos.length > index) {
      return true;
    }
    return false;
  }

  function isReady() {
    return (videos) ? true : false;
  }

  return {
    next:next,
    setVideos:setVideos,
    hasNext:hasNext,
    isReady:isReady
  };
}());

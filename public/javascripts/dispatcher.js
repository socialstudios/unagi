/**
 A central event dispatcher for our program.

 To register for events:

     // Call the function reportStopped when getting the event player:stopped
     dispatcher.on("player:stopped", reportStopped);
     // Or call the analytics.reportStop
     dispatcher.on("player:stopped", analytics.reportStop, analytics);

     // Trigger the event "player:playing" with extra data: '123'
     dispatcher.trigger("player:playing", {data: '123'})
 */

var dispatcher = _.clone( Backbone.Events );
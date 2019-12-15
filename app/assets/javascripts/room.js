if(/room/.test(window.location.pathname)) {
  var path = window.location.pathname.split('/');
  var room_id = path[path.length - 1];
  App.room = App.cable.subscriptions.create({ channel: "RoomChannel", room_id: room_id }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
        $('.messages').append(data['content']);
        $('#message-container').animate({ scrollTop: $('#message-container')[0].scrollHeight});
        var another_user_id = $("#another_user_id").text();
        if (data['user_id'] != another_user_id ){
          
        }

    },
    speak: function(message) {
      return this.perform('speak', {
        message: message,
        room_id: room_id,
      });
    }
  });
  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode === 13) {
      App.room.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
}
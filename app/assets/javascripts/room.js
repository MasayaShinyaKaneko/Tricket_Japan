if(/room/.test(window.location.pathname)) {
  var path = window.location.pathname.split('/');
  var room_id = path[path.length - 1];
  App.room = App.cable.subscriptions.create({ channel: "RoomChannel", room_id: room_id }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
        // var message_content = $('.messages').append(data['content']);
        var message_content = $(data['content']).appendTo('.messages');
        $('#message-container').animate({ scrollTop: $('#message-container')[0].scrollHeight});
        var another_user_id = $("#another_user_id").text();
        if (data['user_id'] != another_user_id ){
          message_content.find("div.message-items-right").removeClass("message-items-right").addClass("message-items-left");
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
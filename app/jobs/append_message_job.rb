class AppendMessageJob < ApplicationJob
  include CableReady::Broadcaster

  queue_as :default

  def perform(message, max_messages = 10)
    cable_ready["room"].insert_adjacent_html(
      selector: "#messages",
      position: "beforeend",
      html: (ApplicationController.render partial: "messages/message", locals: { message: message })
    )
    cable_ready["room"].set_property(
      selector: "#message_content",
      name: "value",
      value: ""
    )

    if Message.count > max_messages
      cable_ready["room"].remove(
        selector: "div.message"
      )
    end

    cable_ready.broadcast
  end
end

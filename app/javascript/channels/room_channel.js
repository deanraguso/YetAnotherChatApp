import consumer from "./consumer"
import CableReady from "cable_ready"

consumer.subscriptions.create("RoomChannel", {
  connected(){
    console.log("Connected to Room")
  },
  received(data) {
    if (data.cableReady) CableReady.perform(data.operations)
  }
});
